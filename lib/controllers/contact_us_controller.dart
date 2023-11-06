import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:lucknowichickenkari_app/models/contact_us_response_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';

class ContactUsController extends AppBaseController{
  void onInit(){
    super.onInit();
    contactData();

  }

  final Uri url = Uri.parse('https://sdmipl.com/');

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }




  // List <OrderData> orderListData = [] ;

  Future<void> contactData() async {

    setBusy(true);

    try {
      Map<String, String> body = {};
      body[RequestKeys.slug]= 'contact-us';
      ContactUsModel res = await api.contactUsDataApi(body);
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