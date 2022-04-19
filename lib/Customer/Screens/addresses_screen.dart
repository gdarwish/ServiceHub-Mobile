import 'package:ServiceHub/Customer/Screens/add_address_screen.dart';
import 'package:ServiceHub/Customer/Widgets/address_card.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/mutual_screens/error_screen500.dart';
import 'package:ServiceHub/mutual_screens/no_data_screen.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/native_alert.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressesScreen extends StatelessWidget {
  static const route = '/AddressesScreen';
  // List<Address> addresses;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addreses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AddaddressScreen.route);
            },
          )
        ],
      ),
      body: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressRemovedState) {
            successSnackBar('Address has been removed.', context);
          }
          if (state is AddressFailureState) {
            failureSnackBar(state.apiError.message, context);
          }
        },
        // buildWhen: (before, current) {
        //   if (current is AddressRemovedState) {
        //     return false;
        //   }

        //   return true;
        // },
        builder: (context, state) {
          if (state is AddressInitState ||
              state is AddressAddedState ||
              state is AddressRemovedState) {
            _fetchAddresses(context);
            return Container();
          }
          if (state is AddressAddingState ||
              state is AddressesFetchingState ||
              state is AddressRemovingState) {
            return CustomProgressIndicator();
          }
          if (state is AddressesFetchedState) {
            final addresses = state.addresses;

            if (addresses.isNotEmpty)
              return _buildAddressesScreen(context, addresses);
            if (addresses.isEmpty)
              return NoDataScreen(
                message: 'You currently don\'t have any saved Addresses!',
                onRefresh: _fetchAddresses,
              );
          }

          // if (addresses != null) {
          //   return _buildAddressesScreen(context, addresses);
          // }

          return ErrorScreen500(onRefresh: _fetchAddresses);
        },
      ),
    );
  }

  RefreshIndicator _buildAddressesScreen(
      BuildContext context, List<Address> addresses) {
    return RefreshIndicator(
      onRefresh: () async => _fetchAddresses(context),
      child: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];
          return AddressCard(
            addressName: address.title,
            addressText: address.formattedAddress,
            deleteOnTap: () {
              nativeAlert(
                context: context,
                title: 'Warning',
                body: 'Are you sure you want to remove this Address?',
                btnText: 'Confirm',
                onTap: () {
                  // Remove Address
                  BlocProvider.of<AddressBloc>(context)
                      .add(RemoveAddress(address));
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _fetchAddresses(BuildContext context) {
    BlocProvider.of<AddressBloc>(context).add(FetchAddresses());
  }
}
