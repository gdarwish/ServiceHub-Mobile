import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MultyImageSliser extends StatefulWidget {
  List<File> images;
  MultyImageSliser({
    Key key,
    @required this.images,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<MultyImageSliser> {
  int _current = 0;

  String _error = 'No Error Dectected';

  List<Asset> assetImages = [];
  List<File> images;

  @override
  Widget build(BuildContext context) {
    if (images == null) images = widget.images;
    return Column(
      children: [
        // Show images added
        if (widget.images.isNotEmpty)
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: CarouselSlider(
              items: buildImagesWidget(assetImages),
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 16 / 10,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _current = index;
                    },
                  );
                },
              ),
            ),
          ),
        // Show Add image button if there was no images
        if (widget.images.isEmpty)
          GestureDetector(
            onTap: () {
              loadAssets();
            },
            child: Container(
                height: 190.0,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Add Images +',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.map(
            (url) {
              int index = widget.images.indexOf(url);
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

  List<Widget> buildImagesWidget(List<Asset> assets) {
    return List<Widget>.from(assets.map((asset) => Stack(
          children: [
            AssetThumb(
                asset: asset,
                width: MediaQuery.of(context).size.width.toInt(),
                height: 300),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.trash,
                color: Colors.red,
                size: 30.0,
              ),
              onPressed: () {
                // Delete an image
                setState(
                  () {
                    print('REMOVED ' + asset.name);
                    final index = assetImages.indexOf(asset);
                    if (index != -1) {
                      assetImages.removeAt(index);
                      images.removeAt(index);
                    }
                  },
                );
              },
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                height: 40.0,
                decoration: new BoxDecoration(color: Colors.black54),
                child: TextButton(
                  child: Text(
                    'Add Images +',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  onPressed: () {
                    // TODO:: Upload images
                    loadAssets();
                  },
                ),
              ),
            ),
          ],
        )));
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    print('pick images');
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: assetImages,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#2C72D4",
          actionBarTitle: "Photos",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      // final fileImages = List<File>.from(resultList.map((asset) async {
      //   final file = await getImageFileFromAssets(asset);
      //   return file;
      // }));

      final futureFileImages =
          resultList.map((e) async => await getImageFileFromAssets(e)).toList();

      List<File> fileImages = await getImageFilesFromAssets(resultList);

      images.clear();
      images.addAll(fileImages);
    } on Exception catch (e) {
      print(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      assetImages.clear();
      assetImages.addAll(resultList);
      _error = error;
    });
  }

// TODO:: converts List<Asset> to List<File>
  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();
    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    return file;
  }

  Future<List<File>> getImageFilesFromAssets(List<Asset> assets) async {
    List<File> files = [];
    await Future.forEach(assets, (asset) async {
      final byteData = await asset.getByteData();
      final tempFile =
          File("${(await getTemporaryDirectory()).path}/${asset.name}");
      final file = await tempFile.writeAsBytes(
        byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      );

      files.add(file);
    });
    // assets.forEach((asset) async {
    //   final byteData = await asset.getByteData();
    //   final tempFile =
    //       File("${(await getTemporaryDirectory()).path}/${asset.name}");
    //   final file = await tempFile.writeAsBytes(
    //     byteData.buffer
    //         .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    //   );

    //   files.add(file);
    // });
    return files;
  }
}
