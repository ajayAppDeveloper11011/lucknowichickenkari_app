import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';

import '../../Utils/colors.dart';
import '../../view_screen/edit_profile/edit_profile_view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var isLoading = false.obs;



  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }



  bool _isVisible = false;
  bool _hasData = true;

  setProgress(bool show) {
    if (mounted) {
      setState(() {
        _isVisible = show;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Column(
          children: [
            SizedBox(
              height:160,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsetsDirectional.only(end: 20),
                          height:100,
                          width:90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1.0, color:Colors.white)),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child:CachedNetworkImage(
                                  imageUrl:
                                  'assets/images/profile_new.png',
                                  fit: BoxFit.fill,
                                  height: 100,
                                  width: 100,
                                  placeholder: (context, url) =>
                                      LinearProgressIndicator(
                                        color: Colors.white.withOpacity(0.2),
                                        backgroundColor: Colors.white.withOpacity(.5),
                                      ),
                                  errorWidget: (context, url, error) => Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color:Colors.transparent,
                                    ),
                                    child: Center(
                                        child: Image.asset(
                                          'assets/images/man_image1.jpg',
                                          height: 100,
                                          width: 100,
                                        )),
                                  ),
                                )



                            ),
                          ),
                        ),
                        Positioned(
                          top:55,
                          left: 63,
                          child: Container(
                            height:30,
                            width: 30,
                            decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(40)),
                            child: InkWell(
                                onTap: () {
                                  Get.offAll(const EditProfileScreen());
                                },
                                child:const Icon(Icons.edit_outlined,color:AppColors.primary,)),
                          ),
                        )
                      ],
                    ),

                    SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:15),
                        Text('Ajay Malviya',
                            style: TextStyle(
                                color:Colors.white,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600)),
                        // SizedBox(height: 2,),
                        // Text(user_email==""?'':'${user_email}',
                        //     style: TextStyle(
                        //         color:Colors.white,
                        //         fontFamily: 'Lato',
                        //         fontWeight: FontWeight.w600)),
                        SizedBox(height:3,),
                        Text('9878xxxxxx',
                            style: TextStyle(
                                color:Colors.white,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w600)),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView(
                children: [
                  // drawerList(
                  //   // icon: 'assets/icon/homicon.svg',
                  //   title: 'Home',
                  //   subtitle: 'Offers, Top Deals',
                  //   pressevent: () {},
                  // ),
                  // drawerList(
                  //   // icon: 'assets/icon/drawricon1.svg',
                  //   title: 'Search by Category',
                  //   subtitle: 'Men, Women, Kids, Family',
                  //   pressevent: () {},
                  // ),
                  // drawerList(
                  //   // icon: 'assets/icon/drawricon2.svg',
                  //   title: 'Orders',
                  //   subtitle: 'Recent Orders',
                  //   pressevent: () {},
                  // ),
                  // drawerList(
                  //   // icon: 'assets/icon/drawricon3.svg',
                  //   title: 'Your Wishlist',
                  //   subtitle: 'Your Save Properties',
                  //   pressevent: () {},
                  // ),
                  // drawerList(
                  //   // icon: 'assets/icon/drawricon7.svg',
                  //   title: 'Your Account',
                  //   subtitle: 'Profile, Settings',
                  //   pressevent: () {},
                  // ),
                  // drawerList(
                  //   // icon: 'assets/icon/drawricon5.svg',
                  //   title: 'Notification',
                  //   subtitle: 'Offers, New Properties',
                  //   pressevent: () {},
                  // ),
                  drawerList(
                    image:'assets/images/tasks.png',
                    title: 'My Order',
                    subtitle: 'Pro',
                    pressevent: () {
                      Get.toNamed(myOrderScreen);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height:10,
                        child: Divider(
                          thickness:1,
                          color:Colors.grey.withOpacity(0.5),
                        )),
                  ),
                  drawerList(
                    image: 'assets/images/language.png',
                    title: 'Manage Address',
                    subtitle: 'Address',
                    pressevent: () {
                      Get.toNamed(manageAddressScreen);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height:10,
                        child: Divider(
                          thickness:1,
                          color:Colors.grey.withOpacity(0.5),
                        )),
                  ),
                  drawerList(
                    image: 'assets/images/aboutus.png',
                    title: 'About Us',
                    subtitle: 'Lucknowichikankari',
                    pressevent: () {
                      Get.toNamed(aboutUsScreen);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height:10,
                        child: Divider(
                          thickness:1,
                          color:Colors.grey.withOpacity(0.5),
                        )),
                  ),
                  drawerList(
                    image: 'assets/images/support.png',
                    title: 'Help Center',
                    subtitle: 'Lucknowichikankari',
                    pressevent: () {

                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height:10,
                        child: Divider(
                          thickness:1,
                          color:Colors.grey.withOpacity(0.5),
                        )),
                  ),

                  drawerList(
                    image: 'assets/images/sharing.png',
                    title: 'Share App',
                    subtitle: 'Lucknowichikankari',
                    pressevent: () {
                      // Share.share('https://play.google.com/store/apps/details?id=com.mojang.minecraftpe&hl=en&gl=US');

                    },
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //       height:10,
                  //       child: Divider(
                  //         thickness:1,
                  //         color:Colors.grey.withOpacity(0.5),
                  //       )),
                  // ),

                  // drawerList(
                  //   image: 'assets/logo/logout.png',
                  //   title: 'Log Out',
                  //   subtitle: '',
                  //   pressevent: () {
                  //     // logoutApi();
                  //   },
                  // ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class drawerList extends StatelessWidget {
  const drawerList({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.pressevent,
  }) : super(key: key);

  final String image;
  final String title;
  final String subtitle;
  final VoidCallback pressevent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: GestureDetector(
        onTap: pressevent,
        child: ListTile(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          minLeadingWidth: 0,
          leading: Container(
            height: double.infinity,
            child:Image.asset(
              image,
              width:30,
              color:AppColors.lightColor,
            ),
          ),
          title: Text(title,
              style: GoogleFonts.lato(
                  fontSize: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500)),
          subtitle: Text(subtitle,
              style: GoogleFonts.lato(
                  fontSize: 12,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}