import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/Widgets/app_button.dart';
import 'package:lucknowichickenkari_app/controllers/forget_password_controlller.dart';

import '../../Widgets/show_message.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ForgetPassController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back,color: AppColors.whit,)),
          title:const Text('Forget Password',style: TextStyle(color: AppColors.white),),
        ),
        body:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            // key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20,),
                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: AppColors.primary),
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: AppColors.primary)
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Email validation
                    String pattern =
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                    RegExp regExp = RegExp(pattern);
                    if (!regExp.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.email = value!;
                  },
                ),
                const SizedBox(height: 20),
             AppBtn(
               height: 45,
               width: 130,
               title: 'Submit',
               onPress: () {
                 if (controller.emailController.text.isNotEmpty) {
                   // Implement your logic for submitting the email
                   print('Requesting password reset for ${controller.email}');
                 }else{
                   ShowMessage.showSnackBar('Server Res','Enter Email id');

                 }
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
