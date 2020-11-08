import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/news.dart';

class SlideShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articles = Provider.of<Articles>(context).articles;
    var mQSize = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(enlargeCenterPage: true, aspectRatio: 2 / 1),
      items: articles == null
          ? [Container()]
          : articles.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width,
                    // decoration: BoxDecoration(
                    //   boxShadow: [
                    //     BoxShadow(
                    //       // color: Colors.pink[50],
                    //       offset: Offset(0.0, 1.0), //(x,y)
                    //       blurRadius: 5.0,
                    //     ),
                    //   ],
                    //   borderRadius: BorderRadius.circular(10),
                    //   gradient: LinearGradient(
                    //     colors: [Colors.pink, Colors.blue],
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //   ),
                    // ),
                    // child: Text('Yo'),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Card(
                          color: Colors.amber,
                          // elevation: 20,
                          child: Image.network(
                            i.urlToImage == null
                                ? 'https://th.bing.com/th/id/OIP.wx64GmJDu2nd32eO_tieDgHaEK?pid=Api&rs=1'
                                : i.urlToImage,
                            fit: BoxFit.fill,
                          )),
                    ),
                  );
                },
              );
            }).toList(),
    );
  }
}
