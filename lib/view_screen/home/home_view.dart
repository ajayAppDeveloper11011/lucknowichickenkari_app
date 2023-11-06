import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lucknowichickenkari_app/responsive_layout/responsive.dart';
import 'package:lucknowichickenkari_app/session/Session.dart';
import '../../Route_managements/routes.dart';
import '../../Utils/colors.dart';
import '../../Widgets/star_rating.dart';
import '../../controllers/home_controller.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: HomeController(),
//       builder: (controller) {
//         return Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             backgroundColor: AppColors.primary,
//             title: const Text('Home'),
//             actions: [
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(favoriteScreen);
//                 },
//                 child: const Icon(Icons.favorite_border),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 10),
//                 child: InkWell(
//                   onTap: () {
//                     controller.onTapNotification();
//                   },
//                   child: const Icon(Icons.notifications),
//                 ),
//               ),
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     controller.getCurrentLoc();
//                   },
//                   child: Container(
//                     color: AppColors.whit,
//                     height: 40,
//                     width: MediaQuery.of(context).size.width,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 10.0, right: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const Icon(Icons.location_on_outlined),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Text(
//                             controller.currentAddress.text == ""
//                                 ? "Get Current Location"
//                                 : controller.currentAddress.text,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w600, fontSize: 15),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 controller.categoryListData.isEmpty
//                     ? const Center(child: CircularProgressIndicator(backgroundColor: AppColors.primary))
//                     : Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal:
//                       MediaQuery.of(context).size.width * 0.05,
//                       vertical: 10),
//                   child: Container(
//                     height: 115,
//                     width: MediaQuery.of(context).size.width,
//                     color: AppColors.whit,
//                     child: ListView.builder(
//                       itemCount: controller.categoryListData.length,
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         print(
//                             '-------yyyyyyy${controller.categoryListData[index].catImage}');
//                         return InkWell(
//                           onTap: () {
//                             controller.onTapCategoryScreen(index);
//                           },
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CircleAvatar(
//                                   radius: 40,
//                                   backgroundImage: AssetImage(
//                                     controller.categoryListData[index]
//                                         .catImage ==
//                                         ""
//                                         ? "assets/images/lucknowi_chickankari.jpg"
//                                         : controller
//                                         .categoryListData[index]
//                                         .catImage,
//                                   ),
//                                 ),
//                               ),
//                               Text(controller
//                                   .categoryListData[index].catTitle),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     enlargeCenterPage: true,
//                     autoPlay: true,
//                     aspectRatio: 16 / 9,
//                     autoPlayCurve: Curves.fastOutSlowIn,
//                     enableInfiniteScroll: true,
//                     autoPlayAnimationDuration:
//                     const Duration(milliseconds: 500),
//                     viewportFraction: 0.8,
//                     onPageChanged: (index, reason) {
//                       controller.currentIndex = index;
//                     },
//                     height: 200.0,
//                   ),
//                   items: controller.sliderData.map((img) {
//                     return Builder(
//                       builder: (BuildContext context) {
//                         return Container(
//                             width: MediaQuery.of(context).size.width,
//                             margin:
//                             const EdgeInsets.symmetric(horizontal: 5.0),
//                             child: Image.asset(
//                               img['sliderImage'],
//                               fit: BoxFit.fill,
//                             ));
//                       },
//                     );
//                   }).toList(),
//                 ),
//                 const SizedBox(height: 5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 4,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: AppColors.greyColor,
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                     ),
//                     const SizedBox(width: 1),
//                     Container(
//                       height: 4,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: AppColors.greyColor,
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                     ),
//                     const SizedBox(width: 1),
//                     Container(
//                       height: 4,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: AppColors.greyColor,
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                     ),
//                     const SizedBox(width: 1),
//                     Container(
//                       height: 4,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: AppColors.greyColor,
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal:
//                       MediaQuery.of(context).size.width * 0.05,
//                       vertical: 10),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Products',
//                         style: TextStyle(
//                             color: AppColors.primary,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20),
//                       ),
//                       Text(
//                         'All',
//                         style: TextStyle(
//                             color: AppColors.primary,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height:10),
//                 controller.productListData.isEmpty
//                     ? const Center(
//                     child: CircularProgressIndicator(
//                         backgroundColor: AppColors.primary))
//                     : Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal:
//                       MediaQuery.of(context).size.width * 0.05),
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: controller.productListData.length,
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 3,
//                       childAspectRatio: 0.57,
//                       mainAxisSpacing: 5,
//                     ),
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//                           print(
//                               "uuuuuuuuuu${controller.productListData[index].id}");
//                           controller.prodId =
//                               controller.productListData[index]
//                                   .id
//                                   .toString();
//                           controller.onTapProduct(index);
//                           String slugId =
//                               controller.productListData[index]
//                                   .slug;
//                           controller
//                               .onTapProductScreen(slugId);
//                         },
//                         child: Card(
//                           elevation: 1,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15)),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const SizedBox(
//                                 height:3,
//                               ),
//                               Stack(
//                                 children: [
//                                   Container(
//                                     height: 150,
//                                     width: 150,
//                                     child: ClipRRect(
//                                         borderRadius:
//                                         BorderRadius.circular(10),
//                                         child: controller
//                                             .productListData[
//                                         index]
//                                             .productImage ==
//                                             ""
//                                             ? Image.asset(
//                                             'assets/images/formal_image1.jpg',
//                                             fit: BoxFit.fill)
//                                             : Image.network(
//                                             controller
//                                                 .productListData[
//                                             index]
//                                                 .productImage,
//                                             fit: BoxFit.fill)),
//                                   ),
//                                   Positioned(
//                                     top: 0,
//                                     left: 120,
//                                     child: InkWell(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Icon(
//                                           controller.productListData[index]
//                                               .isFavorite
//                                               ? Icons.favorite
//                                               : Icons.favorite_border,
//                                           color: controller
//                                               .productListData[index]
//                                               .isFavorite
//                                               ? AppColors.red
//                                               : AppColors.primary,
//                                           size: 20,
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         controller
//                                             .onTapGetFavoriteStatus(index);
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 5),
//                               Padding(
//                                 padding: const EdgeInsets.only(right:8,left:8,top:5),
//                                 child: Container(
//                                   width: 160,
//                                   child: Text(
//                                     controller.productListData[index]
//                                         .productTitle,
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                     style: const TextStyle(
//                                         color: AppColors.primary,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 13),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 10.0, right: 10),
//                                 child: Row(
//                                   children: [
//                                     const Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       children: [
//
//                                         Text('Price: ',
//                                             style: TextStyle(
//                                                 color: AppColors.primary,
//                                                 fontWeight: FontWeight.w600)),
//                                         SizedBox(height: 5),
//                                         Text('Offer : ',
//                                             style: TextStyle(
//                                                 color: AppColors.primary,
//                                                 fontWeight: FontWeight.w600)),
//                                         SizedBox(height: 5),
//                                         Text(
//                                           'Special Price:',
//                                           style: TextStyle(
//                                               color: AppColors.primary,
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 12),
//                                         ),
//                                         SizedBox(height: 5),
//                                         StarDisplay(value: 3),
//
//                                       ],
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           controller.productListData[index]
//                                               .productPrice,
//                                           style: const TextStyle(
//                                             color: AppColors.green,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w400,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         Text(
//                                           controller.productListData[index]
//                                               .offer ==
//                                               ""
//                                               ? "10%"
//                                               : controller
//                                               .productListData[index]
//                                               .offer,
//                                           style: const TextStyle(
//                                               color: AppColors.primary,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         controller.calculationDiscount(index),
//                                       ],
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar:ResponsiveLayout.isWebScreen(context)? AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppColors.primary2,
            leading: const Text('Home', style: TextStyle(color: AppColors.black,fontSize:18)),
            title:Container(
                height:150,
                width:150,
                // color: AppColors.textFieldClr,
                child: Image.asset('assets/images/splash-removebg-preview.png',fit: BoxFit.fill)),
            actions: [
              InkWell(
                onTap: () {
                  Get.toNamed(categoryScreen);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10,top: 20,right: 10),
                  child: Text('Category', style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold,fontSize:18)),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(cartScreen);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10,top: 20,right: 10),
                  child: Text('Cart', style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold,fontSize:18)),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(profileScreen);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10,top: 20,right: 10),
                  child: Text('Profile', style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold,fontSize:18)),
                ),
              ),

              InkWell(
                onTap: () {
                  Get.toNamed(favoriteScreen);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10,top: 20,right: 10),
                  child: Text('Favorite', style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold,fontSize:18)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right:10),
                child: InkWell(
                  onTap: () {
                    controller.onTapNotification();
                  },
                  child: const Icon(Icons.notifications,color: AppColors.black),
                ),
              ),
            ],
          )
              :AppBar(
                  centerTitle: true,
                  backgroundColor:AppColors.primary,
                  title: const Text('Home'),
                 actions: [
                  InkWell(
                     onTap: () {
                     Get.toNamed(favoriteScreen);
                     },
                        child: const Icon(Icons.favorite_border),
                   ),
                const SizedBox(
                width: 10,
                ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: InkWell(
                  onTap: () {
                    controller.onTapNotification();
                  },
                  child: const Icon(Icons.notifications),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  children: [
                   ResponsiveLayout.isWebScreen(context)?const SizedBox.shrink(): InkWell(
                      onTap: () {
                        controller.getCurrentLoc();
                      },
                      child: Container(
                        color: AppColors.whit,
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on_outlined),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                controller.currentAddress.text == ""
                                    ? "Get Current Location"
                                    : controller.currentAddress.text,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    controller.categoryListData.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                                backgroundColor: AppColors.primary))
                        : Container(
                          height: ResponsiveLayout.isWebScreen(context)? constraints.maxWidth * 0.30:constraints.maxWidth * 0.33,
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.whit,
                          child: ListView.builder(
                            itemCount: controller.categoryListData.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  controller.onTapCategoryScreen(index);
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        height:80,
                                        width:80,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child:controller.categoryListData[index].catImage==""?Image.asset('assets/images/lucknowi_chickankari.jpg',fit: BoxFit.fill,): Image.network(controller
                                              .categoryListData[index]
                                              .catImage,fit: BoxFit.fill,),
                                        ),
                                      ),
                                    ),
                                    Text(controller
                                        .categoryListData[index].catTitle,style: TextStyle(fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                    const SizedBox(
                      height: 10,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 500),
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          controller.currentIndex = index;
                        },
                        height: 200.0,
                      ),
                      items: controller.sliderData.map((img) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.asset(
                                  img['sliderImage'],
                                  fit: BoxFit.fill,
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    // Your existing code

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.07,
                          vertical:7),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Products',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            'All',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    controller.productListData.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                                backgroundColor: AppColors.primary))
                        : Padding(
                           padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
                          child: GridView.builder(
                             shrinkWrap: true,
                             physics: const NeverScrollableScrollPhysics(),
                             itemCount: controller.productListData.length,
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: constraints.maxWidth > 1200
                              ? 4
                              : constraints.maxWidth > 600
                              ? 2
                              : 2,
                           crossAxisSpacing: 3,
                           childAspectRatio: (constraints.maxWidth *
                              (constraints.maxWidth > 1200 ? 0.2 : 0.4)) /
                              (constraints.maxWidth *
                                  (constraints.maxWidth > 1200 ||constraints.maxWidth >600? 0.369 : 0.69)),
                              mainAxisSpacing: 5,
                        ),
                             itemBuilder: (context, index) {
                           return InkWell(
                            onTap: () {
                              print("uuuuuuuuuu${controller.productListData[index].id}");
                              controller.prodId =
                                  controller.productListData[index].id.toString();
                              controller.onTapProduct(index);
                              String slugId = controller.productListData[index].slug;
                              controller.onTapProductScreen(slugId,index);
                            },
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 3),
                                  Stack(
                                    children: [
                                      Container(
                                        height: constraints.maxWidth *
                                            (constraints.maxWidth > 1200 ? 0.3 : 0.4),
                                        width: constraints.maxWidth *
                                            (constraints.maxWidth > 1200 ? 0.6 : 0.4),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: controller.productListData[index]
                                              .productImage ==
                                              ""
                                              ? Image.asset(
                                            'assets/images/formal_image1.jpg',
                                            fit: BoxFit.fill,
                                          )
                                              : Image.network(
                                              controller.productListData[index]
                                                .productImage,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left:constraints.maxWidth > 1200 ? 260:115,
                                        child: InkWell(
                                          child: Padding(
                                            padding: EdgeInsets.all(constraints.maxWidth * 0.015),
                                            child: Icon(
                                              controller.productListData[index].isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: controller.productListData[index].isFavorite
                                                  ? AppColors.red
                                                  : AppColors.primary,
                                              size:constraints.maxWidth >1200 ? constraints.maxWidth * 0.018:20,
                                            ),
                                          ),
                                          onTap: () {
                                            controller.onTapGetFavoriteStatus(index);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    child: Container(
                                      width: constraints.maxWidth *
                                          (constraints.maxWidth > 1200 ? 0.7 : 0.4),
                                      child: Text(
                                        controller.productListData[index].productTitle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize:constraints.maxWidth > 1200 ?constraints.maxWidth*0.018 :13,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height:3),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 7.0, right:0),
                                    child: Row(
                                      children: [
                                         Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(height:7),
                                            Text('Price: ',
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.w600,fontSize: constraints.maxWidth > 1200 ?constraints.maxWidth*0.011 :12,
                                                )),
                                            const SizedBox(height: 5),
                                            Text('Offer : ',
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.w600,fontSize: constraints.maxWidth > 1200 ?constraints.maxWidth*0.011 :12,
                                                )),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Special Price:',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: constraints.maxWidth > 1200 ?constraints.maxWidth*0.011 :12,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            const StarDisplay(value: 3),

                                          ],
                                        ),
                                        // const SizedBox(width:2,),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.productListData[index]
                                                  .productPrice,
                                              style:TextStyle(
                                                color: AppColors.green,
                                                fontSize:constraints.maxWidth > 1200 ?constraints.maxWidth*0.011 :12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              controller.productListData[index]
                                                  .offer ==
                                                  ""
                                                  ? "10%"
                                                  : controller
                                                  .productListData[index]
                                                  .offer,
                                              style:TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize:constraints.maxWidth > 1200 ?constraints.maxWidth*0.011 :12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(height: 5),
                                            controller.calculationDiscount(context,index),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
