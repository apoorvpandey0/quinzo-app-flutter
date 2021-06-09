import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/providers/news.dart';
import 'package:quiz_app/screens/article_detail_screen.dart';
import 'package:quiz_app/widgets/slideShow.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  void _updateArticles() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Articles>(context, listen: false).getAndSetArticles();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      _updateArticles();
    }

    // print(Provider.of<Articles>(context, listen: false).articles);
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<Articles>(context);
    // print('Articles ${newsData.articles}');
    return Column(
      children: [
        SlideShow(),
        // Divider(),
        // RaisedButton(onPressed: _updateArticles),
        _isLoading
            ? CircularProgressIndicator()
            : Expanded(
                child: ListView.builder(

                    // scrollDirection: Axis.horizontal,
                    itemCount: newsData.articles.length,
                    itemBuilder: (ctx, index) => GestureDetector(
                          onTap: () {
                            print('SELECTED');
                            Navigator.of(context).pushNamed(
                                ArticleDetailScreen.routeName,
                                arguments: newsData.articles[index]);
                          },
                          child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 6,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          color: Colors.blue,
                                          // padding: EdgeInsets.all(5),
                                          width: 90,
                                          height: 60,
                                          child: Hero(
                                            tag: newsData.articles[index],
                                            child: Image.network(
                                              newsData.articles[index]
                                                          .urlToImage ==
                                                      null
                                                  ? 'https://th.bing.com/th/id/OIP.ua0G-QLsUtY_HgfRK7QnwQEgDY?pid=Api&rs=1'
                                                  : newsData.articles[index]
                                                      .urlToImage,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // VerticalDivider(
                                      //   indent: 10,
                                      //   thickness: 5,
                                      // ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              newsData.articles[index].title,
                                            ),
                                            // Text(
                                            //   newsData.articles[index].publishedAt,
                                            //   style: TextStyle(color: Colors.grey),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))),
                        )),
              )
      ],
    );
  }
}
