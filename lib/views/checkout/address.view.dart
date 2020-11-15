import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:wc_app/providers/checkout.provider.dart';
import 'package:wc_app/views/checkout/personalInfo.view.dart';

class AddressView extends StatefulWidget {
  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-12.046374, -77.042793),
    zoom: 14.4746,
  );

  Marker _marker = Marker(
    markerId: MarkerId('position'),
    position: LatLng(-12.046374, -77.042793),
  );

  String _address;

  String _district;

  @override
  Widget build(BuildContext context) {
    final CheckoutProvider _checkoutProvider =
        Provider.of<CheckoutProvider>(context);
    return Scaffold(
      floatingActionButton: _address != null
          ? FloatingActionButton(
              onPressed: () {
                _checkoutProvider.address = _address;
                _checkoutProvider.district = _district;
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonalInfoView(),
                ));
              },
              child: Icon(FontAwesomeIcons.check),
            )
          : null,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              liteModeEnabled: true,
              zoomControlsEnabled: false,
              markers: Set<Marker>.of([_marker]),
            ),
            Positioned(
              top: 15,
              child: SearchMapPlaceWidget(
                apiKey: 'AIzaSyBdmrOPOTyhh7XKkjReNcEu4jVx-fieKhM',
                onSelected: (Place place) async {
                  Geolocation geo = await place.geolocation;
                  var component = (geo.fullJSON['address_components'] as List)
                      .firstWhere((ac) => (ac['types'] as List)
                          .any((element) => element == 'locality'));

                  setState(() {
                    _district = component['long_name'];
                    _address = place.description;
                    _marker = Marker(
                      markerId: MarkerId('position'),
                      position: geo.coordinates,
                    );
                  });
                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(
                    target: geo.coordinates,
                    zoom: 19,
                  )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getDistrict(dynamic json) {}
}
