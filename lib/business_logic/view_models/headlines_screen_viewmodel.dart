
import 'package:flutter/cupertino.dart';
import 'package:newsapp/business_logic/models/article.dart';
import 'package:newsapp/services/service_locator.dart';
import 'package:newsapp/services/storage/shared_preferences/shared_preferences_services.dart';
import 'package:newsapp/services/top_headlines/top_headlines_services.dart';
import 'package:newsapp/util/common_string.dart';

class HeadlinesScreenViewModel extends ChangeNotifier {
  final TopHeadlinesService _topHeadlinesService =
      serviceLocator<TopHeadlinesService>();
  final SharedPreferencesServices _sharedPreferencesServices =
      serviceLocator<SharedPreferencesServices>();

  List<Article> _headlines;
  String _countryCode;
  bool _isLoading = false;
  int _countryIndex = _countries.values.toList().indexOf(CommonString.defaultCountry);
  static Map<String, String> _countries = CommonString.countries;

  void setCountryIndex(int index) {
    _countryIndex = index;
    notifyListeners();
  }

  List<String> get countryList {
    return _countries.keys.toList();
  }

  int get countryIndex {
    return _countryIndex;
  }


  void loadData() async {
    _setIsLoading(true);
    final _countryCode = await _sharedPreferencesServices
        .getCountryCode()
        .timeout(Duration(milliseconds: 2000), onTimeout: () => CommonString.defaultCountry);
    _headlines = await _topHeadlinesService
        .getTopHeadlines(_countryCode)
        .timeout(Duration(milliseconds: 2000), onTimeout: () => null);
    _setIsLoading(false);
  }

  void changeLanguage(int index) async {
    _setIsLoading(true);
    _headlines = await _topHeadlinesService
        .changeHeadlinesLanguage((_countries.values.toList())[index])
        .timeout(Duration(milliseconds: 2000),
            onTimeout: () => null);
    _countryCode = (_countries.values.toList())[index];
    _setIsLoading(false);
  }

  void _setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }

  String get countryCode {
    return _countryCode.toUpperCase();
  }

  List<Article> get headlines {
    var list = _headlines;
    if(list != null) {
      for (Article headline in list) {
        if (headline.title == null) headline.title = "";
        if (headline.urlToImage == null)
          headline.urlToImage = "assets/photos/photo_placeholder.png";
        if (headline.author == null) headline.author = "";
      }
    }
    return list;
  }
}
