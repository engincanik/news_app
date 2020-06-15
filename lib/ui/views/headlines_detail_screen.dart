import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/business_logic/models/article.dart';
import 'package:newsapp/util/common_string.dart';

class HeadlinesDetailScreen extends StatelessWidget {
  Article article;

  HeadlinesDetailScreen(this.article);

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(CommonString.detail_app_bar_title, style: TextStyle(fontSize: 28.0)),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, int) =>
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      CommonString.headline,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 16.0),
                      textAlign: TextAlign.left,
                    )),
                Text(
                  article.title ?? "",
                  style: TextStyle(fontSize: 20.0),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
//                        child: Image.network(model.headlines[index].urlToImage))
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/photos/photo_placeholder.png',
                      image: article.urlToImage ??
                          'assets/photos/photo_placeholder.png',
                    )),
                Text(article.description ?? "", style: TextStyle(fontSize: 18.0,height: 2.0),),
                Padding(
                  padding: EdgeInsets.only(top: 32.0),
                  child: Text(article.publishedAt ?? ""),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(article.author ?? ""),
                )
              ],
            ),
          ),
//          subtitle: Text(article.author ?? ""),
    );
  }
}
