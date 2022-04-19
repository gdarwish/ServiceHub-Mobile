import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/settings.dart';

class UserDB {
  static final UserDB _instance = UserDB._internal();

  factory UserDB() => _instance;

  UserDB._internal();

  Future<Account> authenticate() async {
    Account user;

    if (Settings().userType is Customer) {
      user = await MainDB().get<Account>(MainDB.CustomerBox);
    } else if (Settings().userType is Provider) {
      user = await MainDB().get<Account>(MainDB.ProviderBox);
    }

    return user;
  }

  Future<void> saveUser(Account user) async {
    if (user is Customer) {
      await MainDB().insert<Account>(MainDB.CustomerBox, object: user);
    } else if (user is Provider) {
      await MainDB().insert<Account>(MainDB.ProviderBox, object: user);
    }
  }

  Future<void> clearUser(Account user) async {
    // if (user is Customer) {
    await MainDB().clear<Account>(MainDB.CustomerBox);
    // } else if (user is Provider) {
    await MainDB().clear<Account>(MainDB.ProviderBox);
    // }
    await MainDB().clear<Settings>(MainDB.SettingsBox); // clear settings
  }
}
