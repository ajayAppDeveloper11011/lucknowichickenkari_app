import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/cate_controller.dart';

import '../../Route_managements/routes.dart';
import '../../Utils/colors.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>with SingleTickerProviderStateMixin{
  List<bool> categoryVisibility = List.generate(3, (index) => false); // Initialize with false values for 3 categories
  int currentIndex=1;
  int? selected=0;
   late AnimationController _controller;
   late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CategoryController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back,color: AppColors.whit,)),
          backgroundColor: AppColors.primary,
          title: const Text('Categories',style: TextStyle(color:AppColors.white),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.categoryListData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: InkWell(
                          onTap: () {
                            controller.curIndex = index;
                            controller.update();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: controller.curIndex == index
                                        ? AppColors.primary
                                        : AppColors.whit,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: AppColors.primary)
                                ),
                                child: Center(
                                  child: Text(
                                    controller.categoryListData[index].catTitle,
                                    style: TextStyle(
                                      color: controller.curIndex == index
                                          ? AppColors.whit
                                          : AppColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Visibility(
                visible: controller.curIndex == 0,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.categoryListData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(subCateScreen,arguments:controller.categoryListData[index].slug);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical:5),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.categoryListData[index].catTitle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        "Explore Now",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Hero(
                                  tag: 'image$index',
                                  child: ClipRRect(
                                    borderRadius:const BorderRadius.only(
                                        bottomRight: Radius.circular(7.0),
                                        topRight: Radius.circular(7.0)),
                                    child:controller.categoryListData[index].catImage==''?Image.asset('assets/images/formal_image1.jpg', fit: BoxFit.fill,
                                      height: 120,
                                      width: 120,) : Image.network(
                                      controller.categoryListData[index].catImage,
                                      fit: BoxFit.fill,
                                      height:130,
                                      width: 120,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Visibility(
                visible: controller.curIndex == 1,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.womenCategoryData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(subCateScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical:5),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.categoryListData[index].catTitle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        "Explore Now",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Hero(
                                  tag: 'image$index',
                                  child: ClipRRect(
                                    borderRadius:const BorderRadius.only(
                                        bottomRight: Radius.circular(7.0),
                                        topRight: Radius.circular(7.0)),
                                    child:controller.categoryListData[index].catImage==''?Image.asset(controller.womenCategoryData[index]['categoryImage'], fit: BoxFit.fill,
                                      height: 120,
                                      width: 120,) : Image.network(
                                      controller.categoryListData[index].catImage,
                                      fit: BoxFit.fill,
                                      height:130,
                                      width: 120,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Visibility(
                visible: controller.curIndex == 2,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.categoryListData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(subCateScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical:5),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.categoryListData[index].catTitle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        "Explore Now",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Hero(
                                  tag: 'image$index',
                                  child: ClipRRect(
                                    borderRadius:const BorderRadius.only(
                                        bottomRight: Radius.circular(7.0),
                                        topRight: Radius.circular(7.0)),
                                    child:controller.categoryListData[index].catImage==''?Image.asset('assets/images/formal_image1.jpg', fit: BoxFit.fill,
                                      height: 120,
                                      width: 120,) : Image.network(
                                      controller.categoryListData[index].catImage,
                                      fit: BoxFit.fill,
                                      height:130,
                                      width: 120,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ],
          ),
        ),
      );
    },);
  }


}
