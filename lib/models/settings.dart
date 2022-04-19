import 'package:hive/hive.dart';

import 'package:ServiceHub/db/main-db.dart';

part '../db/adapters/settings.g.dart';

@HiveType(typeId: MainDB.SettingsType)
class Settings {
  static final Settings _instance = Settings._internal();

  factory Settings() => _instance;

  Settings._internal();

  @HiveField(0)
  String token = ''; // default

  @HiveField(1)
  String email = ''; // default

  @HiveField(2)
  String password = ''; // default

  @HiveField(3)
  String userType = 'customer'; // default

  @HiveField(4)
  bool rememberMe = false; // default

  @HiveField(5)
  int listStyle = 0; // default

  @HiveField(6)
  bool snowFilter = true; // default

  @HiveField(7)
  bool lawnFilter = true; // default

  @HiveField(8)
  int distanceFilter = 50; // default

  @override
  String toString() {
    return 'Settings(token: $token, email: $email, password: $password, userType: $userType, rememberMe: $rememberMe, listStyle: $listStyle)';
  }
}
