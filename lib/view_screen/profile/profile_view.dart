import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';

import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle : true,
          leading: InkWell(
            onTap: () {

            },
            child: const Icon(Icons.arrow_back,color: AppColors.white,),
          ),
          backgroundColor: AppColors.primary,
          title:const Text('My Profile',style: TextStyle(color: AppColors.white),),
        ),
        body : Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child:Column(
              children : [
                const SizedBox(height:20,),
                controller.userData.isEmpty
                    ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.primary))
                    :
                Container(
                       color: AppColors.whit,
                       height:110,
                       width: MediaQuery.of(context).size.width/1,
                     child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                        Stack(
                           children: [
                             Container(
                                margin: const EdgeInsetsDirectional.only(end: 20),
                                height:110,
                                width:110,
                                decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1.0, color:AppColors.whit)),
                               child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                 child: ClipRRect(
                                     borderRadius: BorderRadius.circular(50.0),
                                     child:controller.userData.first.profileImage.isEmpty? Image.asset("assets/images/man_image1.jpg",fit: BoxFit.fill,):Image.network(controller.userData[0].profileImage,fit: BoxFit.fill)

                              ),
                            ),
                          ),
                             Positioned(
                                top: 70,
                                left:70,
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                  child: Container(
                                     height:30,
                                     width: 30,
                                    decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(40)),
                                    child: InkWell(
                                       onTap: () {
                                        controller.openChangeUserDetailsBottomSheet(context);
                                      },
                                       child: const Icon(Icons.edit_outlined,color: AppColors.red,)),
                              ),
                            ),
                          )
                          ],
                      ),
                      const SizedBox(width:20,),
                      user_id==null? InkWell(
                        onTap: () {
                          controller.checkLogin();
                        },
                          child: const Text('Login',style: TextStyle(color: AppColors.black),)):Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30,),
                          controller.userData.first.name.isEmpty?const Text('Name'):Text(user_id ==null?'User Not Found':controller.userData.first.name,style: const TextStyle(color: AppColors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                          const SizedBox(height:5,),
                          controller.userData.first.mobile.isEmpty?const SizedBox.shrink() :Text(user_id ==null?'':controller.userData.first.mobile,style: const TextStyle(color: AppColors.black),),
                          const SizedBox(height:5,),
                          controller.userData.first.email.isEmpty?const Text('Name'):InkWell(
                              onTap: () {
                                if(user_id ==null){
                                  Get.toNamed(loginScreen);
                                }
                              },
                              child: Text(user_id==null? 'Login Now':controller.userData.first.email,style: const TextStyle(color: AppColors.black),)),

                        ],
                      ),
                      const SizedBox(height:20,),
                    ],
                  ),
                ),

               const SizedBox(height:20,),
                // Order history section
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.shopping_cart,color: AppColors.black,),
                    title: const Text('My Order',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.black),
                    onTap: () {
                      Get.toNamed(myOrderScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.place_outlined,color: AppColors.black,),
                    title: const Text('Manage Address',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.black),
                    onTap: () {
                      Get.toNamed(manageAddressScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.wallet,color: AppColors.black,),
                    title: const Text('My Wallet',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.black),
                    onTap: () {
                      Get.toNamed(walletScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.transfer_within_a_station,color: AppColors.black,),
                    title: const Text('My Transaction',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.black),
                    onTap: () {
                      Get.toNamed(transactionScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.password_outlined,color: AppColors.black,),
                    title: const Text('Change Password',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.black),
                    onTap: () {
                      Get.toNamed(forgetScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.contact_support_outlined,color: AppColors.black,),
                    title: const Text('Customer Support',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.black),
                    onTap: () {
                      Get.toNamed(customerSupportScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.account_box_outlined,color: AppColors.black,),
                    title: const Text('About Us',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.black),
                    onTap: () {
                      Get.toNamed(aboutUsScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.contact_mail_outlined,color: AppColors.black,),
                    title: const Text('Contact Us',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.black),
                    onTap: () {
                      Get.toNamed(contactUsScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  color: AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined,color: AppColors.black,),
                    title: const Text('Privacy Policy',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.black),
                    onTap: () {
                      Get.toNamed(privacyScreen);
                      // Navigate to the order history page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                // Settings section
                Container(
                  color:AppColors.whit,
                  child: ListTile(
                    leading: const Icon(Icons.logout_outlined,color: AppColors.black),
                    title: const Text('Logout',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios,size: 20,color: AppColors.black),

                    onTap: () {
                      controller.onTapBackforAsk(context);
                      // Navigate to the settings page
                      // You can implement this navigation based on your app's structure
                    },
                  ),
                ),
              ]
            ),
          ),
        ),
      );
    },);
  }
}
