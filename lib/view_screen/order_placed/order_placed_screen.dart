import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/order_placed_controller.dart';

import '../../Widgets/bottom_navigation_bar/bottom_bar.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({Key? key}) : super(key: key);

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OrderPlacedController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back,color: AppColors.white,)),
          backgroundColor: AppColors.primary,
          title: const Text('Order Placed ',style:TextStyle(color:AppColors.white),),
        ),
        body: Container(
              height: MediaQuery.of(context).size.height/1,
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Image.asset('assets/images/order_plcaed1.jpg',fit: BoxFit.fill,),
                const SizedBox(height: 70,),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width/1.2,
                  child: ElevatedButton(
                    onPressed: () {
                     Get.toNamed(bottomBar);
                     controller.update();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      'Continue Shopping',
                      style: TextStyle(
                        fontSize:15,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width/1.2,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(myOrderScreen);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      'View Order',
                      style: TextStyle(
                        fontSize:15,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      );
    },);
  }
}
