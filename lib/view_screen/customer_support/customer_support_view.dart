import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Widgets/app_button.dart';
import 'package:lucknowichickenkari_app/controllers/customer_support_controller.dart';

import '../../Utils/colors.dart';

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CustomerSupportController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle : true,
          backgroundColor: AppColors.primary,
          title:const Text('Customer Support'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10,top:20),
            child: Column(
              children: [
                controller.setType(),
                controller.setEmail(),
                controller.setTitle(context),
                controller.setDesc(context),
               const SizedBox(height: 30,),
               AppBtn(
                 height:45,
                 title: 'Send',
                 width: 110,
                 onPress: () {
                   // Get.toNamed(loginScreen)
                 },

               )
              ],
            ),
          ),
        ),
      );
    },);
  }
}
