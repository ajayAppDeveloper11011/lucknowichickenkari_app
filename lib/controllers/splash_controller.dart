import 'dart:async';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Route_managements/routes.dart';

class SplashController extends AppBaseController {

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('user_id');
    print('this is userid====$user_id');
    if(user_id == null){
      Future.delayed( const Duration(seconds: 3),(){
        Get.offNamed(bottomBar);
      });

    }else{
      Future.delayed( const Duration(seconds: 3),(){
        Get.offNamed(bottomBar);
      });

    }
    // TODO: implement initState

  }



}