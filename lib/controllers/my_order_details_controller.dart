import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lucknowichickenkari_app/Services/api_client.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import '../models/get_order_details_response.dart';

class MyOrderDetailsController extends AppBaseController{
  List<OrderDetailsData>? orderDetailsData;
  String? orderId ;
  @override
  void onInit() {
    // TODO: implement onInit
    if(Get.arguments != null) {
      orderId  = Get.arguments;
      print('------orderId-----$orderId');
    }
    super.onInit();
    getOrderDetails();
  }

  int? curIndex = 0;
  List orderListView = [
    'All Details',
    'Processing',
    'Shipped',
    'Delivered',
    'Canceled',
    'Return'

  ] ;

  Widget buildOrderStatusTile(String status, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? Colors.green : Colors.grey,
            ),
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Container(),
          ),
          const SizedBox(width: 20),
          Text(
            status,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isCompleted ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getOrderDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.orderIdP] =orderId.toString();
      body[RequestKeys.uniqueClientId] =ApiClient.uniqueKey;
      body[RequestKeys.userId] =userId.toString();
      OrderDetailsResponseData res = await api.orderDetailsDataApi(body);
      print('___________checkkkk______${res.message}');

      if (res.error==true) {

        orderDetailsData = res.data;

        print('___________Details______${orderDetailsData?.first.size}');
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


}