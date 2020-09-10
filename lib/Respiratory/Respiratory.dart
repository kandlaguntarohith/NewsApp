import 'package:dio/dio.dart';
import 'package:news/Models/NewsResponse.dart';

class Respiratory {
  final Dio _dio = Dio();
  static const baseUrl = 'https://newsapi.org/v2';
  static const apiKey = '5ea3c62bd7854a77875712ec7c90586d';
  var getHeadlines = '$baseUrl/top-headlines';
  var getSearchFeed = '$baseUrl/everything';
  Future<NewsResponse> getHeadlinesFunction(
      [int pageNo = 1, String category = 'general']) async {
    var parameters = {
      'country': 'in',
      'apiKey': apiKey,
      'page': pageNo,
      'category': category,
    };
    try {
      Response response = await _dio.get(
        getHeadlines,
        queryParameters: parameters,
      );
      // print("Response :" + response.data.toString());
      return NewsResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Error Occured : $error stacktrace : $stackTrace');
      return NewsResponse.withError(error.toString());
    }
  }

  Future<NewsResponse> getSearchHeadlinesFunction(
      [int pageNo = 1, String searchQuery]) async {
    print(searchQuery);
    var parameters = {
      'apiKey': apiKey,
      'page': pageNo,
      'q': searchQuery,
    };
    try {
      Response response = await _dio.get(
        getSearchFeed,
        queryParameters: parameters,
      );
      // print("Response :" + response.data.toString());
      return NewsResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Error Occured : $error stacktrace : $stackTrace');
      return NewsResponse.withError(error.toString());
    }
  }
}
