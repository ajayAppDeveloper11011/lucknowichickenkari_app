
import 'package:flutter/cupertino.dart';
import '../../controllers/appbased_controller/appbase_controller.dart';
import '../../view_screen/Cart/cart_view.dart';
import '../../view_screen/category/categories_view.dart';
import '../../view_screen/home/home_view.dart';
import '../../view_screen/profile/profile_view.dart';

class BottomBarController extends AppBaseController {

  final List<Widget> handlePages = [
    const HomeScreen(),
    const CategoriesScreen(),
    CartScreen(),
    const ProfileScreen(),

  ];

  int currentIndex = 0;
  bool isLoading = false;



 void setPageIndex(int i ){
    currentIndex = i;
    update();
  }


}