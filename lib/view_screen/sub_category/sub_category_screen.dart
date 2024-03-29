import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/sub_cate_controller.dart';

import '../../Route_managements/routes.dart';
import '../../Utils/colors.dart';
import '../../Widgets/show_message.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SubCategoryController(),
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
          title: const Text('Sub Category',style: TextStyle(color: AppColors.white),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              controller.sub_CategoryData.isEmpty? const Padding(
                padding: EdgeInsets.only(top:350.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Data Not Found')),
              ):Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1,
                  width: MediaQuery.of(context).size.width / 1,
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.sub_CategoryData.isEmpty ? 0 : controller.sub_CategoryData.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 7,
                      childAspectRatio: 0.85,
                      mainAxisSpacing: 9,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if(controller.userId==null){
                            ShowMessage.showSnackBar('Server Res','Please Login First');
                          }else{
                            // Get.toNamed(productScreen,arguments:controller.sub_CategoryData[index]);
                            Get.toNamed(productScreen, arguments: {
                              'subCateData': [controller.sub_CategoryData[index]],
                              'origin': 'subcategory', // Add this to indicate navigation from the Subcategory screen
                            });

                          }
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:controller.sub_CategoryData[index].subcategoryImage==''?Image.asset('assets/images/formal_image1.jpg',fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: double.infinity) : Image.network(
                                  controller.sub_CategoryData[index].subcategoryImage,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.sub_CategoryData[index].subcatTitle,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${controller.menCategoryData[index]['subcategoryPrice']}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
              const SizedBox(height:40,),
            ],
          ),
        ),
      );
    },);
  }
}
