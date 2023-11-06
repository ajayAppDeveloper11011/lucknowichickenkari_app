
import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/responsive_layout/responsive.dart';
import '../../Utils/colors.dart';
import 'bottom_bar_controller.dart';



class BottomBar extends StatefulWidget {
  final int? index;
  final String? groupJoined;

  const BottomBar({Key? key, this.index, this.groupJoined}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var _selBottom = 0;

  //String? bookID;

  bool isLoading = false;

  Widget _getBottomNavigator(BottomBarController controller) {
    return Material(
      // color: AppColor().colorTextwhit(),
      //elevation: 2,
      child: CurvedNavigationBar(
        color: AppColors.primary,
        index: controller.currentIndex,
        height: 50,
        buttonBackgroundColor: AppColors.whit,
        backgroundColor: AppColors.whit,
        items: <Widget>[
          Padding(
              padding: const EdgeInsets.all(4.0),
              child:Icon(Icons.home,
                color: controller.currentIndex == 0
                    ? AppColors.primary
                    : AppColors.whit,
              )),
          Padding(
              padding: const EdgeInsets.all(4.0),
              child:Icon(Icons.category_outlined,
                color: controller.currentIndex == 1
                    ? AppColors.primary
                    : AppColors.whit,
              )),
          Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.shopping_cart,
                color: controller.currentIndex == 2
                    ? AppColors.primary
                    : AppColors.whit,
              )),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child:Icon(Icons.person_outline,
              // _currentIndex == 3 ?,
              // : Icons.person_3_outlined,
              color: controller.currentIndex == 3
                  ? AppColors.primary
                  : AppColors.whit,
            ),
          ),
        ],
        onTap: (index) {
          print("current index here ${index}");
            controller.currentIndex = index;
            print("sel bottom ${_selBottom}");
            controller.update();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm Exit"),
                  content: const Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: AppColors.primary),
                      child: const Text("YES"),
                      onPressed: () {
                        exit(0);
                        // Get.toNamed(splashScreen);
                        // SystemNavigator.pop();
                      },
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: AppColors.primary),
                      child: const Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return true;
        },
        child: GetBuilder(
          init: BottomBarController(),
          builder: (controller) => Scaffold(
              key: scaffoldKey,
              body: controller.handlePages[controller.currentIndex],
              bottomNavigationBar:ResponsiveLayout.isWebScreen(context)?const SizedBox.shrink(): _getBottomNavigator(controller)),
        )
    );
  }
}
