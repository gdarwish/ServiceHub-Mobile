import 'package:ServiceHub/Customer/Screens/add_service_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceTypeBox extends StatelessWidget {
  final Type type;
  final String title;
  final String imageUrl;
  final Color color;
  final BorderRadius borderRadius;

  const ServiceTypeBox({
    this.type,
    this.title,
    this.imageUrl,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AddServiceScreen.route, arguments: type);
        },
        child: Container(
          decoration: new BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(imageUrl),
                  width: 140.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
