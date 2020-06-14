import 'package:newsapp/business_logic/models/article.dart';
import 'package:newsapp/services/top_headlines/top_headlines_services.dart';

class TopHeadlinesServicesException implements TopHeadlinesService {
  @override
  Future<List<Article>> changeHeadlinesLanguage(String countryCode) async {
    return Future.delayed(Duration(milliseconds: 5000), () => <Article>[]);
  }

  @override
  Future<List<Article>> getTopHeadlines(String countryCode) async {
    return Future.delayed(Duration(milliseconds: 5000), () => <Article>[]);
  }

}