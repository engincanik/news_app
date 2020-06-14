
import 'package:get_it/get_it.dart';
import 'package:newsapp/business_logic/view_models/headlines_screen_viewmodel.dart';
import 'package:newsapp/services/location/location_services.dart';
import 'package:newsapp/services/location/location_services_impl.dart';
import 'package:newsapp/services/permission/permission_services.dart';
import 'package:newsapp/services/permission/permission_services_impl.dart';
import 'package:newsapp/services/storage/shared_preferences/shared_preferences_services.dart';
import 'package:newsapp/services/storage/shared_preferences/shared_preferences_services_impl.dart';
import 'package:newsapp/services/top_headlines/top_headlines_services.dart';
import 'package:newsapp/services/top_headlines/top_headlines_services_exception.dart';
import 'package:newsapp/services/top_headlines/top_headlines_services_impl.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {

  //services
  serviceLocator.registerLazySingleton<TopHeadlinesService>(() => TopHeadlinesServiceImpl());
  serviceLocator.registerLazySingleton<PermissionServices>(() => PermissionServicesImpl());
  serviceLocator.registerLazySingleton<LocationService>(() => LocationServicesImpl());
  serviceLocator.registerLazySingleton<SharedPreferencesServices>(() => SharedPreferencesServicesImpl());

  //view models
  serviceLocator.registerFactory<HeadlinesScreenViewModel>(() => HeadlinesScreenViewModel());
}