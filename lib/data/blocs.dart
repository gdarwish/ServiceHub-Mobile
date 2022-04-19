export 'user/user.dart';
export 'service-requests-searcher/service-request-searcher.dart';
export 'service-requests-fetcher/service-request-fetcher.dart';
export 'service-requests-handler/service-request-handler.dart';
export 'report/report.dart';
export 'review/review.dart';
export 'address/address.dart';
export 'payment-method/payment-method.dart';

import 'package:ServiceHub/data/address/address-bloc.dart';
import 'package:ServiceHub/data/address/address-event.dart';
import 'package:ServiceHub/data/payment-method/payment-method-bloc.dart';
import 'package:ServiceHub/data/payment-method/payment-method-event.dart';
import 'package:ServiceHub/data/report/report-bloc.dart';
import 'package:ServiceHub/data/report/report-event.dart';
import 'package:ServiceHub/data/review/review-bloc.dart';
import 'package:ServiceHub/data/review/review-event.dart';
import 'package:ServiceHub/data/service-requests-fetcher/service-request-fetcher-bloc.dart';
import 'package:ServiceHub/data/service-requests-fetcher/service-request-fetcher-event.dart';
import 'package:ServiceHub/data/service-requests-handler/service-request-handler-bloc.dart';
import 'package:ServiceHub/data/service-requests-handler/service-request-handler-event.dart';
import 'package:ServiceHub/data/service-requests-searcher/service-request-searcher-bloc.dart';
import 'package:ServiceHub/data/service-requests-searcher/service-request-searcher-event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Blocs {
  static Future<void> resetBlocs(BuildContext context) async {
    BlocProvider.of<ServiceRequestFetcherBloc>(context)
        .add(ResetServiceRequestFetcher());
    BlocProvider.of<ServiceRequestSearcherBloc>(context)
        .add(ResetServiceRequestSearcher());
    BlocProvider.of<ServiceRequestHandlerBloc>(context)
        .add(ResetServiceRequestHandler());
    BlocProvider.of<ReviewBloc>(context).add(ResetReview());
    BlocProvider.of<ReportBloc>(context).add(ResetReport());
    BlocProvider.of<AddressBloc>(context).add(ResetAddress());
    BlocProvider.of<PaymentMethodBloc>(context).add(ResetPaymentMethod());
  }
}
