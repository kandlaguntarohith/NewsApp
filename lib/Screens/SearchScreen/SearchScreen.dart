import 'package:flutter/material.dart';
import 'package:news/Bloc/getNewsbloc.dart';
import 'package:news/GeneralWidgets/ErrorDisplayWidget.dart';
import 'package:news/GeneralWidgets/ProgressIndicator.dart';
import 'package:news/Models/NewsResponse.dart';
import 'package:news/Widgets/HeadlineNewsList.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller;
  bool _load = false;
  int pageNo;
  var searchNewsFeed = GetNewsListBloc();
  String previousQuery;
  @override
  void initState() {
    previousQuery = '';
    pageNo = 1;
    _controller = TextEditingController()
      ..addListener(() {
        final query = _controller.text.trim();
        if (query.length > 0 && previousQuery != query) {
          setState(() {
            _load = true;
          });
          searchNewsFeed.drain();
          searchNewsFeed.getsearchHeadLines(pageNo, _controller.text);
          previousQuery = query;
        } else if (previousQuery != query || query == null) {
          searchNewsFeed.drain();
          setState(() {
            _load = false;
          });
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    searchNewsFeed.dispose();
    super.dispose();
  }

  void loadMoreData() {
    searchNewsFeed.getsearchHeadLines(++pageNo, _controller.text);
  }

  Future<void> onRefresh() async {
    pageNo = 1;
    searchNewsFeed.drain();
    searchNewsFeed.getsearchHeadLines(pageNo, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        // excludeHeaderSemantics: true,
        flexibleSpace: Container(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        title: TextField(
          cursorColor: Colors.amber,
          autofocus: true,
          controller: _controller,
          style: TextStyle(
            height: 1.5,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.search,
              color: Colors.amber,
            ),
            hintText: '  Search Flash News',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            // alignLabelWithHint: false,
          ),
        ),
      ),
      body: StreamBuilder<NewsResponse>(
        stream: searchNewsFeed.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0)
              return BuildErrorDisplayWidget(error: snapshot.data.error);
            else
              return HeadlineNewsList(
                loadMoreData: loadMoreData,
                onRefresh: onRefresh,
                newsListMaxCount: snapshot.data.responseListLength,
                news: snapshot.data.news,
                curve: Curves.elasticOut,
              );
          } else if (snapshot.hasError)
            return BuildErrorDisplayWidget(error: snapshot.error);
          return _load
              ? BuildProgressIndicator()
              : Center(
                  child: Text(
                    'Search a Keyword',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
        },
      ),
    );
  }
}
