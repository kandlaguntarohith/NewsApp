class News {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String content;
  final String sourceName;

  News(
    this.author,
    this.title,
    this.description,
    this.urlToImage,
    this.url,
    this.publishedAt,
    this.content,
    this.sourceName,
  );
  News.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        title = json['title'],
        description = json['description'],
        url = json['url'],
        urlToImage = json['urlToImage'],
        publishedAt = json['publishedAt'],
        content = json['content'],
        sourceName = json['source']['name'];
}
