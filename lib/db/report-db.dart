import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/report.dart';

class ReportDB {
  static final ReportDB _instance = ReportDB._internal();

  factory ReportDB() => _instance;

  ReportDB._internal();

  Future<List<Report>> getReports() async {
    List<Report> reports = [];

    reports = await MainDB().getAll<Report>(MainDB.ReportBox);

    return reports;
  }

  Future<void> saveReports(List<Report> reports) async {
    MainDB().insertAll<Report>(MainDB.ReportBox, object: reports);
  }
}
