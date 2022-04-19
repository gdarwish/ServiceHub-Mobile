import 'package:ServiceHub/db/main-db.dart';
import 'package:hive/hive.dart';

part '../db/adapters/card-type.g.dart';

@HiveType(typeId: MainDB.CardTypeType)
enum CardType {
  @HiveField(0)
  Visa,
  @HiveField(1)
  Mastercard,
  @HiveField(2)
  AmericanExpress,
  @HiveField(3)
  Diners,
  @HiveField(4)
  Discover,
}
