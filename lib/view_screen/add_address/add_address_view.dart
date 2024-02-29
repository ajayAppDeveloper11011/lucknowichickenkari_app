import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/add_address_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../session/Session.dart';

class AddAddressScreen extends StatefulWidget {
  String? locationController;
  String? area,city,stateName,country,pincode,street;
  AddAddressScreen({Key? key,this.locationController,this.area,this.city,this.country,this.stateName,this.pincode,this.street}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController addC = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  TextEditingController? nameC, mobileC, pincodeC, addressC, landmarkC, stateC, countryC, altMobC;
  FocusNode? nameFocus, monoFocus, almonoFocus, addFocus, landFocus, locationFocus = FocusNode();
  String? name, mobile,mark, address,contryName, pinCode, landmark, altMob, type = "Home", isDefault;
  double? latitude, longitude, state;
  StateSetter? areaState, cityState;
  bool checkedDefault = false, isArea = false;
  TextEditingController recipientAddressCtr= TextEditingController();

  bool cityLoading = true, areaLoading = true;
  int? selAreaPos = -1, selCityPos = -1;
  int? selectedType = 1;
  String?newAddress,AddressC;
  late CameraPosition _cameraPosition;
  LatLng? latlong = null;
  GoogleMapController? _controller;
  double? lat1,long1;
  var area;
  var city;
  var stateName;
  var country;
  var pincode;
  var street;
  Set<Marker> _markers = Set();

  setData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('name_user',nameController.text);
    pref.setString('mob_user',mobileController.text);
    print('this is my mobile-----${mobileController.text}');
  }

  Future getCurrentLocation() async {
    List<Placemark> placemark =
    await placemarkFromCoordinates(lat1??0.00,long1??0.00);

    if (mounted) {

      latlong = LatLng(lat1!, long1!);

      _cameraPosition =
          CameraPosition(target: latlong!, zoom: 15.0, bearing: 0);
      if (_controller != null) {
        _controller!
            .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
      }
      setState(() {
        var address;
        address = placemark[0].name;
        address = address + "," + placemark[0].subLocality;
        address = address + "," + placemark[0].locality;
        address = address + "," + placemark[0].administrativeArea;
        address = address + "," + placemark[0].country;
        address = address + "," + placemark[0].postalCode;
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

        _markers.add(Marker(
          markerId: const MarkerId("Marker"),
          position: LatLng(lat1??0.00,long1??0.00),
        ));
      });
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('addR',recipientAddressCtr.text);
      pref.setString('area_name',area);
      pref.setString('city_name',city);
      pref.setString('state_name',stateName);
      pref.setString('country_name',country);
      pref.setString('pin_code_num',pincode);
      pref.setString('mark',street);



    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddAddressController(),
      builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.textFieldClr,
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back,color: AppColors.whit,)),
          title:const Text('Add Address',style: TextStyle(color:AppColors.white),),
          backgroundColor: AppColors.primary,
        ),
        body:Padding(
          padding: const EdgeInsets.only(left:10.0,right:10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                setUserName(context),
                setMobileNo(context),
                setAddress(context),
                setLandmark(),
                setCities(context),
                setArea(context),
                setPincode(context),
                setStateField(),
                setCountry(),
                typeOfAddress(),
                defaultAdd(),
                saveButton('Save', () {
                  if(controller.val==true){
                    controller.updateAddress();
                  }else{
                    setData();
                    controller.addAddressR();
                  }
                })

              ],
            ),
          ),
        ),
      );
    },);
  }



  setUserName(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whit,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            focusNode: nameFocus,
            controller: nameController,

            textCapitalization: TextCapitalization.words,
            validator: (val) => validateUserName(
                val!,
                'Name is require',
                'User'),
            onSaved: (String? value) {
              print('-----name------${name}');
              name = value;
            },
            onFieldSubmitted: (v) {
              _fieldFocusChange(context, nameFocus!, monoFocus);
            },
            style: const TextStyle(color: AppColors.primary,fontWeight: FontWeight.w600),
            decoration: const InputDecoration(
                label: Text('Name'),
                fillColor: AppColors.whit,
                isDense: true,
                hintText: 'Name',
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  setMobileNo(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color:AppColors.whit,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 10,
            controller: mobileController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textInputAction: TextInputAction.next,
            focusNode: monoFocus,
            style: const TextStyle(color:AppColors.primary),
            validator: (val) => validateMob(
                val!,'Mobile Number is required',
                'Valid mobile number'),
            onSaved: (String? value) {
              mobile = value;
            },
            onFieldSubmitted: (v) {
              _fieldFocusChange(context, monoFocus!, almonoFocus);
            },
            decoration: const InputDecoration(
                label: Text('Mobile Number'),
                fillColor: AppColors.whit,
                isDense: true,
                hintText:'Mobile',
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  setAddress(context) {
  return   Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whit,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(color:AppColors.fntClr),
                focusNode: addFocus,
                controller: recipientAddressCtr,
                validator: (val) => validateField(
                    val!, 'Field is require'),
                onSaved: (String? value) {
                  address = value;
                },
                onFieldSubmitted: (v) {
                },
                decoration: InputDecoration(
                  label: const Text('Address'),
                  fillColor:AppColors.whit,
                  isDense: true,
                  hintText: 'Address',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon:const Icon(
                      Icons.my_location,
                      color: AppColors.primary,
                    ),
                    onPressed: () async {
                      LocationPermission permission;
                      permission = await Geolocator.requestPermission();
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlacePicker(
                            apiKey: Platform.isAndroid
                                ? "AIzaSyDKeCyRs2FvhPpAipxstruQEKV5vJ0NIzA"
                                : "AIzaSyDKeCyRs2FvhPpAipxstruQEKV5vJ0NIzA",
                            onPlacePicked: (result) {
                              print(result.formattedAddress);
                              // Parsing the formattedAddress string to extract specific details
                              List<String> addressParts = result.formattedAddress!.split(',');
                              String state = addressParts.length >= 2 ? addressParts[addressParts.length - 2].trim() : '';
                              String country = addressParts.length >= 1 ? addressParts[addressParts.length - 1].trim() : '';
                              String area = ''; // You might need to find the corresponding part in the addressParts list for the area
                              String landmark = result.name ?? '';

                              print('State: $state');
                              print('Country: $country');
                              print('Area: $area');
                              print('Landmark: $landmark');
                              setState(() {
                                recipientAddressCtr.text =
                                    result.formattedAddress.toString();

                                lat1 = result.geometry!.location.lat;
                                long1 = result.geometry!.location.lng;
                                _cameraPosition = const CameraPosition(target: LatLng(0, 0), zoom: 10.0);
                                getCurrentLocation();
                              });

                              Navigator.of(context).pop();


                            },
                            initialPosition: const LatLng(
                                22.719568,75.857727),
                            useCurrentLocation: true,
                          ),
                        ),
                      );


                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

  setPincode(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color:AppColors.whit,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child:Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: GestureDetector(
              child: InputDecorator(
                  decoration: const InputDecoration(
                    fillColor:AppColors.whit,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Pin Code',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            pincode==null?const Text("Pin code"):Text('$pincode',

                                style: TextStyle(
                                    color: selCityPos != null
                                        ? AppColors.fntClr
                                        : Colors.grey)),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  )),
              // onTap: () {
              //   cityDialog(context);
              // },
            )),
      ),
    );
  }


  setLandmark() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whit,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child:Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: GestureDetector(
              child: InputDecorator(
                  decoration: const InputDecoration(
                    fillColor:AppColors.whit,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Landmark',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(street==null?"Landmark":'$street',

                                style: TextStyle(
                                    color: selCityPos != null
                                        ? AppColors.fntClr
                                        : Colors.grey)),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  )),
              // onTap: () {
              //   cityDialog(context);
              // },
            )),
      ),
    );
  }

  setStateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color:AppColors.whit,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: GestureDetector(
              child: InputDecorator(
                  decoration: const InputDecoration(
                    fillColor:AppColors.whit,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Selected State',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(stateName==null?"State":'$stateName',
                                style: TextStyle(
                                    color: selCityPos != null
                                        ? AppColors.fntClr
                                        : Colors.grey)),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  )),
              // onTap: () {
              //   cityDialog(context);
              // },
            )),
      ),
    );
  }

  setCountry() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whit,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: GestureDetector(
              child: InputDecorator(
                  decoration: const InputDecoration(
                    fillColor:AppColors.whit,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Selected Country',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(country==null?"Country":'$country',
                                style: TextStyle(
                                    color: selCityPos != null
                                        ? AppColors.fntClr
                                        : Colors.grey)),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  )),
              // onTap: () {
              //   cityDialog(context);
              // },
            )),
      ),
    );
  }


  // areaDialog(context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setStater) {
  //           areaState = setStater;
  //           return AlertDialog(
  //             contentPadding: const EdgeInsets.all(0.0),
  //             shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(
  //                   5.0,
  //                 ),
  //               ),
  //             ),
  //             content: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 const Padding(
  //                   padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
  //                   child: Text('Area Select',
  //                     style: TextStyle(color: AppColors.fntClr),
  //                   ),
  //                 ),
  //                 TextField(
  //                   style: const TextStyle(
  //                     color:AppColors.fntClr,
  //                   ),
  //                   controller: _areaController,
  //                   autofocus: false,
  //                   decoration: InputDecoration(
  //                     contentPadding: EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
  //                     prefixIcon:
  //                     const Icon(Icons.search, color:AppColors.primary, size: 17),
  //                     hintText: 'Search here',
  //                     hintStyle: TextStyle(
  //                       color: AppColors.primary.withOpacity(0.5),
  //                     ),
  //                     enabledBorder: const UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                           color: AppColors.whit
  //                       ),
  //                     ),
  //                     focusedBorder: const UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                           color:AppColors.whit
  //                       ),
  //                     ),
  //                   ),
  //                   // onChanged: (query) => updateSearchQuery(query),
  //                 ),
  //                 const Divider(color:AppColors.black),
  //                 areaLoading
  //                     ? Flexible(
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                         crossAxisAlignment:
  //                         CrossAxisAlignment.start,
  //                         children: getAreaList(context)),
  //                   ),
  //                 )
  //                     : Padding(
  //                   padding:
  //                   const EdgeInsets.symmetric(vertical: 20.0),
  //                   child: getNoItem(context),
  //                 )
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  //
  // cityDialog(context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setStater) {
  //           cityState = setStater;
  //           return AlertDialog(
  //             contentPadding: const EdgeInsets.all(0.0),
  //             shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(5.0),
  //               ),
  //             ),
  //             content: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 const Padding(
  //                   padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
  //                   child: Text('City',
  //                     style: TextStyle(color:AppColors.fntClr),
  //                   ),
  //                 ),
  //                 TextField(
  //                   controller: _cityController,
  //                   autofocus: false,
  //                   style: const TextStyle(
  //                     color:AppColors.fntClr,
  //                   ),
  //                   decoration: InputDecoration(
  //                     contentPadding: EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
  //                     prefixIcon:
  //                     const Icon(Icons.search, color:AppColors.primary, size: 17),
  //                     hintText:'Search',
  //                     hintStyle:
  //                     TextStyle(color:AppColors.primary.withOpacity(0.5)),
  //                     enabledBorder: const UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                           color:AppColors.whit),
  //                     ),
  //                     focusedBorder: const UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                           color:AppColors.whit),
  //                     ),
  //                   ),
  //                   // onChanged: (query) => updateSearchQuery(query),
  //                 ),
  //                 const Divider(color:AppColors.black),
  //
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }



  setCities(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color:AppColors.whit,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: GestureDetector(
              child: InputDecorator(
                  decoration: const InputDecoration(
                    fillColor:AppColors.whit,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Select City',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(city==null?"City":'$city',

                                style: TextStyle(
                                    color: selCityPos != null
                                        ? AppColors.fntClr
                                        : Colors.grey)),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  )),
              // onTap: () {
              //   cityDialog(context);
              // },
            )),
      ),
    );
  }

  setArea(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color:AppColors.whit,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: GestureDetector(
              child: InputDecorator(
                  decoration: const InputDecoration(
                      fillColor:AppColors.whit,
                      isDense: true,
                      border: InputBorder.none),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Area Select',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            Text(area==null?"Area":'${area}',
                                style: TextStyle(
                                    color: selAreaPos != null
                                        ? AppColors.fntClr
                                        : Colors.grey)),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right),
                    ],
                  )),
              // onTap: () {
              //   areaDialog(context);
              // },
            )),
      ),
    );
  }

  typeOfAddress()  {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color:AppColors.whit,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                child: Row(
                  children: [
                    Radio(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      groupValue: selectedType,
                      activeColor:AppColors.fntClr,
                      value: 1,
                      onChanged: (dynamic val) {
                        setState(() {
                          selectedType = val;
                          type = 'HOME';

                        });
                      },
                    ),
                    const Expanded(child: Text('Home'))
                  ],
                ),
                onTap: () {
                 setState(() {
                   selectedType = 1;
                   type = 'HOME';
                 });

                },
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Row(
                  children: [
                    Radio(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      groupValue: selectedType,
                      activeColor:AppColors.fntClr,
                      value: 2,
                      onChanged: (dynamic val) {
                        setState(() {
                          selectedType = val;
                          type = 'OFFICE';
                        });


                      },
                    ),
                    const Expanded(child: Text('OFFICE'))
                  ],
                ),
                onTap: () {
                  setState(() {
                    selectedType = 2;
                    type = 'OFFICE';

                  });

                },
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Row(
                  children: [
                    Radio(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      groupValue: selectedType,
                      activeColor:AppColors.fntClr,
                      value: 3,
                      onChanged: (dynamic val) {

                        setState(() {
                          selectedType = val;
                          type = 'OTHER';
                        });

                      },
                    ),
                    const Expanded(child: Text('OTHER'))
                  ],
                ),
                onTap: () {
                 setState(() {
                   selectedType = 3;
                   type = 'OTHER';
                 });

                },
              ),
            )
          ],
        ));
  }

  defaultAdd() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color:AppColors.whit,
          borderRadius: BorderRadius.circular(5),
        ),
        child: SwitchListTile(
          value: checkedDefault,
          activeColor:AppColors.fntClr,
          dense: true,
          onChanged: (newValue) {

            setState(() {
              checkedDefault = newValue;
            });



          },
          title: const Text('Default Add',
            style:TextStyle(color: AppColors.primary),
          ),
        ));
  }


  saveButton(String title, VoidCallback? onBtnSelected) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: MaterialButton(
              height: 45.0,
              textColor:AppColors.whit,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: onBtnSelected,
              child: Text(title),
              color:AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }


  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode? nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


}
