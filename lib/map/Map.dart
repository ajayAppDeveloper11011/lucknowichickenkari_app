import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/session/Session.dart';
import 'package:lucknowichickenkari_app/view_screen/add_address/add_address_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Map1 extends StatefulWidget {
  final double? latitude, longitude;
  final String? from;

  Map1({Key? key, this.latitude, this.longitude, this.from})
      : super(key: key);

  @override
  _Map1State createState() => _Map1State();
}

class _Map1State extends State<Map1> {
  LatLng? latlong = null;
  String? latitude,longitude;
  late CameraPosition _cameraPosition;
  GoogleMapController? _controller;
  TextEditingController locationController = TextEditingController();
  Set<Marker> _markers = Set();
  var area;
  var city;
  var stateName;
  var country;
  var pincode;
  var street;

  Future getCurrentLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(widget.latitude!, widget.longitude!);

    if (mounted) {

        latlong = LatLng(widget.latitude!, widget.longitude!);

        _cameraPosition =
            CameraPosition(target: latlong!, zoom: 15.0, bearing: 0);
        if (_controller != null) {
          _controller!
              .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
        }

        var address;
        address = placemark[0].name;
        address = address + "," + placemark[0].subLocality;
        address = address + "," + placemark[0].locality;
        address = address + "," + placemark[0].administrativeArea;
        address = address + "," + placemark[0].country;
        address = address + "," + placemark[0].postalCode;

        locationController.text = address;
          area =placemark[0].subLocality;
          city = placemark[0].locality;
          stateName = placemark[0].administrativeArea;
          country = placemark[0].country;
          pincode = placemark[0].postalCode;
          street = placemark[0].street;

        print('-----------//////${street}');
        print('-----------//////${area}');
        print('-----------//////${city}');
        print('-----------//////${stateName}');
        print('-----------//////${country}');
        print('-----------//////${pincode}');
        print('lllllllllllllll${locationController.text}');
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('address_c',locationController.text);
        _markers.add(Marker(
          markerId: const MarkerId("Marker"),
          position: LatLng(widget.latitude!, widget.longitude!),
        ));


    }
  }

  @override
  void initState() {
    super.initState();

    _cameraPosition = const CameraPosition(target: LatLng(0, 0), zoom: 10.0);
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          getSimpleAppBar('Choose Location', context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(children: [
                (latlong != null)
                    ? GoogleMap(
                        initialCameraPosition: _cameraPosition,
                        onMapCreated: (GoogleMapController controller) {
                          _controller = (controller);
                          _controller!.animateCamera(
                              CameraUpdate.newCameraPosition(_cameraPosition));
                        },
                        markers: this.myMarker(),
                        onTap: (latLng) {
                          if (mounted) {
                            setState(
                              () {
                                latlong = latLng;
                              },
                            );
                          }
                        },
                      )
                    : Container(),
              ]),
            ),
            TextField(
              cursorColor: AppColors.black,
              controller: locationController,
              readOnly: true,
              style: const TextStyle(
                  color: AppColors.fntClr,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                icon: Container(
                  margin: const EdgeInsetsDirectional.only(start: 20, top: 0),
                  width: 10,
                  height: 10,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                ),
                hintText: "pick up",
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsetsDirectional.only(start: 15.0, top: 12.0),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text("Update Location",style: TextStyle(fontWeight: FontWeight.bold),),
              onPressed: () {

                if (widget.from == 'Add Address') {
                  latitude = latlong!.latitude.toString();
                  longitude = latlong!.longitude.toString();
                }
               print('new----addd----${locationController.text}');

                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddressScreen(
                  locationController:locationController.text,
                  area: area,city: city,country: country,stateName: stateName,pincode:pincode,street: street,
                )));
              },
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> myMarker() {
    if (_markers != null) {
      _markers.clear();
    }

    _markers.add(Marker(
      markerId: MarkerId(Random().nextInt(10000).toString()),
      position: LatLng(latlong!.latitude, latlong!.longitude),
    ));

    getLocation();

    return _markers;
  }

  Future<void> getLocation() async {

    List<Placemark> placemark =
        await placemarkFromCoordinates(latlong!.latitude, latlong!.longitude);

    var address;
    address = placemark[0].name;
    address = address + "," + placemark[0].subLocality;
    address = address + "," + placemark[0].locality;
    address = address + "," + placemark[0].administrativeArea;
    address = address + "," + placemark[0].country;
    address = address + "," + placemark[0].postalCode;
    locationController.text = address;
    if (mounted) setState(() {});
  }
}
