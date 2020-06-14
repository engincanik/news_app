abstract class SharedPreferencesServices {
  Future<void> saveCountryCode(String countryCode);
  Future<String> getCountryCode();
}