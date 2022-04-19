import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/models/card-type.dart';
import 'package:ServiceHub/models/credit-card.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/payment-method.dart';
import 'package:ServiceHub/models/profile.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/snow-request.dart';

class Data {
  List<String> optionsList = [
    "Large (200 - 300) sq.ft",
    "Medium (100 - 200) sq.ft",
    "Small (50 - 100) sq.ft"
  ];

  List<String> optionsSnow = [
    "Large (Fits 6 cars)",
    "Small (Fits 2 cars)",
  ];

  final List<Address> addresses = [
    Address(
        id: 1,
        formattedAddress: "123 Windsor",
        phone: "2262602255",
        title: "Mom"),
    Address(
        id: 2,
        formattedAddress: "456 Windsor",
        phone: "5195554478",
        title: "Dad"),
    Address(
        id: 3,
        formattedAddress: "789 Windsor",
        phone: "4175542545",
        title: "Max")
  ];

  final List<PaymentMethod> payments = [
    PaymentMethod(
      card: CreditCard(
        name: 'MMM',
        expMonth: 03,
        expYear: 22,
        last4Digits: '1234',
        type: 'MasterCard',
      ),
    ),
    PaymentMethod(
      card: CreditCard(
        name: 'Visa',
        expMonth: 03,
        expYear: 22,
        last4Digits: '1234',
        type: 'Visa',
      ),
    ),
    PaymentMethod(
      card: CreditCard(
        name: 'AAA',
        expMonth: 03,
        expYear: 22,
        last4Digits: '1234',
        type: 'American Express',
      ),
    ),
  ];

  Customer _currentCustomer;
  Customer get currentCustomer => _currentCustomer;

  Provider _currentProvider;
  Provider get currentProvider => _currentProvider;

  Data() {
    _initCustomer();
  }

  void _initCustomer() {
    _currentCustomer = Customer(
      addresses: addresses,
      firstName: 'Ghaith',
      lastName: 'Darwish',
      email: 'email@email.com',
      paymentMethods: payments,
      id: 1,
      serviceRequests: [
        // Snow Request
        SnowRequest(
          customer: Profile(),
          address: addresses.first,
          customerImages: [
            'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
            'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
            'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
          ],
          price: 22,
          status: RequestStatus(id: 1, title: 'Pending'),
          date: DateTime.now(),
          driveway: optionsSnow[1],
          salting: false,
          sidewalk: true,
          walkway: false,
          providerAfterImages: [
            'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
            'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
            'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
          ],
          providerBeforeImages: [
            'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
            'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
            'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
            'https://www.mcleishorlando.com/wp-content/uploads/2020/02/47aa303323502cf42388fe91f8543644.jpg'
          ],
          provider: Profile(firstName: 'Ali'),
        ),

        // Lawn
        LawnRequest(
          address: addresses.first,
          customerImages: [
            'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
            'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
            'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
            'https://www.mcleishorlando.com/wp-content/uploads/2020/02/47aa303323502cf42388fe91f8543644.jpg'
          ],
          price: 44,
          status: RequestStatus(id: 2, title: 'Active'),
          date: DateTime(2017, 9, 7, 17, 30),
          frontyard: optionsList[1],
          sideyard: optionsList[0],
          stringTrimming: false,
          backyard: optionsList[1],
          clearClipping: true,
          providerAfterImages: [
            'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
            'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
            'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
            'https://www.mcleishorlando.com/wp-content/uploads/2020/02/47aa303323502cf42388fe91f8543644.jpg'
          ],
          providerBeforeImages: [
            'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
            'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
            'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
            'https://www.mcleishorlando.com/wp-content/uploads/2020/02/47aa303323502cf42388fe91f8543644.jpg'
          ],
        ),
      ],
    );

    // _currentProvider = Provider(
    //   firstName: 'ALi',
    //   email: 'ALi@email.com',
    //   lastName: 'Dali',
    //   reports:
    // );
  }
}
