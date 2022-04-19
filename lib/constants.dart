import 'package:ServiceHub/models/customer.dart';
import 'package:flutter/material.dart';

import 'models/address.dart';

// const kCustomerRoute = '/Customer';
// const kProviderRoute = '/Provider';

// Hint text color (0xFF9D9D9E)
// Main Color (0xFF2C72D4)
//Pending color (0xFFDD9934)
//#DD9934

const kPrimaryColor = Color(0xFF2C72D4);
const kPrimaryColorLight = Color(0xFFAAB6C6);

const kSuccessColor = kConfirmButtonColor;
const kFailureColor = kCancelButtonColor;

// const kBackgronudColor = Colors.white;
const kBackgronudColor = Color(0xFFF4F4F4);
//#F4F4F4
const kEditButtonColor = Color(0xFF468CD2);
const kCancelButtonColor = Color(0xFFEF3D55);
const kConfirmButtonColor = Color(0xFF85C15D);

const kSnowBoxColor = Color(0xFF468CD2);
const kLawnBoxColor = Color(0xFF85C15D);

final kHintTextStyle = TextStyle(
  color: Color(0xFF9D9D9E),
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Color(0xFF9D9D9E),
  fontWeight: FontWeight.normal,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  // color: Color(0xFFF4F4F4),
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

const kTitleStyle = TextStyle(
  fontSize: 25.0,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);

const kPriceStyle = TextStyle(
  fontSize: 25.0,
  color: Color(0xFFB786252c),
  fontWeight: FontWeight.w500,
);

//  Status Card Style
const kStatusStyle = TextStyle(
  fontSize: 22.0,
  color: Color(0xFF81D742),
  fontWeight: FontWeight.w400,
);

const kGridTitleStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

const kGridPriceStyle = TextStyle(
  fontSize: 20.0,
  color: Color(0xFFB786252c),
  fontWeight: FontWeight.w600,
);

// Detail Screen Style
const kStatusDetailStyle = TextStyle(
  fontSize: 25.0,
  color: Color(0xFF81D742),
  fontWeight: FontWeight.w500,
);

const kheaderDetailStyle = TextStyle(
  fontSize: 22.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

const kCardDetailStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);

const kDateStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.black,
  fontWeight: FontWeight.w300,
);

// class Constant {
//   final currentUser = Customer(addresses: [
//     Address(id: 1, formattedAddress: "123 Windsor"),
//     Address(id: 2, formattedAddress: "456 Windsor"),
//     Address(id: 3, formattedAddress: "789 Windsor")
//   ]);
// }

  // backgrond color
// Container(
//   height: double.infinity,
//   width: double.infinity,
//   decoration: BoxDecoration(
//     gradient: LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         Color(0xFF73AEF5),
//         Color(0xFF61A4F1),
//         Color(0xFF478DE0),
//         Color(0xFF398AE5),
//       ],
//       stops: [0.1, 0.4, 0.7, 0.9],
//     ),
//   ),
// ),