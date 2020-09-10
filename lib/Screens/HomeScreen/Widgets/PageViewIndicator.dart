import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news/Models/News.dart';
import 'package:news/Widgets/CoverTile.dart';
import 'package:page_indicator/page_indicator.dart';

class PageViewIndicatorCover extends StatefulWidget {
  final List<News> news;
  const PageViewIndicatorCover({Key key, this.news}) : super(key: key);
  @override
  _PageViewIndicatorCoverState createState() =>
      _PageViewIndicatorCoverState(news);
}

class _PageViewIndicatorCoverState extends State<PageViewIndicatorCover> {
  final List<News> news;

  _PageViewIndicatorCoverState(this.news);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Stack(
        children: <Widget>[
          PageIndicatorContainer(
            length: min(widget.news.length, 5),
            indicatorColor: Colors.grey,
            indicatorSelectorColor: Colors.amber,
            indicatorSpace: 5,
            padding: const EdgeInsets.only(bottom: 15),
            shape: IndicatorShape.circle(size: 8),
            pageView: PageView.builder(
              itemBuilder: (context, index) => CoverTile(news: news[index]),
              itemCount: min(widget.news.length, 5),
            ),
          ),
        ],
      ),
    );
  }
}
