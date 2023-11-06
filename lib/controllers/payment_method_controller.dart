import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentMethodController extends AppBaseController{
String? paymentName;
  onTapCartScreen(){

    Get.toNamed(cartScreen,arguments:paymentName);
  }



final RxList<PaymentMethod> paymentMethods = [

  PaymentMethod(name: 'Razorpay', isSelected: false, image: 'assets/images/razor_logo.jpg'),
  PaymentMethod(name: 'PayPal', isSelected: false, image: 'assets/images/paypal_logo.png'),
  PaymentMethod(name: 'COD', isSelected: false, image: 'assets/images/cash-on-delivery.png'),
  // Add more payment methods as needed
].obs;

Future<void> toggleSelection(int index) async {
  for (int i = 0; i < paymentMethods.length; i++) {
    if (i == index) {
      paymentMethods[i].isSelected = !paymentMethods[i].isSelected;
      paymentName = paymentMethods[index].name;
      print('-----------paymentSelected-------${paymentMethods[index].name}');

      SharedPreferences prefe = await SharedPreferences.getInstance();
      prefe.setString('payment_type', paymentName??'');
      update();

    } else {
      paymentMethods[i].isSelected = false;
    }
  }
  update();
}






}

class PaymentMethod {
  String name;
  String image;
  bool isSelected;

  PaymentMethod({required this.name, required this.isSelected,required this.image});
}






