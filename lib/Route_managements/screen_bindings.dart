import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class ScreenBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => SplashController() );
    // Get.lazyPut(() => const LoginScreen() );
    // Get.lazyPut(() =>  SignupScreen() );
    // Get.lazyPut(() =>  const BottomBar() );
    // Get.lazyPut(() =>  const OtpScreen() );



  }


}