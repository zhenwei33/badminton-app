
class News {
  final List<Article> articles;
  News({this.articles});

  factory News.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['articles'] as List;
    List<Article> articleList = list.map((i) => Article.fromJson(i)).toList();

    return News(
      articles: articleList
    );
  }
}

class Article {
  final String title;
  final String url;
  final String urlToImage;
  Article({this.title, this.url, this.urlToImage});

  factory Article.fromJson(Map<String, dynamic> parsedJson) {
    return Article(
      title: parsedJson['title'],
      url: parsedJson['url'],
      urlToImage: parsedJson['urlToImage']
    );
  }
}