import 'package:flutter/material.dart';
import 'file:///D:/Eric/Flutter/news_app/lib/util/common_string.dart';
import 'package:newsapp/services/location/location_services.dart';
import 'package:newsapp/services/permission/permission_services.dart';
import 'package:newsapp/services/service_locator.dart';
import 'package:newsapp/services/storage/shared_preferences/shared_preferences_services.dart';
import 'package:newsapp/ui/views/headlines_screen.dart';

void main() {
  setupServiceLocator();
  runApp(NewsApp());
}

class NewsApp extends StatefulWidget {
  @override
  _NewsAppState createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  bool _finishPermission = false;

  PermissionServices _permissionServices = serviceLocator<PermissionServices>();
  LocationService _locationService = serviceLocator<LocationService>();
  SharedPreferencesServices _sharedPreferencesServices = serviceLocator<SharedPreferencesServices>();

  Future<void> _initApp() async {
    final isPermitted = await _permissionServices.requestLocationPermission();
    if(isPermitted == null) {
      await _sharedPreferencesServices.saveCountryCode(CommonString.defaultCountry);}
    if(isPermitted) {
      final hwLocation = await _locationService.getHWLocation();
      if(hwLocation != null) {
        await _sharedPreferencesServices.saveCountryCode(hwLocation.countryCode);
      }
    } else {
      await _sharedPreferencesServices.saveCountryCode(CommonString.defaultCountry);
    }
  }

  void _onFinishPermission() {
    setState(() {
      _finishPermission = true;
    });
  }

  @override
  void initState() {
    _initApp().whenComplete(() => _onFinishPermission());
    super.initState();
  }
  
  Widget _buildLaunchScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(CommonString.app_bar_title,style:TextStyle(fontSize: 24.0)), centerTitle: true,),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App",
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: _finishPermission ? HeadlinesScreen() : _buildLaunchScreen(context)
    );
  }
}