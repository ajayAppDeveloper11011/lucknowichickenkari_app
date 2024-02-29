import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/api_client.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import '../models/sub_category_model.dart';

class SubCategoryController extends AppBaseController{
  bool subProductCheck = true ;
  String? userId;
  String? catSlug;

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments!=null){
      catSlug = Get.arguments;
      print('---------catSlug-----$catSlug');
    }

    subCategory();

  }

  List<SubCategoryData>sub_CategoryData = [];

  List<Map<String,dynamic>> menCategoryData = [
    {
      'categoryImage' : 'assets/images/formal_image1.jpg','subcategoryName': 'Men wear','subcategoryPrice': 'Rs.400'
    },
    {
      'categoryImage' : 'assets/images/kurta_image6.jpg','subcategoryName': 'Men wear','subcategoryPrice': 'Rs.400'
    },

    {
      'categoryImage' : 'assets/images/kurta_image3.jpg','subcategoryName': 'Men wear','subcategoryPrice': 'Rs.400'
    },
    {
      'categoryImage' : 'assets/images/kurta_image1.jpg','subcategoryName': 'Men wear','subcategoryPrice': 'Rs.400'
    },
    {
      'categoryImage' : 'assets/images/kurta_image7.jpeg','subcategoryName': 'Men wear','subcategoryPrice': 'Rs.400'
    },
    {
      'categoryImage' : 'assets/images/formal_image1.jpg','subcategoryName': 'Men wear','subcategoryPrice': 'Rs.400'
    },

  ];


  /// Get Sub Category Data Api Integration--------------->
  Future<void> subCategory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('user_id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.uniqueClientId]= ApiClient.uniqueKey;
      body[RequestKeys.userId]= userId.toString();
      body[RequestKeys.slug]= catSlug.toString();
      SubCategoryModel res = await api.subCategoryDataApi(body);
      print('----------->${body}');
      if (res.error==true) {
        sub_CategoryData = res.data;
        print('_____Data_____${sub_CategoryData.length}_____________');
        print('_____Sub Category_____${res.message}_____________');
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

}