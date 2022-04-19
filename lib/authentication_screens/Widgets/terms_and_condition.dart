import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditions extends StatefulWidget {
  final Function(bool) onChanged;

  TermsAndConditions({this.onChanged});

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool checkboxSatus = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Color(0xFF9D9D9E),
            ),
            child: Checkbox(
              value: checkboxSatus,
              checkColor: Colors.white,
              activeColor: Color(0xFF2C72D4),
              onChanged: (value) {
                setState(() {
                  checkboxSatus = value;
                  widget.onChanged(value);
                });
              },
            ),
          ),
          Row(
            children: [
              textOnTap('Terms and Conditions',
                  url: 'https://servicehub.alidali.ca/end-user-license.html'),
              SizedBox(
                width: 7.0,
              ),
              Text(
                '&',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 7.0,
              ),
              textOnTap('User Policy',
                  url: 'https://servicehub.alidali.ca/privacy-notice.html')
            ],
          ),
        ],
      ),
    );
  }
}

Widget textOnTap(String title, {String url}) {
  return InkWell(
    child: Text(
      title,
      style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue,
          fontSize: 15.0),
    ),
    onTap: () {
      lanchUrl(url);
    },
  );
}

void lanchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Error, could not open $url';
  }
}
