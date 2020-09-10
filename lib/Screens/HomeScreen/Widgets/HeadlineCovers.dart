import 'package:flutter/material.dart';
import 'package:news/Bloc/getNewsbloc.dart';
import 'package:news/GeneralWidgets/ErrorDisplayWidget.dart';
import 'package:news/GeneralWidgets/ProgressIndicator.dart';
import 'package:news/Models/News.dart';
import 'package:news/Models/NewsResponse.dart';
import 'CategoriesList.dart';
import '../../../Widgets/HeadlineNewsList.dart';
import 'PageViewIndicator.dart';

class HeadlineCovers extends StatefulWidget {
  @override
  _HeadlineCoversState createState() => _HeadlineCoversState();
}

class _HeadlineCoversState extends State<HeadlineCovers> {
  int pageNo;
  String category;
  @override
  void initState() {
    super.initState();

    category = 'general';
    pageNo = 1;
    newsHeadlineBlocList.getHeadLines(pageNo, category);
  }

  @override
  void dispose() {
    super.dispose();
    newsHeadlineBlocList.drain();
  }

  void loadMoreData() {
    newsHeadlineBlocList.getHeadLines(++pageNo, category);
  }

  Future<void> onRefresh() async {
    pageNo = 1;
    newsHeadlineBlocList.drain();
    await newsHeadlineBlocList.getHeadLines(pageNo, category);
  }

  void selectedCategory(String category) {
    if (this.category != category) {
      pageNo = 1;
      newsHeadlineBlocList.drain();
      this.category = category;
      newsHeadlineBlocList.getHeadLines(pageNo, category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NewsResponse>(
      stream: newsHeadlineBlocList.subject.stream,
      builder: (context, snapshot) {
        bool error = false;
        bool isLoading = false;
        List<News> data;
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0)
            error = true;
          else
            data = snapshot.data.news.length == 0 ? [] : snapshot.data.news;
        } else if (snapshot.hasError)
          error = true;
        else
          isLoading = true;
        return Column(
          children: <Widget>[
            Container(
              height: 220,
              child: error
                  ? BuildErrorDisplayWidget(error: 'Error Occured')
                  : isLoading
                      ? BuildProgressIndicator()
                      : PageViewIndicatorCover(news: data.sublist(0, 5)),
            ),
            SizedBox(height: 15),
            CategoriesList(
                selectedCategory: selectedCategory, category: category),
            SizedBox(height: 20),
            Expanded(
              child: error
                  ? BuildErrorDisplayWidget(
                      error: 'Error Occured',
                    )
                  : isLoading
                      ? BuildProgressIndicator()
                      : HeadlineNewsList(
                          loadMoreData: loadMoreData,
                          onRefresh: onRefresh,
                          news: (data.sublist(5)),
                          newsListMaxCount: snapshot.data.responseListLength,
                          curve: Curves.fastLinearToSlowEaseIn,
                          // curve: Curves.fastOutSlowIn,
                        ),
            ),
          ],
        );
      },
    );
  }
}
