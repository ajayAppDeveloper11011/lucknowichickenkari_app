
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/request_keys.dart';
import '../Utils/colors.dart';
import '../Widgets/show_message.dart';
import '../models/add_to_cart_response.dart';
import '../models/product_data_response.dart';

class ProductController extends AppBaseController{
  String? productId;
  String? slugId;
  int number = 1;
  double Rate = 0;
  String? selectedSize;
  int? selectedColor;
  bool skipLogin = true;
  List<ProductData>? productDetailsData;
  List<AddToCartResponseModel>aadToCartResData=[];

  Future<void> checkSkipLogin(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    skipLogin = prefs.getBool('skipLogin') ?? false;
    if (skipLogin) {
      print('-----Skip Login------$skipLogin');
      ShowMessage.showSnackBar('Server Res','Login First');
      Get.toNamed(loginScreen);
    } else {
      print('-----You are Login------$skipLogin');
      addItem(context);
      // Perform the regular login process
    }
  }






  void onInit(){
    super.onInit();
    storeColorsValue();

    if(Get.arguments != null) {
      productDetailsData  = Get.arguments;
      print('------ProductData-----${productDetailsData?[0].id}');

    }



    getProductId();
    // getProductDetailsData();

  }

  getProductId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    productId = pref.getString('prod_id');

  }



  /// Get Navigation  Function -------------->
  onTapCartScreen(){
    Future.delayed(const Duration(seconds:2),(){

      Get.toNamed(cartScreen,arguments: number);

    });

}

  /// Show Error Massage Function--------------->
  void _showError(context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message)),
    );
  }

  /// Add Product Function--------------->
  void addItem(BuildContext context, {index})async{

    // Check if a size is selected
    if (isSelected.every((element) => element == false)) {
      _showError(context,'Please select a size');
      return ;
    }

    // Check if a color is selected
    if (isSelectedColor.every((element) => element == false)) {
      _showError(context,'Please select a color');
      return;
    }

    addToCartData(index);
    // onTapCartScreen();
  }

  /// Select Function--------------->
  List<bool> isSelected = [
    false,false,false,false,false
  ];

  /// Select Color List--------------->
  List isSelectedColor = [
    false,false,false,false
  ];

  /// Size List--------------->
  List sizes = [
    'S','M','L','XL','XXL'
  ];
  onTapSelectedSize(index){
    selectedSize = sizes[index];
    print('choose size-------${selectedSize}');

  }

  /// colors List--------------->
  List colors = [
    0xFFFFFFFF,0xFF000000,0xFFFFD54F,0xFF64B5F6,

  ];
  storeColorsValue(){
    List<int> colorValues = [0xFFFFFFFF, 0xFF000000, 0xFFFFD54F, 0xFF64B5F6];
    Map<String, int> colors = {
      'white': colorValues[0],
      'black': colorValues[1],
      'yellow': colorValues[2],
      'blue': colorValues[3],
    };

    print(colors);

  }

  onTapSelectedColor(index){
   selectedColor = colors[index];
   print('Selected Color--------$selectedColor');

  }

  /// Add to Cart Logic------------>
   addToCart(){
  return Container(
    decoration:BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: (){
                if(number>=2){
                  number--;
                  update();
                }

            },
            // behavior: ,
            child:const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
              child: Text('-',style: TextStyle(color: Colors.black,fontSize:30,fontWeight: FontWeight.bold),),
            ) ),

        Text(number.toString(),style: const TextStyle(fontSize:18),),
        GestureDetector(
          onTap: (){
              if(number>=1){
                number++;
                update();
                print('Increment---${number}');
              }

          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
            child: Text('+',style: TextStyle(fontSize: 25,color: Colors.black),),
          ),)
      ],
    ),
  );

}


  Future<void> addToCartData(index) async {
    Map<String, String>? header;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    String? tempToken= prefs.getString('temp_token');
    setBusy(true);
    try {
      var headers = header ?? {};
      headers.addAll({
        'Authorization': 'Bearer $tempToken',
        'Cookie':
        'XSRF-TOKEN=eyJpdiI6ImtZOXljTjV5STRhZFo1UCtFVkNtM1E9PSIsInZhbHVlIjoid1ZubmxqNER6cGhTQUdIY2g2OUZaWlM0aW5sQ013VVMzVC9BMzVNREw0Nkx3S2JFbDdFVFpuNXFadENqb2ZTbXg0UXgrSmc2VnF6dzEvMTNiZmZHcGZSVXUxNTl4d01KQ2plSUNJb2lWbTA3TEV5cGg4VTFPQVBqMDBCeVJ4bEoiLCJtYWMiOiI2ODNiNmI1MTMxZTEwMTc1YjdmZGUxYjk2ZjgyYjAyMTIzMjQ2MzUyOTI3YzUxN2ZiYTFkMDMxYzZjOTJiOWFlIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Ik1GMmxGSVA0dTN0NGNtd0FUNWVXQ0E9PSIsInZhbHVlIjoiTHlrTmhBNEpZSStIWktGS2RWYlhXc0ltakVENVF5elBzaHFYQ2thanhhcnl4VnVSYmc0Z0l3MVZTdXF1d3QwaUtyQll2TmJCMTM3WDNPVFd5Rm0yclBzK1pjaHBsVVNodHRoUm9aUEFFRUVaY2pzWGhKRnhmbU1BeE11ZCtjRm8iLCJtYWMiOiI5NDc4OGUwZjkzNWM5NGI5ZjM0M2NiN2FhNzRlMzQxZGEwN2EzMzYzYTk5MzVkNjA5NWNjNzY4MjFmMDEyMjJkIiwidGFnIjoiIn0%3D',
      });
      print('----------bbbb----${headers}');
      Map<String, String> body = {};
      body[RequestKeys.productId] =productId ??'';
      body[RequestKeys.sizeOfProduct] = selectedSize!;
      body[RequestKeys.color] = 'red';
      body[RequestKeys.productQty] = number.toString();
      body[RequestKeys.userId] = userId.toString();

      AddToCartResponseModel res = await api.addToCartApi(body);
      print('parameter---------$body');
      if (res.error==true) {
        print('_____Product Details_____${res.message}_____________');
        ShowMessage.showSnackBar('Server Res', res.message);
        setBusy(false);
        update();
        onTapCartScreen();

      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', 'Api Not Responding');
    } finally {
      setBusy(false);
      update();
    }
  }



  ///Calculation For Discount price------------------>
  calculationDiscount(){
    var productPrice = double.parse(productDetailsData![0].productPrice);
    var discount = (productPrice * 10 / 100);
    var specialPrice = productPrice - discount;
    var specialPriceAsString = specialPrice.toStringAsFixed(2);
    return Text("Special Price: Rs.$specialPriceAsString",style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w700,));

  }

  ///Calculation For Total price------------------>
  calculationTotalPrice(){
    var productPrice = double.parse(productDetailsData![0].productPrice);
    var discount = (productPrice * 10 / 100);
    var specialPrice = productPrice - discount;
    var specialPriceAsString = specialPrice.toStringAsFixed(2);
    return Text("Rs. ${(double.parse(specialPriceAsString)*number)}",style: const TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w500,));

  }
}