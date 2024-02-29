import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/my_transaction_controller.dart';

import '../../Utils/colors.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyTransactionController(),
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
          title:const Text('Transaction',style: TextStyle(color: AppColors.white),),
        ),
        body: const Center(child: Text('Data Not Found')),
      );
    },);
  }
}
