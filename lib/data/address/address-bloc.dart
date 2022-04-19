import 'package:ServiceHub/api/address-api.dart';
import 'package:ServiceHub/api/connection.dart';
import 'package:ServiceHub/db/address-db.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'address.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final _addressAPI = AddressAPI();
  final _addressDB = AddressDB();

  AddressBloc() : super(AddressInitState());

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    if (event is ResetAddress) {
      yield AddressInitState();
    } else if (event is FetchAddresses) {
      yield* _mapFetchAddressesToState(event);
    } else if (event is FetchAddress) {
      yield* _mapFetchAddressToState(event);
    } else if (event is AddAddress) {
      yield* _mapAddAddressToState(event);
    } else if (event is RemoveAddress) {
      yield* _mapRemoveAddressToState(event);
    }
  }

  Stream<AddressState> _mapFetchAddressToState(FetchAddress event) async* {
    try {
      yield AddressesFetchingState();
      // return same address (addresses are immutable :)
      Address data = event.address;

      if (data != null && data is Address) {
        yield AddressFetchedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield AddressFailureState(apiError);
    } catch (error) {
      yield AddressFailureState(APIError(message: error.toString()));
    }
  }

  Stream<AddressState> _mapFetchAddressesToState(FetchAddresses event) async* {
    try {
      yield AddressesFetchingState();
      List<Address> data;

      final isConnected = await Connection().isConnected();
      if (isConnected) {
        data = await _addressAPI.fetchAddresses();
      } else {
        data = await _addressDB.getAddresses();
      }

      if (data != null && data is List<Address>) {
        yield AddressesFetchedState(data);
        // Update user addresses
        (Account.currentUser as Customer).addresses = data;

        // Update local records
        if (isConnected) _addressDB.saveAddresses(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield AddressFailureState(apiError);
    } catch (error) {
      yield AddressFailureState(APIError(message: error.toString()));
    }
  }

  Stream<AddressState> _mapAddAddressToState(AddAddress event) async* {
    try {
      yield AddressAddingState();
      final data = await _addressAPI.addAddress(event.address);
      if (data != null && data is Address) {
        if (!(Account.currentUser as Customer).addresses.contains(data))
          (Account.currentUser as Customer).addresses.add(data);

        yield AddressAddedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield AddressFailureState(apiError);
    } catch (error) {
      yield AddressFailureState(APIError(message: error.toString()));
    }
  }

  Stream<AddressState> _mapRemoveAddressToState(RemoveAddress event) async* {
    try {
      yield AddressRemovingState();
      final removed = await _addressAPI.removeAddress(event.address);
      if (removed) {
        if ((Account.currentUser as Customer).addresses.contains(event.address))
          (Account.currentUser as Customer).addresses.remove(event.address);

        yield AddressRemovedState();
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield AddressFailureState(apiError);
    } catch (error) {
      yield AddressFailureState(APIError(message: error.toString()));
    }
  }
}
