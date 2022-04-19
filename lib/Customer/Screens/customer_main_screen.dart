import 'package:ServiceHub/Customer/Screens/home-screen.dart';
import 'package:ServiceHub/Customer/Screens/select_type_screen.dart';
import 'package:ServiceHub/Customer/Screens/customer_settings_screen.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/db/settings-db.dart';
import 'package:ServiceHub/models/settings.dart';
import 'package:ServiceHub/mutual_widgets/add_alert_dialog.dart';
import 'package:ServiceHub/mutual_widgets/bottom_nav.dart';
import 'package:ServiceHub/mutual_widgets/fab_nav_btn.dart';
import 'package:ServiceHub/mutual_widgets/filter_alert_dialog_content.dart';
import 'package:ServiceHub/mutual_widgets/filter_slider_dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class CustomerMainScreen extends StatefulWidget {
  static const route = '/CustomerMainScreen';

  @override
  _CustomerMainScreenState createState() => _CustomerMainScreenState();
}

class _CustomerMainScreenState extends State<CustomerMainScreen> {
  int currentIndex = 0;
  final _pageController = PageController();

  final _pages = [
    // Navigate to Main Screen
    HomeScreen(),
    // Navigate to Settings
    SettingsScreen(),
  ];
  final _titles = [
    'Home',
    'Settings',
  ];

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Text(_titles[currentIndex]),
        actions: <Widget>[
          if (currentIndex == 0)
            IconButton(
              icon: Icon(
                FontAwesomeIcons.filter,
                color: Colors.white,
              ),
              onPressed: () {
                addAlertDialog(
                  context: context,
                  title: 'Filter Service Requests',
                  content: FilterAlertDialog(),
                  mainBtnText: 'Filter',
                  onTap: () => _filterServiceRequests(context),
                );
              },
            )
        ],
      ),
      // Body
      body: PageView(
        controller: _pageController,
        children: _pages,
        physics: NeverScrollableScrollPhysics(),
      ),
      // BottomNav
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: fabNavBtn(
        Icons.add,
        kPrimaryColor,
        () async {
          // OnTap Add button
          // Navigator.pushNamed(context, SelectRequestType.route);
          await Navigator.pushNamed(context, SelectRequestType.route);
          BlocProvider.of<ServiceRequestFetcherBloc>(context)
              .add(FetchServiceRequests());
        },
      ),
      bottomNavigationBar: BottonNav(currentIndex, setBottomBarIndex),
    );
  }

  void _filterServiceRequests(BuildContext context) {
    // Save to DB
    SettingsDB().saveSettings(Settings());

    // Fetch new results
    final filters = [
      if (Settings().snowFilter) 'snow',
      if (Settings().lawnFilter) 'lawn',
    ];
    BlocProvider.of<ServiceRequestFetcherBloc>(context)
        .add(FetchServiceRequests(filters: filters));

    Navigator.pop(context);
  }
}
