import 'package:ServiceHub/Customer/Screens/add_address_screen.dart';
import 'package:ServiceHub/Customer/Screens/add_payment_screen.dart';
import 'package:ServiceHub/Customer/Screens/add_service_screen.dart';
import 'package:ServiceHub/Customer/Screens/addresses_screen.dart';
import 'package:ServiceHub/Customer/Screens/confirm_screen.dart';
import 'package:ServiceHub/Customer/Screens/detail_screen.dart' as Customer;
import 'package:ServiceHub/Customer/Screens/test-screen.dart';
import 'package:ServiceHub/Provider/Screens/detail_screen.dart' as Provider;
import 'package:ServiceHub/Customer/Screens/edit_screen.dart';
import 'package:ServiceHub/Customer/Screens/customer_main_screen.dart';
import 'package:ServiceHub/Customer/Screens/payments_screens.dart';
import 'package:ServiceHub/Provider/screens/earning_history_screen.dart';
import 'package:ServiceHub/Provider/screens/provider_main_screen.dart';
import 'package:ServiceHub/Provider/screens/review_screen.dart';
import 'package:ServiceHub/data/payment-method/payment-method-bloc.dart';
import 'package:ServiceHub/mutual_screens/credit_and_resources_screen.dart';
import 'package:ServiceHub/mutual_screens/edit_profile_screen.dart';
import 'package:ServiceHub/mutual_screens/error_screen404.dart';
import 'package:ServiceHub/mutual_screens/order_history_screen.dart';
import 'package:ServiceHub/mutual_screens/profile_screen.dart';
import 'package:ServiceHub/Customer/Screens/review_service_screen.dart';
import 'package:ServiceHub/Customer/Screens/select_type_screen.dart';
import 'package:ServiceHub/authentication_screens/reset_password.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/mutual_screens/report_screen.dart';
import 'package:ServiceHub/mutual_screens/reports_screen.dart';
import 'package:ServiceHub/mutual_screens/splash_screen.dart';
import 'package:ServiceHub/authentication_screens/signup_screen.dart';
import 'package:ServiceHub/db/main-db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_screens/signIn_screen.dart';
import 'authentication_screens/signup_screen.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
import 'data/blocs.dart';
import 'data/simple-bloc-observer.dart';

void main() async {
  // initialize database
  await MainDB().initialize();

  // bloc listener (DEBUG)
  Bloc.observer = SimpleBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // run ServiceHub :)
  runApp(ServiceHub());
}

class ServiceHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // create bloc providers
      providers: [
        BlocProvider<UserBloc>(create: (_) => UserBloc()),
        BlocProvider<ServiceRequestSearcherBloc>(
            create: (_) => ServiceRequestSearcherBloc()),
        BlocProvider<ServiceRequestFetcherBloc>(
            create: (_) => ServiceRequestFetcherBloc()),
        BlocProvider<ServiceRequestHandlerBloc>(
            create: (_) => ServiceRequestHandlerBloc()),
        BlocProvider<ReportBloc>(create: (_) => ReportBloc()),
        BlocProvider<ReviewBloc>(create: (_) => ReviewBloc()),
        BlocProvider<AddressBloc>(create: (_) => AddressBloc()),
        BlocProvider<PaymentMethodBloc>(create: (_) => PaymentMethodBloc()),
      ],
      child: ServiceHubApp(),
    );
  }
}

class ServiceHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserUnauthenticated) {
          Blocs.resetBlocs(context);
        }
      },
      listenWhen: (before, current) => (!(before is UserUnauthenticated) &&
          (current is UserUnauthenticated)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'OpenSans',
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBackgronudColor,
        ),
        title: 'ServiceHub',
        // initialRoute: SigninScreen.route,
        // initialRoute: TestScreen.route,
        initialRoute: SplashScreen.route,
        routes: {
          TestScreen.route: (_) => TestScreen(),
          SplashScreen.route: (_) => SplashScreen(),
          SigninScreen.route: (_) => SigninScreen(),
          CustomerMainScreen.route: (_) => CustomerMainScreen(),
          ProviderMainScreen.route: (_) => ProviderMainScreen(),
          SelectRequestType.route: (_) => SelectRequestType(),
          SignupScreen.route: (_) => SignupScreen(),
          ResetPasswordScreen.route: (_) => ResetPasswordScreen(),
          ProfileScreen.route: (_) => ProfileScreen(),
          EditProfileScreen.route: (_) => EditProfileScreen(),
          OrderHistoryScreen.route: (_) => OrderHistoryScreen(),
          PaymentsScreen.route: (_) => PaymentsScreen(),
          ReportsScreen.route: (_) => ReportsScreen(),
          AddressesScreen.route: (_) => AddressesScreen(),
          AddaddressScreen.route: (_) => AddaddressScreen(),
          ReviewScreen.route: (_) => ReviewScreen(),
          EarningHistoryScreen.route: (_) => EarningHistoryScreen(),
          CreditAndResourcesScreen.route: (_) => CreditAndResourcesScreen(),
        },
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) {
              //  if (settings.name == SigninScreen.route) {
              //   return SigninScreen(credentials: settings.arguments);
              // }

              if (settings.name == Customer.DetailScreen.route &&
                  settings.arguments is ServiceRequest) {
                return Customer.DetailScreen(settings.arguments);
              }

              if (settings.name == Provider.DetailScreen.route &&
                  settings.arguments is ServiceRequest) {
                return Provider.DetailScreen(settings.arguments);
              }

              if (settings.name == EditScreen.route &&
                  settings.arguments is ServiceRequest) {
                return EditScreen(settings.arguments);
              }

              if (settings.name == ReviewServiceScreen.route &&
                  settings.arguments is ServiceRequest) {
                return ReviewServiceScreen(settings.arguments);
              }

              if (settings.name == ReportScreen.route) {
                if (settings.arguments is ServiceRequest)
                  return ReportScreen(serviceRequest: settings.arguments);
                else
                  return ReportScreen(bugReport: true);
              }

              if (settings.name == ConfirmScreen.route &&
                  settings.arguments is ServiceRequest) {
                return ConfirmScreen(settings.arguments);
              }

              if (settings.name == AddServiceScreen.route) {
                return AddServiceScreen(settings.arguments);
              }

              if (settings.name == AddPaymentMethodScreen.route) {
                return AddPaymentMethodScreen();
              }

              // Error Screen
              return ErrorScreen404();
            },
          );
        },
      ),
    );
  }
}
