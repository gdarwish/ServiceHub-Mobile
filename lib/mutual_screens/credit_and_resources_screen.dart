import 'package:ServiceHub/authentication_screens/Widgets/terms_and_condition.dart';
import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreditAndResourcesScreen extends StatelessWidget {
  static const route = '/CreditAndResourcesScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits and Resources'),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Developers',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      card(
                        'Ali Dali',
                        'contact@alidali.ca',
                        FontAwesomeIcons.laptopCode,
                        () {
                          lanchUrl('https://alidali.ca/');
                        },
                      ),
                      card(
                        'Fadi Findakly',
                        'contact@alidali.ca',
                        FontAwesomeIcons.laptopCode,
                        () {
                          lanchUrl('https://fadifindakly.ca/');
                        },
                      ),
                      card(
                        'Ghaith Darwish',
                        'gaithdarwish1@gmail.com',
                        FontAwesomeIcons.laptopCode,
                        () {
                          lanchUrl('https://gdarwish.ca/');
                        },
                      ),
                      spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Resources',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      card(
                        'Icons',
                        'Font Awesome',
                        FontAwesomeIcons.icons,
                        () {
                          lanchUrl('https://fontawesome.com/s');
                        },
                      ),
                      card(
                        'Images (SVG)',
                        'Flaticon',
                        Icons.image,
                        () {
                          lanchUrl('https://www.flaticon.com/');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget card(String title, String subtitel, IconData icon, Function onTap) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Icon(
            icon,
            color: kPrimaryColor,
          ),
          title: Text(title),
          subtitle: Text(subtitel),
          onTap: onTap,
        ),
      ),
    );
  }
}
