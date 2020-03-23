import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:map1/assets/news_data.json' as response;
import 'package:http/http.dart' as http;
import 'articleCard.dart';
import 'package:map1/model/news.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> with AutomaticKeepAliveClientMixin<Carousel> {
  static final String apiKey = "c9ba6fc660314ec5a0ae56e5cbcf61a2";
  final String apiUrl = "http://newsapi.org/v2/top-headlines?country=my&category=sports&apiKey=$apiKey";
  //final Map result = jsonDecode();
  List<Article> _articles = List<Article>();

  // Future fetchNews() async {
  //   final response = await http.get(apiUrl);
  //   var jsonResponse = jsonDecode(response.body.toString());
  //   News news = new News.fromJson(jsonResponse);
  //   List<Article> articles = news.articles;

  //   if (response.statusCode == 200) {
  //     print("API fetched successfully");
  //     for (var i=0; i<articles.length; i++) {
  //       print(articles[i].title);
  //     }
  //   } else {
  //     throw Exception('Failed to translate text');
  //   }
  //   return articles;
  // }

  @override
  void initState() {
    loadNews().then((value) {
      setState(() {
        _articles.addAll(value);
      });
    });
    super.initState();
  }

  //
  Future<String> _loadNewsJSON() async {
    return await rootBundle.loadString('assets/news_data.json');
  }

  Future loadNews() async {
    await wait(3);
    String jsonString = await _loadNewsJSON();
    final jsonResponse = json.decode(jsonString);
    
    News news = new News.fromJson(jsonResponse);
    List<Article> articles = news.articles;
    print(articles.length);
    return articles;
  }

  Future wait (int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }
  //

  @override
  Widget build(BuildContext context) {
    return FutureBuilder (
      future: loadNews(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 234,
            // color: Colors.orange,
            child: ListView.builder(
              itemCount: 5,
              // itemCount: _articles.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var article = _articles[index];
                return ArticleCard(
                  isLoaded: true,
                  title: article.title,
                  url: article.url,
                  image: article.urlToImage,
                );
              },
              
            )
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Container(
          height: 234,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ArticleCard(
                isLoaded: false,
                title: null,
                url: null,
                image: null
              );
            },   
          ),
        );
        //return Center(child: CircularProgressIndicator());
      },
    );


    


  }
  @override
  bool get wantKeepAlive => true;
}