import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'asset_image.dart';

class ImageSliser extends StatefulWidget {
  List<String> networkImages;
  List<File> fileImages;

  ImageSliser({this.networkImages, this.fileImages});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<ImageSliser> {
  int _current = 0;
  File _image;
  List<File> imageList;

  @override
  Widget build(BuildContext context) {
    final images = widget.networkImages ?? widget.fileImages;

    // final List images = [
    //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    // ];

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            // Box Shadow
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          // Image Slider
          child: CarouselSlider(
            items: buildImageSlider(images),
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              aspectRatio: 16 / 10,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _current = index;
                    // print(_current);
                  },
                );
              },
            ),
          ),
        ),
        // Image indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map(
            (image) {
              int index = images.indexOf(image);
              print(index);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  List<Widget> buildImageSlider(List<dynamic> images) {
    return images
        .map(
          (image) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      // load image with placeHodler
                      if (image is String)
                        CachedNetworkImage(
                          imageUrl: image,
                          placeholder: (context, url) => assetImage(
                              "images/placeholderImage.png", context),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      if (image is File) Image.file(image),
                      // Load image without placeHolder
                      // Image.network(item, fit: BoxFit.fitHeight),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        )
        .toList();
  }
}
