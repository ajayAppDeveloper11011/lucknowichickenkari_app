import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lucknowichickenkari_app/responsive_layout/responsive.dart';
import '../../Route_managements/routes.dart';
import '../../Utils/colors.dart';
import '../../Widgets/custom_drawer/drawer.dart';
import '../../Widgets/show_message.dart';
import '../../Widgets/star_rating.dart';
import '../../controllers/home_controller.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          key: scaffoldKey,
          appBar:ResponsiveLayout.isWebScreen(context)? AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppColors.primary,
            leading: const Text('Home', style: TextStyle(color:Colors.white,fontSize:18)),
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
              : AppBar(
            centerTitle: true,
              toolbarHeight: 80,
              backgroundColor: AppColors.primary,
               leading: InkWell(
                onTap: () {
                  if (user_id==null) {
                    print('-----Skip Login------$user_id');

                    ShowMessage.showSnackBar('Server Res','Login First');
                    Get.toNamed(loginScreen);
                  } else {
                    print('-----You are Login------$user_id');
                    scaffoldKey.currentState!.openDrawer();
                    // Perform the regular login process
                  }

                },
                child: const Icon(Icons.dehaze_outlined,color: AppColors.white,)),
               title:  Image.asset(
                 'assets/images/splash-removebg-preview.png',
                 fit: BoxFit.fill,
                 height:Get.height/5,
                 width:Get.width/5,
               ),
               actions: [

              // const SizedBox(width: 10,),
              // Container(
              //   height:35,
              //   width: Get.width / 2,
              //   decoration: BoxDecoration(
              //     color: AppColors.white,
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(color: Colors.grey),
              //   ),
              //   child: Center(
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: TextFormField(
              //         decoration: const InputDecoration(
              //           prefixIcon: Icon(
              //             Icons.search,
              //             color: Colors.black,
              //           ),
              //           prefixIconConstraints: BoxConstraints(
              //             minWidth: 40, // Adjust as needed
              //             minHeight: 24, // Adjust as needed
              //           ),
              //           hintText: "Search...",
              //           hintStyle: TextStyle(
              //             fontWeight: FontWeight.w600,
              //             fontSize: 14,
              //           ),
              //           focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              //           enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(width:10),
              InkWell(
                onTap: () {
                  Get.toNamed(favoriteScreen);
                },
                child: const Icon(Icons.favorite_border,color: AppColors.white,),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  controller.onTapNotification();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.notifications,color: AppColors.white,),
                ),
              ),
            ],
          ),
          drawer: const Drawer(
            child: CustomDrawer(),
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
                              const SizedBox(width: 20,),
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
                          height: ResponsiveLayout.isWebScreen(context)? constraints.maxWidth * 0.30:ResponsiveLayout.isTabletScreen(context)?constraints.maxWidth * 0.30:constraints.maxWidth * 0.38,
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.white,
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
                                        height:100,
                                        width:100,
                                        child: Card(
                                          elevation:10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50)
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child:controller.categoryListData[index].catImage==""?Image.asset('assets/images/lucknowi_chickankari.jpg',fit: BoxFit.fill,): Image.network(controller
                                                .categoryListData[index]
                                                .catImage,fit: BoxFit.fill,),
                                          ),
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
                        height:180.0,
                      ),
                      items: controller.bannerListData.map((img) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.network(
                                  img.bannerImage,
                                  fit: BoxFit.fill,
                                ));
                          },
                        );
                      }).toList(),
                    ),
                    // Your existing code
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.07,
                          vertical:7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Products',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          InkWell(
                            onTap: () {
                              controller.showAllProducts = true;
                              controller.update();
                            },
                            child: const Text(
                              'All',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
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
                             itemCount:controller.showAllProducts==true? controller.productListData.length:6,
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
                    controller.showAllProducts==false && controller.productListData.isNotEmpty?Padding(
                      padding: const EdgeInsets.only(right:20,top: 5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 45,
                          width:120,
                          child: ElevatedButton(onPressed: () {

                            controller.showAllProducts = true;
                            controller.update();

                          },style: const ButtonStyle(),
                              child:const Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                  Text('View More',style: TextStyle(fontSize: 11,color: AppColors.black),),
                                  Icon(Icons.arrow_forward,size:17,)
                            ],
                          )),
                        ),
                      ),
                    ):const SizedBox.shrink(),
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
