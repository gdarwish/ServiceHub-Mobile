import 'package:ServiceHub/db/settings-db.dart';
import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/models/card-type.dart';
import 'package:ServiceHub/models/credit-card.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/payment-method.dart';
import 'package:ServiceHub/models/payment.dart';
import 'package:ServiceHub/models/profile.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/report-status.dart';
import 'package:ServiceHub/models/report.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:ServiceHub/models/review.dart';
import 'package:ServiceHub/models/settings.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainDB {
  static final MainDB _instance = MainDB._internal();

  factory MainDB() => _instance;

  MainDB._internal();

  static const AddressType = 0;
  static const CardTypeType = 1;
  static const CreditCardType = 2;
  static const CustomerType = 3;
  static const LawnRequestType = 4;
  static const PaymentMethodType = 5;
  static const PaymentType = 6;
  static const ProfileType = 7;
  static const ProviderType = 8;
  static const ReportStatusType = 9;
  static const ReportType = 10;
  static const RequestStatusType = 11;
  static const ReviewType = 12;
  static const SnowRequestType = 13;
  static const SettingsType = 14;

  static const AddressBox = 'AddressBox';
  static const CardTypeBox = 'CardTypeBox';
  static const CreditCardBox = 'CreditCardBox';
  static const CustomerBox = 'CustomerBox';
  static const LawnRequestBox = 'LawnRequestBox';
  static const PaymentMethodBox = 'PaymentMethodBox';
  static const PaymentBox = 'PaymentBox';
  static const ProfileBox = 'ProfileBox';
  static const ProviderBox = 'ProviderBox';
  static const ReportStatusBox = 'ReportStatusBox';
  static const ReportBox = 'ReportBox';
  static const RequestStatusBox = 'RequestStatusBox';
  static const ReviewBox = 'ReviewBox';
  static const SnowRequestBox = 'SnowRequestBox';
  static const SettingsBox = 'SettingsBox';

  // LazyBox<Address> addressBox;
  // LazyBox<CardType> cardTypeBox;
  // LazyBox<CreditCard> creditCardBox;
  // LazyBox<Customer> customerBox;
  // LazyBox<LawnRequest> lawnRequestBox;
  // LazyBox<PaymentMethod> paymentMethodBox;
  // LazyBox<Payment> paymentBox;
  // LazyBox<Profile> profileBox;
  // LazyBox<Provider> providerBox;
  // LazyBox<ReportStatus> reportStatusBox;
  // LazyBox<Report> reportBox;
  // LazyBox<RequestStatus> requestStatusBox;
  // LazyBox<Review> reviewBox;
  // LazyBox<SnowRequest> snowRequestBox;
  // LazyBox<Settings> settingsBox;

  Future<void> initialize() async {
    await Hive.initFlutter();
    // await Hive.openBox('servicehub');

    // Adapters
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(CardTypeAdapter());
    Hive.registerAdapter(CreditCardAdapter());
    Hive.registerAdapter(CustomerAdapter());
    Hive.registerAdapter(LawnRequestAdapter());
    Hive.registerAdapter(PaymentMethodAdapter());
    Hive.registerAdapter(PaymentAdapter());
    Hive.registerAdapter(ProfileAdapter());
    // Hive.registerAdapter(ProviderAdapter());
    Hive.registerAdapter(ReportStatusAdapter());
    Hive.registerAdapter(ReportAdapter());
    Hive.registerAdapter(RequestStatusAdapter());
    Hive.registerAdapter(ReviewAdapter());
    Hive.registerAdapter(SnowRequestAdapter());
    Hive.registerAdapter(SettingsAdapter());

    // Boxes
    // addressBox = await Hive.openLazyBox(AddressBox);
    // cardTypeBox = await Hive.openLazyBox(CardTypeBox);
    // creditCardBox = await Hive.openLazyBox(CreditCardBox);
    // customerBox = await Hive.openLazyBox(CustomerBox);
    // lawnRequestBox = await Hive.openLazyBox(LawnRequestBox);
    // paymentMethodBox = await Hive.openLazyBox(PaymentMethodBox);
    // paymentBox = await Hive.openLazyBox(PaymentBox);
    // profileBox = await Hive.openLazyBox(ProfileBox);
    // providerBox = await Hive.openLazyBox(ProviderBox);
    // reportStatusBox = await Hive.openLazyBox(ReportStatusBox);
    // reportBox = await Hive.openLazyBox(ReportBox);
    // requestStatusBox = await Hive.openLazyBox(RequestStatusBox);
    // reviewBox = await Hive.openLazyBox(ReviewBox);
    // snowRequestBox = await Hive.openLazyBox(SnowRequestBox);
    // settingsBox = await Hive.openLazyBox(SettingsBox);

    // Init Settings
    await SettingsDB().getSettings();
  }

  Future<void> insert<T>(String name, {T object}) async {
    final box = await Hive.openLazyBox<T>(name);
    await box.put(name, object);
    await box.close();
  }

  Future<void> insertAll<T>(String name, {List<T> object}) async {
    final box = await Hive.openLazyBox<T>(name);
    await box.clear();
    await box.addAll(object);
    await box.close();
  }

  Future<List<T>> getAll<T>(String name, {T object}) async {
    final box = await Hive.openBox<T>(name);
    Future.delayed(Duration(milliseconds: 500), () => box.close());
    return List<T>.from(box.values);
  }

  Future<T> get<T>(String name, {T object}) async {
    final box = await Hive.openBox<T>(name);
    Future.delayed(Duration(milliseconds: 500), () => box.close());
    return box.get(name);
  }

  Future<void> clear<T>(String name) async {
    final box = await Hive.openLazyBox(name);
    await box.clear();
    await box.close();
  }
}
