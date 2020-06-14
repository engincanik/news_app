import 'package:newsapp/services/storage/shared_preferences/shared_preferences_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///D:/Eric/Flutter/news_app/lib/util/common_string.dart';

class SharedPreferencesServicesImpl implements SharedPreferencesServices {

  @override
  Future<String> getCountryCode() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(CommonString.sf_country_code);
  }

  @override
  Future<void> saveCountryCode(String countryCode) async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString(CommonString.sf_country_code, countryCode.toLowerCase());
  }

}