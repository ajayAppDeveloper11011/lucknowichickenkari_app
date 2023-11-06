import 'package:get/get.dart';
import 'package:lucknowichickenkari_app/Route_managements/routes.dart';
import 'package:lucknowichickenkari_app/Route_managements/screen_bindings.dart';
import 'package:lucknowichickenkari_app/view_screen/about_us/about_us_view.dart';
import 'package:lucknowichickenkari_app/view_screen/add_address/add_address_view.dart';
import 'package:lucknowichickenkari_app/view_screen/category/categories_view.dart';
import 'package:lucknowichickenkari_app/view_screen/contact_us/contact_us_view.dart';
import 'package:lucknowichickenkari_app/view_screen/customer_support/customer_support_view.dart';
import 'package:lucknowichickenkari_app/view_screen/manage_address/manage_address_view.dart';
import 'package:lucknowichickenkari_app/view_screen/my_order/my_order_view.dart';
import 'package:lucknowichickenkari_app/view_screen/my_order_details/my_order_details.dart';
import 'package:lucknowichickenkari_app/view_screen/notification/notification.dart';
import 'package:lucknowichickenkari_app/view_screen/order_placed/order_placed_screen.dart';
import 'package:lucknowichickenkari_app/view_screen/payment/payment_method.dart';
import 'package:lucknowichickenkari_app/view_screen/privacy_policy/privacy_policy_view.dart';
import 'package:lucknowichickenkari_app/view_screen/product_details_view/product_detail.dart';
import 'package:lucknowichickenkari_app/view_screen/sub_category/sub_category_screen.dart';
import 'package:lucknowichickenkari_app/view_screen/transaction/transaction_view.dart';
import '../Widgets/bottom_navigation_bar/bottom_bar.dart';
import '../view_screen/Cart/cart_view.dart';
import '../view_screen/auth_view/forget_password_view.dart';
import '../view_screen/auth_view/login_view.dart';
import '../view_screen/auth_view/signup_view.dart';
import '../view_screen/favoite/favorite_screen.dart';
import '../view_screen/home/home_view.dart';
import '../view_screen/my_wallet/my_wallet_view.dart';
import '../view_screen/profile/profile_view.dart';
import '../view_screen/splash_view/splash_view.dart';


class AllPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: splashScreen,
          page: () => const SplashScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: loginScreen,
          page: () => const LoginScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: signupScreen,
          page: () =>  const SignUpScreen(),
          binding: ScreenBindings()),

      GetPage(
          name:forgetScreen,
          page: () =>  const ForgetScreen(),
          binding: ScreenBindings()),

      GetPage(
          name:homeScreen,
          page: () =>  const HomeScreen(),
          binding: ScreenBindings()),

      GetPage(
          name:productScreen,
          page: () =>  const ProductDetails(),
          binding: ScreenBindings()),

      GetPage(
          name: bottomBar,
          page: () =>  const BottomBar(),
          binding: ScreenBindings()),


      GetPage(
          name: notificationScreen,
          page: () =>  const NotificationScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: categoryScreen,
          page: () =>  const CategoriesScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: cartScreen,
          page: () =>  CartScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: profileScreen,
          page: () =>  const ProfileScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: myOrderScreen,
          page: () =>  const MyOrder(),
          binding: ScreenBindings()),

      GetPage(
          name: manageAddressScreen,
          page: () =>  const ManageAddress(),
          binding: ScreenBindings()),

      GetPage(
          name: walletScreen,
          page: () =>const MyWalletScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: transactionScreen,
          page: () =>const TransactionScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: customerSupportScreen,
          page: () =>const CustomerSupportScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: aboutUsScreen,
          page: () =>const AboutUsScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: contactUsScreen,
          page: () =>const ContactUsScreen(),
          binding: ScreenBindings()),


      GetPage(
          name:privacyScreen,
          page: () =>const PrivacyPolicyScreen(),
          binding: ScreenBindings()),

      GetPage(
          name:addAddressScreen,
          page: () => AddAddressScreen(),
          binding: ScreenBindings()),

      GetPage(
          name:myOrderDetailsScreen,
          page: () =>const MyOrderDetails(),
          binding: ScreenBindings()),


      GetPage(
          name:favoriteScreen,
          page: () =>const FavoriteScreen(),
          binding: ScreenBindings()),


      GetPage(
          name:subCateScreen,
          page: () =>const SubCategoryScreen(),
          binding: ScreenBindings()),

      GetPage(
          name:orderPlacedScreen,
          page: () =>const OrderPlacedScreen(),
          binding: ScreenBindings()),

      GetPage(
          name:paymentMethodScreen,
          page: () =>const PaymentMethodScreen(),
          binding: ScreenBindings()),

    ];
  }
}
