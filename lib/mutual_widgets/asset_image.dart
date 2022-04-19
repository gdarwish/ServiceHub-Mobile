import 'package:flutter/material.dart';

Widget assetImage(String imageAssetUrl, BuildContext context) {
  return Image(
    image: AssetImage(imageAssetUrl),
    width: (MediaQuery.of(context).size.width / 2.0) > 500
        ? 500
        : MediaQuery.of(context).size.width / 2.0,
  );
}
