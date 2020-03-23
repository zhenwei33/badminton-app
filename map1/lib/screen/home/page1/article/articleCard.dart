import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:shimmer/shimmer.dart';

class ArticleCard extends StatelessWidget {
  final bool isLoaded;
  final String title;
  final String url;
  final String image;
  ArticleCard({this.isLoaded, this.title, this.url, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 26, left: 10, right: 10),
        child: isLoaded
            ? Container(
                width: 140,
                height: 226,
                decoration: BoxDecoration(
                    color: blue3,
                    borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          image,
                          fit: BoxFit.cover,
                          height: 190,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.black.withOpacity(.5), Colors.transparent],
                                    begin: Alignment(0.1, 1.5),
                                    end: Alignment(0.4, 0.1)
                                  )
                                ),
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                title,
                                style: articleTitle,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              )
            : //Loading Shimmer effect
            Shimmer.fromColors(
              baseColor: blue3,
              highlightColor: blue2,
              child: Container(
                width: 140,
                height: 226,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
              ),
            )
          );

    // Padding(
    //   padding: const EdgeInsets.only(left: 15.0),
    //   child: Container(
    //     width: 165,
    //     height: 240,
    //     child: Stack(
    //       fit: StackFit.expand,
    //       children: <Widget>[
    //         Align(
    //           alignment: Alignment.bottomCenter,
    //           child: Padding(
    //             padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20.0),
    //             child: Container(
    //               width: 140,
    //               height: 170,
    //               decoration: BoxDecoration(
    //                 color: Colors.pink,
    //                 borderRadius: BorderRadius.circular(8),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.black.withOpacity(.1),
    //                     offset: Offset(0, 10),
    //                     blurRadius: 12
    //                   )
    //                 ]
    //               ),
    //             ),
    //           ),
    //         ),
    //         Text(title)
    //       ],
    //     ),
    //   ),
    // );
  }
}
