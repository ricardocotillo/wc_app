import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:wc_app/providers/checkout.provider.dart';
import 'package:wc_app/views/checkout/personalInfo.view.dart';
import 'package:geocoding/geocoding.dart';

class AddressView extends StatefulWidget {
  final bool delivery;
  final apiKey = 'AIzaSyBdmrOPOTyhh7XKkjReNcEu4jVx-fieKhM';
  const AddressView({Key key, this.delivery = false}) : super(key: key);
  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-12.046374, -77.042793),
    zoom: 17,
  );

  Marker _marker = Marker(
    markerId: MarkerId('position'),
    position: LatLng(-12.046374, -77.042793),
  );

  String _address;

  String _district;

  Widget _addressWidget;

  LatLng _latLng;

  @override
  Widget build(BuildContext context) {
    final CheckoutProvider _checkoutProvider =
        Provider.of<CheckoutProvider>(context);
    return Scaffold(
      floatingActionButton: _addressWidget != null || _address != null
          ? FloatingActionButton(
              onPressed: () {
                if (widget.delivery) {
                  _checkoutProvider.deliveryAddress = _address;
                  _checkoutProvider.deliveryDistrict = _district;
                  _checkoutProvider.deliveryLatLng = _latLng;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PersonalInfoView(delivery: true),
                  ));
                } else {
                  _checkoutProvider.address = _address;
                  _checkoutProvider.district = _district;
                  _checkoutProvider.latLng = _latLng;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PersonalInfoView(),
                  ));
                }
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
              scrollGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (LatLng latLng) async {
                Widget addressWidget = await showAddress(latLng);
                setState(() {
                  _addressWidget = addressWidget;
                  _latLng = latLng;
                  _marker = Marker(
                    markerId: MarkerId('position'),
                    position: latLng,
                  );
                });
              },
              zoomGesturesEnabled: true,
              markers: Set<Marker>.of([_marker]),
            ),
            _addressWidget != null
                ? Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 15),
                            child: _addressWidget,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              _addressWidget = null;
                            });
                          },
                        )
                      ],
                    ),
                  )
                : Positioned(
                    top: 15,
                    child: SearchMapPlaceWidget(
                      apiKey: 'AIzaSyBdmrOPOTyhh7XKkjReNcEu4jVx-fieKhM',
                      language: 'es',
                      placeholder: 'Escribe tu dirección aquí',
                      onSelected: (Place place) async {
                        Geolocation geo = await place.geolocation;
                        var component =
                            (geo.fullJSON['address_components'] as List)
                                .firstWhere((ac) => (ac['types'] as List)
                                    .any((element) => element == 'locality'));

                        setState(() {
                          _district = component['long_name'];
                          _address = place.description;
                          _latLng = geo.coordinates;
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

  Future<Widget> showAddress(LatLng latLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );
    if (placemarks.length > 0) {
      setState(() {
        _district = placemarks[0].locality;
        _address =
            '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}';
      });
      return Text(_address);
    }
    return null;
  }
}
