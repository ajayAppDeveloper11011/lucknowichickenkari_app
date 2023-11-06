import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:SplashController(),
      builder:(controller) {
      return Center(
        child: Container(
          height:MediaQuery.of(context).size.height/1,
          width:MediaQuery.of(context).size.width/1,
          child:Image.asset('assets/images/splashImage.jpg',fit: BoxFit.fill,),
        ),
      );
    },);
  }
}
