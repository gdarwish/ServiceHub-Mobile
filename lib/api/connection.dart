import 'package:connectivity/connectivity.dart';

class Connection {
  static final Connection _instance = Connection._internal();

  factory Connection() => _instance;

  final connectivity = Connectivity();

  Connection._internal();

  Future<bool> isConnected() async {
    final connection = await connectivity.checkConnectivity();
    return connection != ConnectivityResult.none;
  }
}
