import 'package:ServiceHub/Customer/Screens/detail_screen.dart'
    as CustomerScreens;
import 'package:ServiceHub/Provider/Screens/detail_screen.dart'
    as ProviderScreens;
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'asset_image.dart';

class ServiceRequestCardGrid extends StatelessWidget {
  final ServiceRequest serviceRequest;

  ServiceRequestCardGrid(this.serviceRequest);

  @override
  Widget build(BuildContext context) {
    String serviceType = 'Service Request';
    if (serviceRequest is SnowRequest) serviceType = 'Snow Removing';
    if (serviceRequest is LawnRequest) serviceType = 'Lawn Mowing';

    return GestureDetector(
      onTap: () {
        if (Account.currentUser is Customer)
          Navigator.of(context).pushNamed(CustomerScreens.DetailScreen.route,
              arguments: serviceRequest);

        if (Account.currentUser is Provider)
          Navigator.of(context).pushNamed(ProviderScreens.DetailScreen.route,
              arguments: serviceRequest);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(7.0),
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: serviceRequest.customerImages.first,
                        placeholder: (context, url) =>
                            assetImage("images/placeholderImage.png", context),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            serviceType,
                            style: kGridTitleStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          spacer(height: 7),
                          Text(
                            ("${serviceRequest.fPrice}"),
                            style: kGridPriceStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          spacer(height: 7),
                          Text(
                            serviceRequest.status.title,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: serviceRequest.status.color,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          spacer(height: 7),
                          Text(
                            serviceRequest.fDate,
                            style: kDateStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          if (serviceRequest.distance > 0)
                            Text('(${serviceRequest.fDistance} km)'),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
