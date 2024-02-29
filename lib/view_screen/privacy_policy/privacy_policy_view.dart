import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/privacy_policy_controller.dart';
import '../../Utils/colors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PrivacyPolicyController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle : true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back,color: AppColors.whit,)),
          backgroundColor: AppColors.primary,
          title:const Text('Privacy Policy',style: TextStyle(color: AppColors.white),),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 10,right: 10,top:20),
          child:const Text('We at Wasai LLC respect the privacy of your personal information and,'
              ' as such, make every effort to ensure your information is protected and remains private. As the owner '
              'and operator of loremipsum.io (the "Website") '
              'hereafter referred to in this Privacy Policy as "Lorem Ipsum",'
              ' "us", "our" or "we", we have provided this Privacy Policy to explain '
              'how we collect, use, share and protect information about the users of '
              'our Website (hereafter referred to as “user”, “you” or "your"). '
              'For the purposes of this Agreement, any use of the terms "Lorem Ipsum",'
              ' "us", "our" or "we" includes Wasai LLC, without limitation. '
              'We will not use or share your personal information with anyone except '
              'as described in this Privacy Policy.',style: TextStyle(color:
          AppColors.black,fontWeight: FontWeight.w500),) ,
        ),
      );
    },);
  }
}
