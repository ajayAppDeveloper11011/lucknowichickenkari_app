import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/product_details_controller.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProductController(),
      builder: (controller) {
      return SafeArea(
        child: Material(
          child: Scaffold(
            body: Container(
              color: Colors.grey.shade400,
              height: MediaQuery.of(context).size.height,
              child:controller.productDetailsData==null?
              const Center(child: CircularProgressIndicator(backgroundColor: AppColors.primary,)):
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:15,left:10,right: 25),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle
                                  ),
                                  child: InkWell(
                                    onTap: (){Navigator.pop(context);},
                                    child: const Icon(Icons.navigate_before,color: Colors.white,size:30,),
                                  ),
                                ),
                                Expanded(child: Container(),),

                              ],
                            ),
                          ),
                          controller.productDetailsData?[0].productImage==""?Image.asset('assets/images/formal_image1.jpg',fit: BoxFit.fill,height:350,):Image.network(controller.productDetailsData![0].productImage,fit: BoxFit.fill,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30,left: 20,right: 25,bottom: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Women Wear',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                          const SizedBox(height: 5,),
                                          Container(
                                            width: 160,
                                              child: Text(controller.productDetailsData![0].productTitle,maxLines:2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16),)),
                                          const SizedBox(height: 5,),
                                          Text('Price : Rs.${controller.productDetailsData![0].productPrice}',style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.bold),),
                                          const SizedBox(height: 5,),
                                          controller.productDetailsData?[0].offer==""?const Text('Offer: 5%',style: TextStyle(fontSize: 16,color: Colors.orange,fontWeight: FontWeight.bold),):
                                          Text('Offer: ${controller.productDetailsData?[0].offer}',style: const TextStyle(fontSize: 16,color: Colors.orange,fontWeight: FontWeight.bold),),
                                          const SizedBox(height: 5,),
                                          controller.calculationDiscount(),
                                          const SizedBox(height: 5,),
                                         // Review Star
                                          RatingBar.builder(
                                            itemBuilder: (context, index) => const Icon(Icons.star,color: Colors.amber,),
                                            itemCount: 5,
                                            direction: Axis.horizontal,
                                            itemSize: 20,
                                            maxRating: 5,
                                            minRating: 1,
                                            initialRating: 3.5,
                                            ignoreGestures: true,
                                            allowHalfRating: true,
                                            updateOnDrag: true,
                                            onRatingUpdate: (Ratingvalue){
                                              setState(() {
                                                controller.Rate = Ratingvalue  ;
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Column(
                                        children: [
                                          controller.addToCart(),
                                          const SizedBox(height: 5,),
                                          const Text('Available In Stock',style: TextStyle(fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25,),
                                  const Text('Size',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                  // SizedBox(height: 15 ,),
                                  Container(
                                    height: 65,
                                    child: ListView.builder(
                                      // padding: EdgeInsets.all(8),
                                        itemCount: controller.sizes.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context, int index){
                                          String size = controller.sizes[index];

                                          bool isSelectedSize = controller.isSelected[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  controller.isSelected = List.generate(controller.isSelected.length, (i) => i== index);
                                                  print('My Selected Size-------$size');
                                                  controller.onTapSelectedSize(index);

                                                });
                                              },
                                              child: Container(
                                                width:45,
                                                decoration: BoxDecoration(
                                                  color: isSelectedSize ? Colors.black:Colors.white,
                                                  border: Border.all(color: Colors.black),
                                                  shape: BoxShape.circle,

                                                ),
                                                child: Center(
                                                    child: Text(size,
                                                      style: TextStyle(fontWeight: FontWeight.bold,
                                                          color: isSelectedSize?Colors.white:Colors.black
                                                      ),)),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),

                                  // color
                                  const SizedBox(height: 10,),
                                  const Text('Color',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                  // SizedBox(height: 15 ,),
                                  SizedBox(
                                    height: 60,
                                    child: ListView.builder(
                                      // padding: EdgeInsets.all(8),
                                        itemCount: controller.colors.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context, int index){
                                          int color = controller.colors[index];
                                          bool isColor = controller.isSelectedColor[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: (){
                                                  controller.isSelectedColor = List.generate(controller.isSelectedColor.length, (i) => i== index);
                                                  controller.onTapSelectedColor(index);
                                                  print('-----Selected vv Colors----->${color}');
                                                  controller.update();
                                              },
                                              child: Container(
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color(color),
                                                    border: Border.all(color: Colors.grey),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: isColor
                                                      ?const Icon(Icons.check_outlined,color: Colors.redAccent,)
                                                      :null

                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  const Text('Description :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                  const SizedBox(height: 5,),
                                  Text('${controller.productDetailsData?.first.productShortDesc.replaceAll('<br>', '')}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize:13),),

                                ],
                              ),
                            ),

                          ),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 90,
                    child: Row(
                      children: [
                        const SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Total Price',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),
                            const SizedBox(height:5,),
                            controller.calculationTotalPrice()
                          ],
                        ),

                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: (){
                         controller.checkSkipLogin(context);
                          },
                          child: Container(
                            width:160,
                            decoration: BoxDecoration(
                              color: Colors.black,borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                                SizedBox(width:15,height:45,),
                                Text('Add to cart',style: TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 25,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },);
  }
}
