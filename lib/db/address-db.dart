import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/address.dart';

class AddressDB {
  static final AddressDB _instance = AddressDB._internal();

  factory AddressDB() => _instance;

  AddressDB._internal();

  Future<List<Address>> getAddresses() async {
    List<Address> addresses = [];

    addresses = await MainDB().getAll<Address>(MainDB.AddressBox);

    return addresses;
  }

  Future<void> saveAddresses(List<Address> addresses) async {
    MainDB().insertAll<Address>(MainDB.AddressBox, object: addresses);
  }
}
