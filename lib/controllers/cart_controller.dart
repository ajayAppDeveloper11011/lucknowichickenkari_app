
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Services/api_client.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:lucknowichickenkari_app/models/get_address_response.dart';
import 'package:lucknowichickenkari_app/models/get_cart_data_response.dart';
import 'package:lucknowichickenkari_app/models/payment_status_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import '../models/delete_cart_response.dart';
import '../models/place_order_response.dart';
import '../models/update_cart_response.dart';
import '../session/Session.dart';
import '../view_screen/Cart/cart_view.dart';

class CartController extends AppBaseController {
  String payMethod = '';
  String? order_Id;
  String? paymentId;
  Razorpay? _razorpay;
  // int? increment;
  int number = 1;
  String? payStatus;
  List<int> itemQuantities = [];
  String itemName = 'Product Name';
  double itemPrice = 19.99;
  List<GetCartData> cartData = [];
  List<PlaceOrderModel> placeOrderData = [];
  List<GetAddressData>addressData = [];
   RxDouble totalCartPrice = 0.0.obs;
  bool dataFalse= true;
  bool skipLogin = true;

  var productPrice ;
  var discount;
  var specialPrice;
  var specialPriceAsString;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getAddressData();
    getCartData();

    update();
      _razorpay = Razorpay();
      _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);




  }


  void priceCalculation() {
    if (cartData.isNotEmpty) {
      double initialTotal = 0.0;
      for (int i = 0; i < cartData.length; i++) {
         productPrice = double.parse(cartData[i].productPrice);
         discount = (productPrice * 10 / 100); // 10% discount
         specialPrice = productPrice - discount;
        initialTotal += specialPrice * cartData[i].productQty;
      }

      totalCartPrice.value = initialTotal;
      print('Calculation Of Product Data4444${totalCartPrice.value}');
    }

  }




  /// Check Skip Login ------------->
  Future<void> checkSkipLogin(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    skipLogin = prefs.getBool('skipLogin') ?? false;
    if (skipLogin) {
      print('-----Skip Login------$skipLogin');
      ShowMessage.showSnackBar('Server Res','Login First');
      Get.toNamed(loginScreen);
    } else {
      print('-----You are Login------$skipLogin');
      doPayment();
      // Perform the regular login process
    }
  }





 /// Payment Integration(Razor pay)------------->
  void razorpayPayment() async {
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_Mjaw2nhaXj2vG2',
      'amount': "${totalCartPrice*100}",
      'name': 'Lucknowichikankari',
      'image':'assets/splash/splashimages.png',
      'description': 'Lucknowichikankari',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // bookAppointment();
    // Fluttertoast.showToast(msg: "Booking Done");

    paymentId = response.paymentId; // Retrieve the payment ID
    String? orderId = response.orderId; // Retrieve the order ID
    String? signature = response.signature; // Retrieve the signature
    // You can now use these values to process the successful paymen
    print("Payment ID: $paymentId");
    print("Order ID: $orderId");
    print("Signature: $signature");
   // Call a method to handle the successful payment details
    print("Success");
    payStatus = '1';

    print('----Status-----$payStatus');
    update();
    paymentStatusCheck();
    Future.delayed(const Duration(seconds:0,),(){
      ShowMessage.showSnackBar('Server Res','Place Order Successfully');
      Get.toNamed(orderPlacedScreen);
      getCartData();
    });


  }

  void _handlePaymentError(PaymentFailureResponse response,context) {
    payStatus ='2';
    print('----Status-----$payStatus');
    update();
    paymentStatusCheck();
    setSnackbar("ERROR", context);
    setSnackbar("Payment cancelled by user", context);

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    payStatus ='0';
    print('----Status-----$payStatus');
    update();
    paymentStatusCheck();
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName, toastLength: Toast.LENGTH_SHORT);
  }






  /// Navigation Function for Navigate------------->
  onTapNotification(){

      Get.toNamed(notificationScreen);

  }
  String? address;
  void showCheckoutBottomSheet(BuildContext context, String itemName, double itemPrice) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Container(
                // padding: const EdgeInsets.all(16.0),
                color: AppColors.greyColor,
                child: Padding(
                  padding: const EdgeInsets.only(left:15,right:15,top:1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 2,
                          width: 90,
                          color: AppColors.primary.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(height:10,),
                      const Text(
                        'Checkout Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text('Item: $itemName'),
                      Text('Rs. $totalCartPrice'),
                      const SizedBox(height: 16.0),
                      Container(
                        height:130,
                        width: MediaQuery.of(context).size.width/1,
                        decoration: BoxDecoration(
                            color: AppColors.textFieldClr,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.only(left: 20.0,right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height:10,),

                              const Row(
                                children: [
                                  Icon(Icons.location_on_outlined,color: AppColors.red,),
                                  SizedBox(width: 5,),
                                  Text('Shipping Details',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Divider(height: 1,color: AppColors.black.withOpacity(0.5),thickness:0.5,),
                              const SizedBox(height:5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  dataFalse==false?Text(addressData.first.name,style: const TextStyle(color: AppColors.black,fontWeight: FontWeight.w700)): const Text('Ajay Malviya',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w700),),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(addAddressScreen);
                                    },
                                    child: Container(
                                      width:60,
                                      height:25,
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Center(child: Text(addressData.isEmpty?'Add':'Edit',style: const TextStyle(color: AppColors.whit),)),
                                    ),
                                  )

                                ],
                              ),
                              const SizedBox(height:5,),
                              dataFalse == false
                                  ? const Text('First Add Address')
                                  : addressData.isNotEmpty
                                  ? Text(
                                addressData.first.address.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height:10),
                      InkWell(
                        onTap: () {
                          Get.toNamed(paymentMethodScreen);
                          update();
                        },
                        child: Container(
                          height:40,
                          width: MediaQuery.of(context).size.width/1,
                          decoration: BoxDecoration(
                              color: AppColors.textFieldClr,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 20),
                            child:Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10,),
                                  const Icon(Icons.payment,color: AppColors.red,),
                                  const SizedBox(width:20,),
                                  Text(payMethodName!=null?'$payMethodName':'Select Payment Methode',style: const TextStyle(fontWeight: FontWeight.w600),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:cartData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.textFieldClr,
                                  borderRadius: BorderRadius.circular(15)),

                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        child:cartData[index]
                                            .productImage
                                            .isEmpty
                                            ? Image.asset(
                                          'assets/images/formal_image1.jpg',
                                          fit: BoxFit.fill,
                                        )
                                            : Image.network(
                                          cartData[index]
                                              .productImage,
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width:190,
                                        child: Text(
                                            cartData[index]
                                                .productTitle,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            maxLines:1,
                                            style: const TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 15)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Price : Rs.${cartData[index].productPrice}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.green),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      cartData[index].offer
                                          .isEmpty
                                          ? const Text(
                                        'offer : 5%',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.w700,
                                            color: Colors.green),
                                      )
                                          : Text(
                                        'offer : ${cartData[index].offer}',
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.w700,
                                            color: Colors.green),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      calculationDiscount(index),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text('Quantity : ${cartData[index].productQty}',style: const TextStyle(fontWeight: FontWeight.w700,color:AppColors.black),),
                                      // addToCart(index)
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        height:110,
                        width: MediaQuery.of(context).size.width/1,
                        decoration: BoxDecoration(
                            color: AppColors.textFieldClr,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.only(left: 20.0,right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height:10,),
                              const Text('Order Summery(1 item)',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),
                              const SizedBox(height:10,),
                              Divider(height: 1,color: AppColors.black.withOpacity(0.5),thickness:0.5,),
                              const SizedBox(height:10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Sub Total',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),
                                      SizedBox(height:5,),
                                      Text('Delivery Charge',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),


                                    ],),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Rs. $totalCartPrice',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),
                                      const SizedBox(height:5,),
                                      const Text('Rs.0.00',style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500),),


                                    ],),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                          height:70,
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.textFieldClr,
                          child:Padding(
                            padding: const EdgeInsets.only(left:10.0,right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20,),
                                    Text('Rs. $totalCartPrice',style: const TextStyle(fontWeight: FontWeight.w600,),),
                                    const SizedBox(height: 5,),
                                    Text('${cartData.length} item',style: const TextStyle(fontWeight: FontWeight.w400,color: AppColors.primary),),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () {

                                      if(payMethodName==null || addressData.isEmpty){
                                        ShowMessage.showSnackBar('Server Res','Select Payment methode or  address');
                                      }else{
                                        onTapBackforAsk(context);
                                        // Navigator.of(context).pop(); // Close the bottom sheet
                                      }

                                    },
                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10) )),
                                    child: const Text('Place Order'),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Get Address Data Api Integration---------->
  Future<void> getAddressData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString('user_id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId]= userId.toString();
      GetAddressModelResponse res = await api.getAddressDataApi(body);
      print('----------->${body}');
      if (res.error==true) {
          dataFalse = true;
          update();
          addressData = res.data;
          print('_____Data_____${addressData}_____________');

        //ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        update();

      }else{
        dataFalse = false;
        update();
        print('_Not----${addressData}_____________');

      }

    } catch (e) {

      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }





  List<Map<String,dynamic>> menCategoryData = [
    {
      'categoryImage' : 'assets/images/formal_image1.jpg','name': 'Men wear'
    },


  ];

  addToCart(int index) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            print('IIIIIII');
            if (cartData[index].productQty >= 2) {
              cartData[index].productQty--; // Decrease the quantity for the specific item.
              calculationDiscount(index);
              updateCartData(index);
              update();
            }
          },
          child: Container(
            height: 40,
            width: 40,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Center(
                child: Text(
                  '-',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          "${cartData[index].productQty}", // Display the quantity for the specific item.
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            if (cartData[index].productQty >=1) {
                cartData[index].productQty++; // Increase the quantity for the specific item.
                calculationDiscount(index);
                updateCartData(index);
                update();
            }
          },
          child: Container(
            height: 40,
            width: 40,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Center(
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }


  cartEmpty() {
  return Center(
    child: SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              noCartImage(),
              const SizedBox(height: 20,),
              noCartText(),
        //       AppBtn(
        //   width:210,
        //   height: 45,
        //   title: 'Shop Now',
        //   onPress: () {
        //     Get.toNamed(bottomBar);
        //   },
        // )
      ]),
    ),
  );
}

  noCartImage() {
  return Image.asset(
    'assets/images/emptyCart_image.png',
    fit: BoxFit.fill,
   height:330,
    width:double.maxFinite,
  );
}

  /// Show Empty Cart Image when Data not Show
  noCartText() {
  return Container(
      child: const Text('Your Cart Is Empty',
          style: TextStyle(color:AppColors.red,fontWeight: FontWeight.bold,fontSize: 20)));
}

 /// Get Cart data Api Integration--------------->
  Future<void> getCartData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString('user_id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.uniqueClientId]= ApiClient.uniqueKey;
      body[RequestKeys.userId]= userId.toString();
      GetCartResponseModel res = await api.getCartCartApi(body);
     print('----------->${body}');
      if (res.error==true) {
        cartData = res.data;
        print('_____CartData length_____${cartData.length}_____________');
        print('_____Cart_____${res.message}_____________');
        priceCalculation();
        //ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        update();

      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }



  ///Delete Cart Api Integration------------------>
  Future<void> deleteCartData(index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString('user_id');

    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.productId]= cartData[index].productId.toString();
      body[RequestKeys.userId]= userId.toString();
      DeleteCartResponseModel res = await api.deleteCartApi(body);
      print('_____id_____${body}_____________');
      if (res.error==true) {

        print('_____Product Details_____${res.message}_____________');
        getCartData();
        ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        update();

      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  ///Delete Cart Api Integration------------------>
  // Future<void> updateCartData(index) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? userId = pref.getString('user_id');
  //   setBusy(true);
  //   try {
  //     Map<String, String> body = {};
  //     body[RequestKeys.cartId]= cartData[index].cartId.toString();
  //     body[RequestKeys.productQty]= cartData[index].productQty.toString();
  //     body[RequestKeys.userId]= userId.toString();
  //     CartUpdateModel res = await api.updateCartCartApi(body);
  //     print('my param=---${body}');
  //     print('_____id_____${res.error}_____________');
  //     if (res.error==true) {
  //       print('_____Cart Data_____${res.message}_____________');
  //       getCartData();
  //       ShowMessage.showSnackBar('Server Res', res.message ?? '');
  //       setBusy(false);
  //       update();
  //
  //     }
  //
  //   } catch (e) {
  //     ShowMessage.showSnackBar('Server Res', '$e');
  //   } finally {
  //     setBusy(false);
  //     update();
  //   }
  // }

  Future<void>updateCartData(index)async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString('user_id');
    setBusy(true);

    var headers = {
      'Authorization': 'Bearer 18|9YbuJIMOShqyW1EHHiZPptgq9pu37fCtzHY5QmHK55c819d5',
      'Cookie': 'XSRF-TOKEN=eyJpdiI6InVWRjNZeEV1SHlha0laMUxpOCtEOHc9PSIsInZhbHVlIjoiOElXaU11a3YwT3hxR0pkenFzNXRaNUc3a0lwZEkyeC9zdmhUcDVZYWVIRmhKbnhEby9USDcyZVc1UVRYYW96ODZ2T0ZTM1psYUQ2NDZxZDFMR1JnTFh0UStvZjUwSkljdFFmTjBFR1lTZU1xTDBPQ2xSUVQzZTJxS3ZCb1NDQ0siLCJtYWMiOiIyYmJlOTFkNGNmZTRmZWQyMjU0MTA5Y2EzNDU3NTM1MGJjNjQ1MDE4ZDEzMTA2MDcxZTJkNzI2YzI1NGVjMTZmIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjVCZW5ZdVVtWkhsZENaY2t1cTcyL3c9PSIsInZhbHVlIjoiOVJia2hXbDRlYVJ3OFZrdXN6aFI1NmN4Q3BYZkRMcklrSW0wdXR1UURySm5YalFYTFJxcjdDU3RMY0tGVjJranlWMkxWbCtFUWY5SDMwa0UyYkp0Uk12REROa1pGRWIxcnhlalFmL0NPOUVDaHJXbTNZSkRPUGMwdXYzaFgrRXQiLCJtYWMiOiIyMWQwMjU1YzViODkxNDE3NzAzNTI4MTc3MzA2M2IxMzM1OTRlMTZiNTk5Nzg1ODYwMTRmMjBhMzk4NWIwNjkzIiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiClient.baseAppUrl}Addtocartupdate'));
    request.fields.addAll({
      'cart_id': cartData[index].cartId.toString(),
      'product_qty': cartData[index].productQty.toString(),
      'user_id': userId.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = CartUpdateModel.fromJson(json.decode(Result));
      if(finalResult.error==true){
        print('_____Cart Data_____${finalResult.message}_____________');
        getCartData();
        ShowMessage.showSnackBar('Server Res', finalResult.message);
        setBusy(false);
        update();
      }
    }

    else {
      print(response.reasonPhrase);
    }


  }

  /// Place Order Api Integration ------------------>
  Future<void> placeOrder(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString('user_id');
    setBusy(true);
    String? payVia;
    print('-------------cxxxx------${payMethodName}');
    if (payMethodName =='COD'||payMethodName =='cod') {
      payVia = "cod";
    } else if (payMethodName == 'PayPal'){
      payVia = "PayPal";
    } else if (payMethodName =='Razorpay'){
      payVia = "Razor Pay";
    } else if (payMethodName =='payStack'){
      payVia = "Paystack";
    } else if (payMethodName == 'Stripe'){
      payVia = "Stripe";
    } else if (payMethodName == 'PAYTM'){
      payVia = "Paytm";
    } else if (payMethodName == "Wallet"){
      payVia = "Wallet";
    } else if (payMethodName == 'BANK-TRANSFER'){
      payVia = "bank_transfer";
    }

    try {
      Map<String, String> body = {};
      // body[RequestKeys.uniqueClientId]= ApiClient.uniqueKey;
      body[RequestKeys.userId]=userId.toString();
      body[RequestKeys.addressId]='3';
      body[RequestKeys.paymentMode]= payVia ??'';
      body[RequestKeys.deliveryCharge]='10';
      body[RequestKeys.amount]= totalCartPrice.toString();
      PlaceOrderModel res = await api.placeOrderApi(body);
      print('-----place order------>$body');
      print('-----status------${res.status}');
      if (res.error==true) {
        // placeOrderData = res.data;
        if(res.status=='0'){
          ShowMessage.showSnackBar('Server Res','Order Placed Successfully');
          Get.toNamed(orderPlacedScreen);
          getCartData();
        }else{
          order_Id = res.orderId;
          razorpayPayment();
        }



        setBusy(false);
        update();

      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }


  doPayment() {
    if (payMethodName == 'cod') {
      placeOrder('');
    }
    else if (payMethodName =='Razor Pay'){
      razorpayPayment();
    }else if(payMethodName=='PayPal'){
      razorpayPayment();
    }

    else if (payMethodName == 'STRIPE'){
      razorpayPayment();
      // stripePayment();
    } else if (payMethodName == 'PAYTM_LBL'){
      // paytmPayment();
    } else{
      placeOrder('');
    }

  }


  ///Payment Status Check Api-------------------->
  Future<void> paymentStatusCheck() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      // body[RequestKeys.uniqueClientId]= ApiClient.uniqueKey;
      body[RequestKeys.paymentStatus]= payStatus == '0' ? '0' : (payStatus == '1' ? '1' : (payStatus == '2' ? '2' : '0'));
      body[RequestKeys.paymentId]= paymentId.toString() ;
      body[RequestKeys.orderIdP]=order_Id.toString();
      PaymentStatusModel res = await api.paymentStatusApi(body);
      print('-----status parameter------>$body');
      print('-----status------${res.message}');
      if (res.error==true) {

        setBusy(false);
        update();

      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }


   /// Confirmation For Place Order function------->
  void onTapBackforAsk(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Order"),
          titlePadding: const EdgeInsets.all(20), // Adjust the title padding as needed
          content: SizedBox(
            width: 200, // Adjust the width of the content
            child: Column(
              mainAxisSize: MainAxisSize.min, // Set the size constraint
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sub Total'),
                    Text('$totalCartPrice'),
                  ],
                ),
                const SizedBox(height: 10,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Charge'),
                    Text('0.00'),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Price'),
                    Text('$totalCartPrice'),
                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  color: AppColors.red.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Special Note'
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0), // Adjust the content padding as needed
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColors.primary),
              child: const Text("YES"),
              onPressed: () {
                checkSkipLogin(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColors.primary),
              child: const Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal:26), // Adjust the actions padding as needed
        );
      },
    );
  }




  ///Calculation For Discount price------------------>
     // Variable to store the total price
  calculationDiscount(index){

     productPrice = double.parse(cartData[index].productPrice);
     discount = (productPrice * 10 / 100);
     specialPrice = productPrice - discount;
     specialPriceAsString = specialPrice.toStringAsFixed(2);
    double subTotal = (double.parse(specialPriceAsString) * cartData[index].productQty);

    totalCartPrice.value = subTotal; // Update the total price
    print('total price: ${totalCartPrice.value}');

    for (int i = 1; i < cartData.length; i++) {
      var productPrice = double.parse(cartData[i].productPrice);
      var discount = (productPrice * 10 / 100); // 10% discount
      var specialPrice = productPrice - discount;
      var subTotal = specialPrice * cartData[i].productQty;
      totalCartPrice.value += subTotal; // Update the total price

    }
    // print('total price: $totalCartPrice');
    print('total price: Rs. perfect valuee${totalCartPrice.value.toStringAsFixed(2)}');
    return Text("Special Price : Rs.${(double.parse(specialPriceAsString)*cartData[index].productQty)}",style: const TextStyle(color:Colors.orange, fontSize: 12, fontWeight: FontWeight.w600,));

  }


}
