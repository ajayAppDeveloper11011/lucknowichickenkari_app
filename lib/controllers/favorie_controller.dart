import 'package:flutter/material.dart';
import 'package:lucknowichickenkari_app/Services/api_client.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:lucknowichickenkari_app/models/get_favorite_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import '../models/remove_favorite_model.dart';

class FavoriteController extends AppBaseController{

String? productIndexId;
String? userId;
int? index;
  @override
  void onInit(){
    super.onInit();
    getProductIndexId();
    getFavoriteData();
    // favoriteCheck(index);
  }


  // Future<void> favoriteCheck(index)async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('isFavorite',favoriteData[index].isfavorites.toString());
  //   print('--------isFavorite------${favoriteData[index].isfavorites.toString()}');
  // }

 Future<void> getProductIndexId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    productIndexId = pref.getString('productId');
    userId = pref.getString('user_id');
    print('------------asasasasas${productIndexId}');
    print('------------asasasasas${userId}');

 }

 List<FavoriteData> favoriteData = [];

  Future<void> getFavoriteData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('user_id');

    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId]=userId.toString();
      body[RequestKeys.uniqueClientId]=ApiClient.uniqueKey;
      print('-------------user id-----$userId');
      GetFavoriteResponseModel res = await api.getFavoriteApi(body);

      if (res.error==true) {
        favoriteData = res.data;
        update();
        print('_____GetFavorite_____${favoriteData.first.isfavorites}_____________');
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


  /// Remove Favorite Api Function------------------>
  Future<void> removeFavorite(index) async {

    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.productId] = favoriteData[index].productId.toString();
      body[RequestKeys.uniqueClientId]=ApiClient.uniqueKey;
      body[RequestKeys.userId] =userId ?? '';
      print('-------fuuuuuuuuuu$body');
      RemoveFavoriteModel res = await api.removeFavoriteApi(body);

      if (res.error==true) {
        ShowMessage.showSnackBar('Server Res', res.message);
        getFavoriteData();
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


  ///Calculation For Discount price------------------>
  calculationDiscount(index){
    var productPrice = double.parse(favoriteData[index].productPrice);
    var discount = (productPrice * 10 / 100);
    var specialPrice = productPrice - discount;
    var specialPriceAsString = specialPrice.toStringAsFixed(2);
    return Text("Special Price : Rs.$specialPriceAsString",style: const TextStyle(color:Colors.orange, fontSize: 12, fontWeight: FontWeight.w600,));

  }

}