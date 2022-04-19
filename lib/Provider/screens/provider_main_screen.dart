import 'package:ServiceHub/Provider/screens/detail_screen.dart';
import 'package:ServiceHub/Provider/screens/home_screen.dart';
import 'package:ServiceHub/Provider/screens/provider_settings_screen.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/db/settings-db.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/settings.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:ServiceHub/mutual_widgets/add_alert_dialog.dart';
import 'package:ServiceHub/mutual_widgets/bottom_nav.dart';
import 'package:ServiceHub/mutual_widgets/filter_slider_dialog_content.dart';
import 'package:ServiceHub/mutual_widgets/native_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class ProviderMainScreen extends StatefulWidget {
  static const route = '/ProviderMainScreen';

  @override
  _ProviderMainScreenState createState() => _ProviderMainScreenState();
}

class _ProviderMainScreenState extends State<ProviderMainScreen> {
  int currentIndex = 0;
  final _pageController = PageController();

  bool isSnow = true;
  IconData fabIcon;
  Color iconColor;
  ServiceRequest serviceRequest;
  // final _pages = [
  //   // Navigate to Main Screen
  //   HomeScreen(),
  //   // Navigate to Settings
  //   ProviderSettingsScreen(),
  // ];
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

  void appBarItemOnTap(String value) {
    switch (value) {
      case 'Report':
        // Navigator.pushNamed(context, ReportScreen.route);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceRequestHandlerBloc, ServiceRequestHandlerState>(
      buildWhen: (before, current) => !(current is ServiceRequestProcessing),
      builder: (context, state) {
        serviceRequest =
            (Account.currentUser as Provider)?.currentServiceRequest;

        if (serviceRequest is SnowRequest) {
          fabIcon = FontAwesomeIcons.snowflake;
          iconColor = Colors.blue[100];
        } else if (serviceRequest is LawnRequest) {
          fabIcon = FontAwesomeIcons.leaf;
          iconColor = Colors.lightGreen;
        } else {
          fabIcon = FontAwesomeIcons.search;
          iconColor = null;
        }

        final _pages = [
          // Navigate to Main Screen
          HomeScreen(),
          // Navigate to Settings
          ProviderSettingsScreen(),
        ];

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
                      content: FilterSliderDialogContent(),
                      mainBtnText: 'Filter',
                      onTap: () => _filterServiceRequests(context),
                    );
                  },
                )
            ],
          ),
          // Body
          body: BlocBuilder<ServiceRequestHandlerBloc,
              ServiceRequestHandlerState>(
            buildWhen: (before, current) =>
                !(current is ServiceRequestProcessing),
            builder: (context, state) {
              return PageView(
                controller: _pageController,
                children: _pages,
                physics: NeverScrollableScrollPhysics(),
              );
            },
          ),
          // BottomNav
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(fabIcon, color: iconColor),
            backgroundColor: kPrimaryColor,
            onPressed: () {
              if (serviceRequest != null) {
                Navigator.pushNamed(
                  context,
                  DetailScreen.route,
                  arguments: serviceRequest,
                );
              } else {
                nativeAlert(
                  context: context,
                  title: 'Note',
                  body: 'You currently don\'t have any accepted requests :|',
                );
              }
            },
          ),
          bottomNavigationBar: BottonNav(currentIndex, setBottomBarIndex),
        );
      },
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
    BlocProvider.of<ServiceRequestSearcherBloc>(context)
        .add(SearchServiceRequests(filters: filters));

    Navigator.pop(context);
  }
}
