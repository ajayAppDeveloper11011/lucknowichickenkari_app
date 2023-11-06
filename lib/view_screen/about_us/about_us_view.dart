import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/about_us_controller.dart';

import '../../Utils/colors.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AboutUsController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle : true,
          backgroundColor: AppColors.primary,
          title:const Text('About Us'),
        ),
        body: Container(
          padding: const EdgeInsets.only(left:20,right: 20,top: 20 ),
          child: const Text('An ecommerce app allows users to shop online, browse product catalogs, create wish lists, add items to a cart, and complete purchases. It also provides payment processing, '
              'shipping, and order management capabilities',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600),),
        ),
      );
    },);
  }
}
