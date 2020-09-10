import 'package:flutter/material.dart';
import 'package:news/Models/News.dart';
import 'package:news/Screens/NewsDetailedScreen.dart/Widgets/DetailedScreenContentText.dart';
import 'package:news/Screens/NewsDetailedScreen.dart/Widgets/DetailedScreenCoverPage.dart';
import 'package:news/Screens/NewsDetailedScreen.dart/Widgets/DetailedScreenNewsHeadline.dart';

class NewsDetailedScreen extends StatelessWidget {
  final News news;

  const NewsDetailedScreen({Key key, this.news}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          DetailedScreenCoverPage(imgUrl: news.urlToImage),
          SizedBox(height: 20),
          DetailedScreenHeadlineText(headlineText: news.description),
          SizedBox(height: 30),
          DetailedScreenContentText(contentText: news.content),
        ],
      ),
    );
  }
}
