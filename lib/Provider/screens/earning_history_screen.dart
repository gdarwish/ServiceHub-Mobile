import 'package:ServiceHub/Provider/widgets/earning_history_card.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/mutual_screens/error_screen500.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EarningHistoryScreen extends StatefulWidget {
  static const route = '/EarningHistoryScreen';

  @override
  _EarningHistoryScreenState createState() => _EarningHistoryScreenState();
}

class _EarningHistoryScreenState extends State<EarningHistoryScreen> {
  final daysPeriod = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earning History'),
      ),
      body: SafeArea(
        child:
            BlocConsumer<ServiceRequestFetcherBloc, ServiceRequestFetcherState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ServiceRequestFetcherInitState) {
              _fetchServiceRequests(context);
              return Container();
            }
            if (state is ServiceRequestsFetchingState) {
              return CustomProgressIndicator();
            }
            if (state is ServiceRequestsFetchedState) {
              final serviceRequests =
                  state.serviceRequests.where((serviceRequest) {
                return serviceRequest.status.type ==
                        RequestStatusType.Confirmed &&
                    serviceRequest.date.isAfter(
                        DateTime.now().subtract(Duration(days: daysPeriod)));
                // && serviceRequest.date.isBefore(DateTime.now());
              }).toList();
              return _buildEarningHistoryScreen(context, serviceRequests);
            }

            return ErrorScreen500(onRefresh: _fetchServiceRequests);
          },
        ),
      ),
    );
  }

  Column _buildEarningHistoryScreen(
    BuildContext context,
    List<ServiceRequest> serviceRequests,
  ) {
    final totalEarnings = serviceRequests.fold(
        0.0,
        (double previousValue, serviceRequest) =>
            serviceRequest.price + previousValue);

    final fTotalEarnings = totalEarnings.toStringAsFixed(2);

    final startDate = DateTime.now().subtract(Duration(days: daysPeriod));
    final endDate = DateTime.now();

    final formatter = DateFormat.yMMMd();
    final fStartDate = formatter.format(startDate);
    final fEndDate = formatter.format(endDate);

    serviceRequests.sort((a, b) => b.date.compareTo(a.date));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
            ),
            height: 220.0,
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.moneyBillAlt,
                  size: 70.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\$$fTotalEarnings',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Total Week Earning',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '$fStartDate to $fEndDate',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
              onRefresh: () async {},
              child: ListView(
                children: serviceRequests
                    .map(
                      (serviceRequest) =>
                          EarningHistoryCard(serviceRequest: serviceRequest),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _fetchServiceRequests(BuildContext context) {
    BlocProvider.of<ServiceRequestFetcherBloc>(context)
        .add(FetchServiceRequests());
  }
}
