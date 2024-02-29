import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/favorie_controller.dart';
import '../../Utils/colors.dart';
import '../../Widgets/star_rating.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FavoriteController(),
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
            title: const Text('Favorite',style: TextStyle(color: AppColors.white),),
          ),
          body: controller.favoriteData.isEmpty
              ? const Center(
                  child: Text(
                    'Data Not Found',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      controller.isBusy
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.secondary,
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.favoriteData.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // controller.onTapCard(index);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05),
                                        child: Container(
                                          height: 170,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: controller
                                                            .favoriteData[index]
                                                            .productImage
                                                            .isEmpty
                                                        ? Image.asset(
                                                            'assets/images/formal_image1.jpg',
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.network(
                                                            controller
                                                                .favoriteData[
                                                                    index]
                                                                .productImage,
                                                            fit: BoxFit.fill,
                                                          ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        child: Text(
                                                          controller
                                                              .favoriteData[
                                                                  index]
                                                              .productTitle,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Price : Rs.${controller.favoriteData[index].productPrice}',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      // controller.favoriteData[index].offer.isEmpty
                                                      //     ? const Text(
                                                      //         'offer : 5%',
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight
                                                      //                     .w700,
                                                      //             color: Colors
                                                      //                 .green),
                                                      //       )
                                                      //     :
                                                      const Text(
                                                              'Offer : 10%',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      controller
                                                          .calculationDiscount(
                                                              index),
                                                      const SizedBox(height: 5),
                                                      const StarDisplay(
                                                          value: 3),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:10.0,),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () {
                                            controller.removeFavorite(index);
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20)),
                                              child: const Icon(Icons.clear,
                                                  color: AppColors.primary,
                                                  size: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
