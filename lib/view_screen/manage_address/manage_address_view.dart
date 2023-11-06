import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';

import '../../Utils/colors.dart';
import '../../controllers/manage_address_controller.dart';

class ManageAddress extends StatefulWidget {
  const ManageAddress({Key? key}) : super(key: key);

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ManageAddressController(),
      builder: (controller) {
      return RefreshIndicator(
        // key: controller.refreshIndicatorKey,
        onRefresh: () {
          return controller.getAddressData();
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
            Get.toNamed(addAddressScreen);
            },
            foregroundColor: AppColors.primary,
            backgroundColor:AppColors.secondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: const Icon(Icons.add,color: AppColors.whit,),
          ),
          appBar: AppBar(
            centerTitle : true,
            backgroundColor: AppColors.primary,
            title:const Text('Manage Address'),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
          ),
          body: controller.isBusy
              ? const Center(
                   child: CircularProgressIndicator(
                   color: AppColors.secondary,
            ),
          ) :
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
                height: MediaQuery.of(context).size.height / 1.2,
                  width: MediaQuery.of(context).size.width / 1,
              child:controller.addressData.isEmpty ?const Center(child: Text('Data not Found')):ListView.builder(
                   itemCount: controller.addressData.isEmpty ? 0 : controller.addressData.length,
                   physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {

                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                      color: AppColors.textFieldClr,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${controller.addressData[index].name} ,${controller.addressData[index].mobile}',
                                style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w700),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(addAddressScreen,arguments:true);
                                  controller.addId = controller.addressData[index].id;
                                  controller.saveIndexToSharedPreferences();
                                },
                                child: Container(
                                  width: 60,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(color: AppColors.whit),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              controller.addressData[index].address.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(color: AppColors.black,fontSize: 12, fontWeight: FontWeight.w500,),
                            ),
                          ),
                          // Text(
                          //   controller.addressData[index].pincode,
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 2,
                          //   style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.w700),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor: MaterialStateColor.resolveWith((states) => AppColors.secondary),
                                value: controller.selectedAddressIndex == index,
                                onChanged: (val) {
                                  controller.setSelectedAddressIndex(index);
                                  controller.update();
                                },
                              ),
                              const Text('Marked as Default'),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  controller.deleteAddress(index);
                                },
                                child: Container(
                                  width: 60,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: AppColors.whit),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        )


            ],
            ),
          ),
        ),
      );
    },);
  }
}
