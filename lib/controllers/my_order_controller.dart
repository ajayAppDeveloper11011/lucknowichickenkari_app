import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lucknowichickenkari_app/Services/api_client.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:lucknowichickenkari_app/models/get_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Route_managements/routes.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';

class MyOrderController extends AppBaseController{

  void onInit(){
    super.onInit();
    print('Hello');
    myOrderData();
  }



  onTapOrderDetailsScreen(index){

    Get.toNamed(myOrderDetailsScreen,arguments:orderListData[index].orderId);
  }

  List <OrderData> orderListData = [] ;

  Future<void> myOrderData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString('user_id');
    setBusy(true);

    try {
      Map<String, String> body = {};
      body[RequestKeys.userId]= userId.toString();
      body[RequestKeys.uniqueClientId]=ApiClient.uniqueKey;
      GetOrderModel res = await api.getOrderDataApi(body);
      print('-----place order------>$body');
      print('-----status------${res.message}');
      if (res.error==true) {
        orderListData = res.data;
        print('-----------my order-----${res.data}');
        ShowMessage.showSnackBar('Server Res',res.message);
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