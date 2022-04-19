import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileImagePlaceholder extends StatelessWidget {
  final String imageURL;
  const ProfileImagePlaceholder({
    Key key,
    @required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        child: imageURL != null
            // if image is not null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: NetworkImage(
                    imageURL,
                  ),
                  width: 130.0,
                  height: 130.0,
                  fit: BoxFit.cover,
                ),
              )
            // else retuen placeholder
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                width: 120,
                height: 120,
                child: Image.asset(
                  'images/profile.png',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
