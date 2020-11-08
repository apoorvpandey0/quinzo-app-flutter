import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class News with ChangeNotifier {}

class Articles with ChangeNotifier {
  List<Article> articles = [];

  Articles({this.articles});

  Articles.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = new List<Article>();
      json['articles'].forEach((v) {
        // print(v);
        articles.add(Article.fromJson(v));
        // print(articles.length);
      });
    }
  }

  setArticlesFromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = new List<Article>();
      json['articles'].forEach((v) {
        // print(v);
        articles.add(Article.fromJson(v));
        // print(articles.length);
      });
    }
    // loaded = articles;
    // print(articles);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Future<void> getAndSetArticles() async {
    final url = 'http://newsapi.org/v2/top-headlines?' +
        'country=in&' +
        'apiKey=c28a2ae746814b82995771ad144d96a4';
    final response = await http.get(url);
    // print(json.decode(response.body)['articles']);
    setArticlesFromJson(json.decode(response.body));
    // print(response.body);
    // print(articles);
    print("Articles updates");
  }
}

class Article with ChangeNotifier {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Article.fromJson(Map<String, dynamic> json) {
    // print(json);
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }
}

class Source with ChangeNotifier {
  String id;
  String name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
