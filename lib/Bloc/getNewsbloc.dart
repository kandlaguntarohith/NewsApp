import 'package:news/Models/NewsResponse.dart';
import 'package:news/Respiratory/Respiratory.dart';
import 'package:rxdart/rxdart.dart';

class GetNewsListBloc {
  NewsResponse newsResponse;
  Respiratory _respiratory = Respiratory();
  final BehaviorSubject<NewsResponse> _subject =
      BehaviorSubject<NewsResponse>();
  getHeadLines([int pageNo = 1, String category = 'general']) async {
    NewsResponse _newsResponse =
        await _respiratory.getHeadlinesFunction(pageNo, category);
    if (pageNo != 1) {
      newsResponse.news.addAll(_newsResponse.news);
    } else
      newsResponse = _newsResponse;
    _subject.sink.add(newsResponse);
  }

  getsearchHeadLines([int pageNo = 1, String searchQuery]) async {
    NewsResponse _newsResponse =
        await _respiratory.getSearchHeadlinesFunction(pageNo, searchQuery);
    if (pageNo != 1) {
      newsResponse.news.addAll(_newsResponse.news);
    } else
      newsResponse = _newsResponse;
    _subject.sink.add(newsResponse);
  }

  dispose() async {
    _subject.value = null;
    await _subject.close();
  }

  drain() async {
    _subject.value = null;
    await _subject.drain();
  }

  BehaviorSubject<NewsResponse> get subject => _subject;
}

final newsHeadlineBlocList = GetNewsListBloc();
