import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Services/api_client.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import '../models/delete_address_model.dart';
import '../models/get_address_response.dart';

class ManageAddressController extends AppBaseController{
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  var addId;
  List<GetAddressData>addressData = [];

  // List<bool>? isChecked= [
  //   false,true
  // ] ;

  // Function to save the index to SharedPreferences
  Future<void> saveIndexToSharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('address_id', addId);

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAddressData();
  }


  onTapBack(){
    Get.back();

  }



  int selectedAddressIndex = -1; // Initialize with an invalid index

  void setSelectedAddressIndex(int index) {
    if (selectedAddressIndex == index) {
      selectedAddressIndex = -1; // Deselect the checkbox if it is already selected
      update();
    } else {
      selectedAddressIndex = index; // Select the checkbox at the given index
      update();
    }
  }


  /// Get Address Data Api Integration---------->
  Future<void> getAddressData() async {
    update();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString('user_id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.uniqueClientId]=ApiClient.uniqueKey;
      body[RequestKeys.userId]= userId.toString();
      GetAddressModelResponse res = await api.getAddressDataApi(body);
      print('----------->${body}');
      if (res.error==true) {
        addressData = res.data;
        print('_____address_____${addressData}_____________');
        print('_____message____${res.message}_____________');

        //ShowMessage.showSnackBar('Server Res', res.message ?? '');
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

  /// Delete Address Api Integration------->
  Future<void> deleteAddress(index) async {

    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.uniqueClientId]=ApiClient.uniqueKey;
      body[RequestKeys.uniqueAddressId]=addressData[index].id.toString();

      DeleteAddressResponseModel res = await api.deleteAddressDataApi(body);
      print('----------->$body');
      print('--------<<<<<<__${res.message}');
      if (res.error==true) {
        ShowMessage.showSnackBar('Server Res', res.message);
        setBusy(false);
        getAddressData();
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