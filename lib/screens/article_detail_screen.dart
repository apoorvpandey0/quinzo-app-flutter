import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/news.dart';

class ArticleDetailScreen extends StatelessWidget {
  static const routeName = 'article-detail';
  // Article article;
  // ArticleDetailScreen(this.article);

  @override
  Widget build(BuildContext context) {
    // final article = Provider.of<Articles>(context, listen: false).articles[0];
    final Article article = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: article, child: Image.network(article.urlToImage)),
            Text(article.title),
            Text(article.source.name == null
                ? 'Anoynomous'
                : article.source.name),
            Text(
              article.content == null
                  ? 'Content Not Available'
                  : article.content,
            )
          ],
        ),
      ),
    );
  }
}
