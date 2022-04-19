import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/api/main-api.dart';

class AddressAPI {
  static final AddressAPI _instance = AddressAPI._internal();

  factory AddressAPI() => _instance;

  AddressAPI._internal();

  Future<List<Address>> fetchAddresses() async {
    final data = await MainAPI().get('/customer/addresses');

    if (data != null) {
      return List<Address>.from(
        data.map((address) => Address.fromMap(address)),
      );
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<Address> fetchAdrress(Address address) async {
    final data = await MainAPI().get('/customer/addresses/${address.id}');

    if (data != null) {
      return Address.fromMap(data);
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<Address> addAddress(Address address) async {
    final data = await MainAPI().post('/customer/addresses', address.toMap());

    if (data != null) {
      return Address.fromMap(data);
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<bool> removeAddress(Address address) async {
    final data = await MainAPI().delete('/customer/addresses/${address.id}');
    return data != null;
  }
}
