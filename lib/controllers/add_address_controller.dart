
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Services/api_client.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:lucknowichickenkari_app/models/add_address_model.dart';
import 'package:lucknowichickenkari_app/models/update_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import '../map/Map.dart';
import '../session/Session.dart';

class AddAddressController extends AppBaseController{
 bool? val = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments!=null){
       val = Get.arguments;
       // addId =
      print('--------------ll---$val');
    }
  }

 String? userId,areaName,cityName,stateName,countryName,pinCode,mark,addName;
  List areaSearchList = [
    'Vijay Nagar',
    'Azad Nagar',
    'Khajrana'
  ];

  List citySearchLIst = [
    'Indore',
    'Bhopal',
    'Ujjain'
  ];

  List<AddAddressModelResponse>addressData = [];


  /// Address add Api Integration-------->
  Future<void> addAddressR() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
     userId = pref.getString('user_id');
     addName = pref.getString('addR');
     areaName = pref.getString('area_name');
     cityName = pref.getString('city_name');
     stateName = pref.getString('state_name');
     countryName = pref.getString('country_name');
     pinCode = pref.getString('pin_code_num');
     mark = pref.getString('mark');
     String? user_name = pref.getString('name_user');
     String? user_mob = pref.getString('mob_user');

    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.uniqueClientId]=ApiClient.uniqueKey;
      body[RequestKeys.userId]= userId.toString();
      body[RequestKeys.name]=user_name.toString();
      body[RequestKeys.mobile]=user_mob.toString();
      body[RequestKeys.address]= addName.toString();
      body[RequestKeys.landmark]= mark.toString();
      body[RequestKeys.area]= areaName.toString();
      body[RequestKeys.city]= cityName.toString();
      body[RequestKeys.state]= stateName.toString();
      body[RequestKeys.country]= countryName.toString();
      body[RequestKeys.pinCode]= pinCode.toString();
      AddAddressModelResponse res = await api.addAddressDataApi(body);
      print('----------->${body}');
      print('--------<<<<<<__${res.message}');
      if (res.error==true) {

        ShowMessage.showSnackBar('Server Res', res.message);
        Get.offNamed(manageAddressScreen);
        setBusy(false);
        update();

      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }


 /// Address Update Api Integration------->

 Future<void> updateAddress() async {
   SharedPreferences pref = await SharedPreferences.getInstance();
   userId = pref.getString('user_id');
   addName = pref.getString('addR');
   areaName = pref.getString('area_name');
   cityName = pref.getString('city_name');
   stateName = pref.getString('state_name');
   countryName = pref.getString('country_name');
   pinCode = pref.getString('pin_code_num');
   mark = pref.getString('mark');
   int? id = pref.getInt('address_id');
   String? user_name = pref.getString('name_user');
   String? user_mob = pref.getString('mob_user');

   setBusy(true);
   try {
     Map<String, String> body = {};
     body[RequestKeys.uniqueClientId]=ApiClient.uniqueKey;
     body[RequestKeys.userId]= userId.toString();
     body[RequestKeys.name]= user_name.toString();
     body[RequestKeys.mobile]=user_mob.toString();
     body[RequestKeys.address]= addName.toString();
     body[RequestKeys.landmark]= mark.toString();
     body[RequestKeys.area]= areaName.toString();
     body[RequestKeys.city]= cityName.toString();
     body[RequestKeys.state]= stateName.toString();
     body[RequestKeys.country]= countryName.toString();
     body[RequestKeys.pinCode]= pinCode.toString();
     body[RequestKeys.uniqueAddressId]= id.toString();
     UpdateAddressResponseModel res = await api.updateAddressDataApi(body);
     print('----------->${body}');
     print('-------........${res.message}');
     if (res.error==true) {
       ShowMessage.showSnackBar('Server Res', res.message);
       Get.offNamed(manageAddressScreen);
       setBusy(false);
       update();

     }

   } catch (e) {
     ShowMessage.showSnackBar('Server Res', '$e');
   } finally {
     setBusy(false);
     update();
   }
 }



}