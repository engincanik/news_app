import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/business_logic/view_models/headlines_screen_viewmodel.dart';
import 'package:newsapp/util/common_string.dart';

class HeadlinesScreenLanguageIcon extends StatelessWidget {
  final HeadlinesScreenViewModel model;
  final _scrollController = ScrollController();
  bool _shouldAutoScroll = true;

  HeadlinesScreenLanguageIcon(this.model);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.language,
        color: Colors.white70,
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => _buildBottomSheet(context),
          elevation: 8.0,
        );
        _shouldAutoScroll = true;
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
        height: 300,
        child: Stack(children: <Widget>[
          Container(
            height: 30.0,
            width: double.infinity,
            color: Colors.black54,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ))),
          Column(
            children: <Widget>[
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    CommonString.language_bottom_sheet_header,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Container(
                  height: 250,
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: model.countryList.length,
                      itemBuilder: (context, index) {
                        if (_shouldAutoScroll) {
                          Timer(
                              Duration(microseconds: 500),
                              () => _scrollController.animateTo(
                                  50.0 * (model.countryIndex - 2),
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.linear));
                          _shouldAutoScroll = false;
                        }
                        return Container(
                          height: 50,
                          child: ListTile(
                            title: model.countryIndex == index
                                ? Text(
                                    model.countryList[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
                                    model.countryList[index],
                                    textAlign: TextAlign.center,
                                  ),
                            onTap: () {
                              model.changeLanguage(index);
                              model.setCountryIndex(index);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      })),
            ],
          ),
        ]));
  }
}
