import 'package:newsapp/business_logic/models/article.dart';

abstract class TopHeadlinesService {

  Future<List<Article>> getTopHeadlines(String countryCode);
  Future<List<Article>> changeHeadlinesLanguage(String countryCode);
}

