import 'package:ServiceHub/Provider/screens/earning_history_screen.dart';
import 'package:ServiceHub/authentication_screens/signIn_screen.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/mutual_screens/credit_and_resources_screen.dart';
import 'package:ServiceHub/mutual_screens/order_history_screen.dart';
import 'package:ServiceHub/mutual_screens/profile_screen.dart';
import 'package:ServiceHub/mutual_screens/report_screen.dart';
import 'package:ServiceHub/mutual_screens/reports_screen.dart';
import 'package:ServiceHub/mutual_widgets/list_style_switch.dart';
import 'package:ServiceHub/mutual_widgets/profile_image_placeholder.dart';
import 'package:ServiceHub/mutual_widgets/settings_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../constants.dart';

class ProviderSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SigninScreen.route,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        final user = Account.currentUser;

        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    ProfileImagePlaceholder(imageURL: user?.imageURL),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      user?.fullName ?? '',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    Text(user?.email ?? '')
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: <Widget>[
                      SettingsCard(
                        title: 'Profile',
                        iconData: Icons.person,
                        onTap: () async {
                          // Navigate to Profile Screen
                          Navigator.pushNamed(context, ProfileScreen.route);
                        },
                      ),
                      SettingsCard(
                        title: 'Order History',
                        iconData: Icons.history,
                        onTap: () {
                          // Navigate to Order History Screen
                          Navigator.pushNamed(
                              context, OrderHistoryScreen.route);
                        },
                      ),
                      SettingsCard(
                        title: 'Earning History',
                        iconData: Icons.credit_card,
                        onTap: () {
                          // Navigate to Earning History Screen
                          Navigator.pushNamed(
                              context, EarningHistoryScreen.route);
                        },
                      ),
                      SettingsCard(
                        title: 'Reports',
                        iconData: Icons.flag_outlined,
                        onTap: () {
                          //Navigate to Reports Screen
                          Navigator.pushNamed(context, ReportsScreen.route);
                        },
                      ),
                      SettingsCard(
                        title: 'Report Bug',
                        iconData: Icons.bug_report_outlined,
                        onTap: () {
                          // Navigate to ReportScreen
                          Navigator.pushNamed(context, ReportScreen.route);
                        },
                      ),
                      SettingsCard(
                        title: 'Credits and Resources',
                        iconData: FontAwesomeIcons.icons,
                        onTap: () {
                          Navigator.pushNamed(
                              context, CreditAndResourcesScreen.route);
                        },
                      ),
                      SettingsCard(
                        title: 'List Style',
                        iconData: Icons.grid_view,
                        trailingBtn: ListStyleSwitch(),
                        // onTap: () {},
                      ),
                      SettingsCard(
                        title: 'Sign Out',
                        iconData: Icons.logout,
                        onTap: () {
                          // Navigator.pushNamed(context, SigninScreen.route);
                          BlocProvider.of<UserBloc>(context).add(UserLogout());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget switchBtn() {
    return ToggleSwitch(
      minWidth: 75.0,
      initialLabelIndex: 1,
      cornerRadius: 20.0,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      labels: ['List', 'Grid'],
      icons: [FontAwesomeIcons.list, FontAwesomeIcons.gripVertical],
      activeBgColors: [Colors.blue, kPrimaryColor],
      onToggle: (index) {
        print('switched to: $index');
        // TODO:: convert List
      },
    );
  }
}
