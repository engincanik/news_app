import 'package:newsapp/business_logic/models/article.dart';
import 'package:newsapp/services/top_headlines/top_headlines_services.dart';
import 'package:http/http.dart' as http;
import 'file:///D:/Eric/Flutter/news_app/lib/util/common_string.dart';
import 'dart:convert';

class TopHeadlinesServiceImpl implements TopHeadlinesService {
  List<Article> _headlinesCache;

  @override
  Future<List<Article>> getTopHeadlines(String countryCode) async {
    if (_headlinesCache == null) {
      final results = await http.get(CommonString.headline_url +
          CommonString.query +
          CommonString.country_query +
          countryCode +
          CommonString.and +
          CommonString.apiKey_query +
          CommonString.apiKey);
      final jsonObject = json.decode(results.body);
      _headlinesCache = _createArticleListFromRawMap(jsonObject);
    } else {
      print("getting headlines from cache");
    }
    //return cached info
    return _headlinesCache;
  }

  @override
  Future<List<Article>> changeHeadlinesLanguage(String countryCode) async {

      final results = await http.get(CommonString.headline_url +
          CommonString.query +
          CommonString.country_query +
          countryCode +
          CommonString.and +
          CommonString.apiKey_query +
          CommonString.apiKey);
      final jsonObject = json.decode(results.body);
      _headlinesCache = _createArticleListFromRawMap(jsonObject);
    return _headlinesCache;
  }

  List<Article> _createArticleListFromRawMap(jsonObject) {
    final articles = jsonObject['articles'];
    List<Article> list = [];

    for (var article in articles) {
      list.add(Article(
          author: article['author'],
          title: article['title'],
          content: article['content'],
          description: article['description'],
          publishedAt: article['publishedAt'],
          urlToImage: article['urlToImage']));
    }
    return list;
  }
}
