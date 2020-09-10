import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/GeneralWidgets/ProgressIndicator.dart';
import 'package:news/Models/News.dart';
import 'package:news/Widgets/HeadlineNewsTile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart' as refresh;

class HeadlineNewsList extends StatefulWidget {
  final Function onRefresh;
  final Function loadMoreData;
  final int newsListMaxCount;
  final List<News> news;
  final Curve curve;
  HeadlineNewsList({
    Key key,
    this.onRefresh,
    this.loadMoreData,
    this.newsListMaxCount,
    this.news,
    this.curve,
  }) : super(key: key);

  @override
  _HeadlineNewsListState createState() => _HeadlineNewsListState();
}

class _HeadlineNewsListState extends State<HeadlineNewsList>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          widget.news.length + 5 < widget.newsListMaxCount)
        widget.loadMoreData();
    });
  }

  @override
  void dispose() {
    super.dispose();

    scrollController.removeListener(() {});
    scrollController.dispose();
  }

  _launchURL(String url) async {
    try {
      if (await canLaunch(url))
        await launch(
          url,
          forceWebView: true,
          enableJavaScript: true,
        );
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Url Broken !',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black.withOpacity(0.9),
        ),
      );
      throw 'Url Broken !';
    }
  }

  @override
  Widget build(BuildContext context) {
    return refresh.LiquidPullToRefresh(
      backgroundColor: Colors.amber,
      color: Colors.black,
      onRefresh: widget.onRefresh,
      showChildOpacityTransition: false,
      animSpeedFactor: 5,
      child: Container(
        child: widget.news.length != 0
            ? Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  cacheExtent: 200,
                  itemExtent: 170,
                  controller: scrollController,
                  // shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == widget.news.length) {
                      if (widget.news.length + 5 < widget.newsListMaxCount)
                        return BuildProgressIndicator();
                      return Center(
                        child: Text(
                          'All Caught Up',
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () => _launchURL(widget.news[index].url),
                      child: NewsHeadLineTile(
                        news: widget.news[index],
                        curve: widget.curve,
                      ),
                    );
                  },
                  itemCount: widget.news.length + 1,
                ),
              )
            : Center(
                child: Text(
                  'NO\nHEADLINES\nAVAILABLE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
