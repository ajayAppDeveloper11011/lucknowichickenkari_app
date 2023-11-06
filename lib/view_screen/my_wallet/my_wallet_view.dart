import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/my_wallet_controller.dart';
import '../../Utils/colors.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyWalletController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle : true,
          backgroundColor: AppColors.primary,
          title:const Text('My Wallet'),
        ),
        body: Column(
          children: [
            controller.showContent(context)
          ],
        ),
      );
    },);
  }
}
