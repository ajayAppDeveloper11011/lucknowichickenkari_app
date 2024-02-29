import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/controllers/cart_controller.dart';
import '../../Utils/colors.dart';

 String? payMethodName;
class CartScreen extends StatefulWidget {
  String? nameOfPayment;
  CartScreen({Key? key, this.nameOfPayment}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    super.initState();
    payMethodName = widget.nameOfPayment;
  }

  var item;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CartController(),
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
            title: const Text('Cart',style: TextStyle(color:AppColors.white),),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: InkWell(
                    onTap: () {
                      controller.onTapNotification();
                    },
                    child: const Icon(Icons.notifications,color: AppColors.white,)),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                if (controller.cartData.isEmpty)...{
                  controller.cartEmpty(),
                } else ...{
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:controller.cartData.isEmpty ? 0 : controller.cartData.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              // controller.onTapCard(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 17.0, right: 17),
                              child: Container(
                                height: 157,
                                width: MediaQuery.of(context).size.width / 1,
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: controller.cartData[index]
                                              .productImage.isEmpty
                                              ? Image.asset(
                                            'assets/images/formal_image1.jpg',
                                            fit: BoxFit.fill,
                                          )
                                              : Image.network(
                                            controller.cartData[index]
                                                .productImage,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              controller.cartData[index]
                                                  .productTitle,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Price : Rs.${controller.cartData[index].productPrice}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.green),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            // controller.cartData[index].offer.isEmpty
                                            //     ?
                                            const Text(
                                              'offer : 5%',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w700,
                                                  color: Colors.green),
                                            ),

                                            //     : Text(
                                            //   'offer : ${controller.cartData[index].offer}',
                                            //   style: const TextStyle(
                                            //       fontWeight:
                                            //       FontWeight.w700,
                                            //       color: Colors.green),
                                            // ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            controller.calculationDiscount(index),
                                            // Text('Special Price : Rs.  ${(200)*controller.number}',style: const TextStyle(fontWeight: FontWeight.w700,color:Colors.orange),),
                                            controller.addToCart(index),

                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                controller.deleteCartData(index);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Icon(Icons.delete_forever_rounded,
                                      color: AppColors.primary),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                },
                const SizedBox(height: 250),
                if (controller.cartData.isNotEmpty) ...{
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1,
                    color: AppColors.whit,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Price -',
                            style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Rs. ${controller.totalCartPrice.value.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: ElevatedButton(
                        onPressed: () {
                          // Call the function to show the bottom sheet
                          controller.showCheckoutBottomSheet(
                              context, controller.itemName, controller.itemPrice);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text('Checkout',
                            style: TextStyle(color: AppColors.whit))),
                  ),
                  const SizedBox(height: 20),
                },
              ],
            ),
          ),
        );
      },
    );
  }
}

