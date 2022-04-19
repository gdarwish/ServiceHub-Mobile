import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/snow-request.dart';

class ServiceRequestDB {
  static final ServiceRequestDB _instance = ServiceRequestDB._internal();

  factory ServiceRequestDB() => _instance;

  ServiceRequestDB._internal();

  Future<List<ServiceRequest>> getServiceRequests(
      {List<String> filters = const []}) async {
    List<SnowRequest> snowRequests = [];
    List<LawnRequest> lawnRequests = [];
    bool all = filters.isEmpty;

    if (all || filters.contains('snow'))
      snowRequests = await MainDB().getAll<SnowRequest>(MainDB.SnowRequestBox);
    if (all || filters.contains('lawn'))
      lawnRequests = await MainDB().getAll<LawnRequest>(MainDB.LawnRequestBox);

    List<ServiceRequest> serviceRequests = [...snowRequests, ...lawnRequests];
    serviceRequests.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return serviceRequests;
  }

  Future<void> saveServiceRequests(List<ServiceRequest> serviceRequests) async {
    final snowRequests = List<SnowRequest>.from(serviceRequests
        .where((serviceRequest) => serviceRequest is SnowRequest));
    final lawnRequests = List<LawnRequest>.from(serviceRequests
        .where((serviceRequest) => serviceRequest is LawnRequest));

    MainDB()
        .insertAll<SnowRequest>(MainDB.SnowRequestBox, object: snowRequests);
    MainDB()
        .insertAll<LawnRequest>(MainDB.LawnRequestBox, object: lawnRequests);
  }
}
