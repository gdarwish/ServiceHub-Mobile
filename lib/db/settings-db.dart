import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/settings.dart';

class SettingsDB {
  static final SettingsDB _instance = SettingsDB._internal();

  factory SettingsDB() => _instance;

  SettingsDB._internal();

  Future<Settings> getSettings() async {
    return await MainDB().get<Settings>(MainDB.SettingsBox);
  }

  Future<void> saveSettings(Settings settings) async {
    await MainDB().insert<Settings>(MainDB.SettingsBox, object: settings);
  }
}
