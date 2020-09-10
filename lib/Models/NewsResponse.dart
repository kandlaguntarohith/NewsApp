import 'News.dart';

class NewsResponse {
  final List<News> news;
  final String error;
  final int responseListLength;
  NewsResponse(
    this.news,
    this.error,
    this.responseListLength,
  );
  NewsResponse.fromJson(Map<String, dynamic> json)
      : news = (json['articles'] as List).map((e) => News.fromJson(e)).toList(),
        error = '',
        responseListLength = json['totalResults'];
  NewsResponse.withError(String error)
      : news = List(),
        error = error,
        responseListLength = 0;
}
