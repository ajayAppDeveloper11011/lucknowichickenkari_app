import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lucknowichickenkari_app/controllers/appbased_controller/appbase_controller.dart';
import '../Services/api_client.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import '../models/category_data_response.dart';

class CategoryController extends AppBaseController{


  List <CategoryData> categoryListData = [] ;
  int? Index;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHomeCategoryData2();
    if(Get.arguments!=null){
      Index= Get.arguments;
      print('---------index-----${Index}');
    }

  }




  /// Get Category Api Function--------------->
  Future<void> getHomeCategoryData2() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.uniqueClientId] = ApiClient.uniqueKey;

      GetCategoryModel res = await api.homeCategoryDataApi(body);
      print('_____cateData_____${res.message}_____________');

      if (res.error==true) {

        categoryListData = res.data;
        print('__________${res.message}_____________');
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



  int? curIndex = 0;

  List<Map<String,dynamic>> menCategoryData = [
    {
      'categoryImage' : 'assets/images/formal_image1.jpg','name': 'Men wear'
    },
    {
      'categoryImage' : 'assets/images/kurta_image6.jpg','name': 'Men wear'
    },

    {
      'categoryImage' : 'assets/images/kurta_image3.jpg','name': 'Men wear'
    },
    {
      'categoryImage' : 'assets/images/kurta_image1.jpg','name': 'Men wear'
    },
    {
      'categoryImage' : 'assets/images/kurta_image7.jpeg','name': 'Men wear'
    },
    {
      'categoryImage' : 'assets/images/formal_image1.jpg','name': 'Men wear'
    },

  ];

  List<Map<String,dynamic>> womenCategoryData = [
    {
      'categoryImage' : 'assets/images/womens_image1.jpg','name': 'Women wear'
    },
    {
      'categoryImage' : 'assets/images/women_image2.jpg','name': 'Women wear'
    },

    {
      'categoryImage' : 'assets/images/womens_image1.jpg','name': 'Women wear'
    },
    {
      'categoryImage' : 'assets/images/women_image2.jpg','name': 'Women wear'
    },
  ];

  List<Map<String,dynamic>> kidsCategoryData = [

    {
      'categoryImage' : 'assets/images/kids_image1.png','name': 'Kids wear'
    },
    {
      'categoryImage' : 'assets/images/kids_image2.png','name': 'Kids wear'
    },

    {
      'categoryImage' : 'assets/images/kids_image1.png','name': 'Kids wear'
    },
    {
      'categoryImage' : 'assets/images/kids_image2.png','name': 'Kids wear'
    },

  ];




}