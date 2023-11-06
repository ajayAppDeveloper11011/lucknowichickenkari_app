
import 'package:lucknowichickenkari_app/models/get_notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class NotificationController extends AppBaseController{


  void onInit(){
    super.onInit();
    notificationData();
  }

  // List <OrderData> orderListData = [] ;

  Future<void> notificationData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString('user_id');
    setBusy(true);

    try {
      Map<String, String> body = {};
      body[RequestKeys.userId]= userId.toString();
      GetNotificationModel res = await api.getNotificationDataApi(body);
      print('-----Notification------>$body');
      print('-----Notification Message------${res.message}');
      if (res.error==true) {
        // orderListData = res.data;
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