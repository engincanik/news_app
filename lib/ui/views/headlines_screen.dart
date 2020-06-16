import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapp/business_logic/view_models/headlines_screen_viewmodel.dart';
import 'package:newsapp/services/service_locator.dart';
import 'package:newsapp/ui/views/headlines_detail_screen.dart';
import 'package:newsapp/ui/widgets/headlines_screen_language_icon.dart';
import 'package:newsapp/util/common_string.dart';
import 'package:provider/provider.dart';

class HeadlinesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  HeadlinesScreenViewModel model = serviceLocator<HeadlinesScreenViewModel>();
  
  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HeadlinesScreenViewModel>(
      create: (context) => model,
      child: Consumer<HeadlinesScreenViewModel>(
          builder: (context, model, child) {
            return _buildScaffold(context);
          }
    ));
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(CommonString.app_bar_title, style: TextStyle(fontSize: 24.0)),
          actions: <Widget>[
            HeadlinesScreenLanguageIcon(model),
          ],
        ),
        body: model.isLoading == true
            ? Center(child: CircularProgressIndicator())
            : _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return model.headlines == null
        ? _buildInternetErrorMessage(context)
        : _buildListView(context);
  }

  Widget _buildListView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: model.headlines.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Column(
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
                      model.headlines[index].title,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: FadeInImage.assetNetwork(
                            placeholder: 'assets/photos/photo_placeholder.png',
                            image: model.headlines[index].urlToImage)),
                  ],
                ),
                subtitle: Text(model.headlines[index].author),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HeadlinesDetailScreen(model.headlines[index])));
                },
              ),
            );
          }),
    );
  }

  Widget _buildInternetErrorMessage(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              CommonString.get_top_headlines_error_message,
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.green,
              ),
              onPressed: () {
                model.loadData();
              },
            )
          ],
        ),
      ),
    );
  }
}


