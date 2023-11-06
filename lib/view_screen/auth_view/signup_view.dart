import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/singup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SignUpController(),
      builder:(controller) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        body : Stack(
          children: [
            controller.getLogo(context),
            controller.getSignUpContainer(context),
          ],
        ),
      );
    },);
  }
}
