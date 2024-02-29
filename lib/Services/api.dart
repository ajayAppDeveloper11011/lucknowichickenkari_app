
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:lucknowichickenkari_app/models/add_favorite_model.dart';
import 'package:lucknowichickenkari_app/models/add_to_cart_response.dart';
import 'package:lucknowichickenkari_app/models/delete_cart_response.dart';
import 'package:lucknowichickenkari_app/models/get_cart_data_response.dart';
import 'package:lucknowichickenkari_app/models/get_favorite_response.dart';
import 'package:lucknowichickenkari_app/models/get_notification_model.dart';
import 'package:lucknowichickenkari_app/models/get_order_details_response.dart';
import 'package:lucknowichickenkari_app/models/product_data_response.dart';
import 'package:lucknowichickenkari_app/models/remove_favorite_model.dart';
import 'package:lucknowichickenkari_app/models/update_address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/add_address_model.dart';
import '../models/category_data_response.dart';
import '../models/contact_us_response_model.dart';
import '../models/delete_address_model.dart';
import '../models/get_address_response.dart';
import '../models/get_banner_data_response.dart';
import '../models/get_order_model.dart';
import '../models/get_product_details_response.dart';
import '../models/login_model_response.dart';
import '../models/payment_status_model.dart';
import '../models/place_order_response.dart';
import '../models/sign_up_model_response.dart';
import '../models/sub_category_model.dart';
import '../models/update_cart_response.dart';
import '../models/user_details_model.dart';
import 'api_client.dart';
import 'api_methods.dart';

class Api {
  final ApiMethods _apiMethods = ApiMethods();
  final ApiClient _apiClient = ApiClient();

  static final Api _api = Api._internal();

final Connectivity connectivity = Connectivity();

  //final Connectivity? connectivity;

  factory Api() {
    return _api;
  }

  Api._internal();

  Future<Map<String, String>> getHeader() async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? tempToken= prefs.getString('temp_token');
     print('-------request for get header-----${tempToken}');
     return {
      'Authorization': tempToken.toString(),
      'Cookie': 'XSRF-TOKEN=eyJpdiI6IkI5M1N6Y0dWbGttczFuZDFueGlwUGc9PSIsInZhbHVlIjoiMzlrd0hwYlBJajRMTTdJOVh5OUtyVHBxL2lqYWowZzZwcXlMcTJYYUlCc09tNVdvYXdLQmVsd1VXRWlnKzR4ZEl1V1Zvdm9JNU9WTkVDSkJkWG5odGpwNHhRMDNiQUJiVkR1a0VRbEk0MG5NVzdGV1lUaVoyS092Z2c5cm9KZTUiLCJtYWMiOiJkN2EyZjZkYzE5ODdjYTFlOWVjZmVkMGQ5YjA2NmNmOGE2NDNhODVlMDMzNTU5NjY1ZTk4ZWZmOWYzNTcwNTJlIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6Inl6WDVtSmZGbnBBaHFpVTQ4cTRiTVE9PSIsInZhbHVlIjoidk1QWWJNVklYbjJkV3JpY0hXcDA0anpDaFcvZDRrTjlYWnk4S0xGKzBmaHVTQnFBTTBncFNyaEZ1ZlhUQUxiNVJiUURqTVNHL0MzNXJnRHJ2VFQ5dkw4blpxMXphWmoxK3FtOHk0Z2k4NVFyOVVsN2VuQ24rNE1tQUhJbWtvRFEiLCJtYWMiOiIwNzQyMjRlMDY5NzI1MjNjN2Q5MTdhNjZiNTk5NmJmZjI5NjdkZGFjNmE3OTFkZjY0MmE3YTU1MGQ5MGEzMDNjIiwidGFnIjoiIn0%3D'
      // return {'Content-Type': 'application/json'};
    };
  }




  Future<GetLoginModel> loginUserApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.login, body: body);
      if (res.isNotEmpty) {
        try {
          return getLoginModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetLoginModel(token: '', error: true, message: 'Success', data: [], );
        }
      } else {
        return GetLoginModel(token: '',error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetLoginModel(token: '',error: false, message: 'No Internet', data: []);
    }
  }



  Future<GetCategoryModel> homeCategoryDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getCategory, body: body);
      if (res.isNotEmpty) {
        try {
          return getCategoryModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print("----kDebugMode------${e}");
          }
          return GetCategoryModel(error: true, message: 'Success', data: []);
        }
      } else {
        return GetCategoryModel(error: false, message: 'success', data: []);
      }
    } else {
      return GetCategoryModel(error: false, message: 'success', data: []);
    }
  }

  Future<GetBannerModel> homeBannerDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.getMethod(method: _apiMethods.getBanner, body: body);
      if (res.isNotEmpty) {
        try {
          return getBannerModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print("----kDebugMode------${e}");
          }
          return GetBannerModel(error: true, message: 'success', banner: []);
        }
      } else {
        return GetBannerModel(error: true, message: 'success', banner: []);
      }
    } else {
      return GetBannerModel(error: true, message: 'success',banner: []);
    }
  }

  Future<GetProductModel> homeProductDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getProduct, body: body);
      if (res.isNotEmpty) {
        try {
          return getProductModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print("${e}");
          }
          return GetProductModel(error: true, status: 'success', products: []);
        }
      } else {
        return GetProductModel(error: false, status: 'Something went wrong', products: []);
      }
    } else {
      return GetProductModel(error: true, status: 'No Internet', products: []);
    }
  }


  Future<GetProductDetailsModel> productDetailsDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getProductDetails, body: body);
      if (res.isNotEmpty) {
        try {
          return getProductDetailsModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print("-----jjjjjjj${e}");
          }
          return GetProductDetailsModel(error: true, message: 'success', data: []);
        }
      } else {
        return GetProductDetailsModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetProductDetailsModel(error: false, message: 'No Internet', data: []);
    }
  }

  Future<SubCategoryModel> subCategoryDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getSubcategory, body: body);
      if (res.isNotEmpty) {
        try {
          return subCategoryModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print("-----${e}");
          }
          return SubCategoryModel(error: true, message: 'success', data: []);
        }
      } else {
        return SubCategoryModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return SubCategoryModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<AddFavoriteModel> addToFavoriteApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.addToFavorite, body: body);
      if (res.isNotEmpty) {
        try {
          return addFavoriteModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddFavoriteModel(error: true, message: 'Success', data: []);
        }
      } else {
        return AddFavoriteModel(error:false, message: 'Something went wrong', data: []);
      }
    } else {
      return AddFavoriteModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<RemoveFavoriteModel> removeFavoriteApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.removeToFavorite, body: body);
      if (res.isNotEmpty) {
        try {
          return removeFavoriteModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return RemoveFavoriteModel(error: true, message: 'Success', data: []);
        }
      } else {
        return RemoveFavoriteModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return RemoveFavoriteModel(error: false, message: 'No Internet', data: []);
    }
  }

  Future<GetFavoriteResponseModel> getFavoriteApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getFavorite, body: body);
      if (res.isNotEmpty) {
        try {
          return getFavoriteResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetFavoriteResponseModel(error: true, message: 'Success', data: []);
        }
      } else {
        return GetFavoriteResponseModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetFavoriteResponseModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<AddToCartResponseModel> addToCartApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.addToCart, body: body);
      if (res.isNotEmpty) {
        try {
          return addToCartResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddToCartResponseModel(error: true, message: 'Success', data: []);
        }
      } else {
        return AddToCartResponseModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return AddToCartResponseModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<GetCartResponseModel> getCartCartApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getCart, body: body);
      if (res.isNotEmpty) {
        try {
          return getCartResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetCartResponseModel(error: true, message: 'Success', data: []);
        }
      } else {
        return GetCartResponseModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetCartResponseModel(error: false, message: 'No Internet', data: []);
    }
  }

  Future<CartUpdateModel> updateCartCartApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.cartUpdate, body: body);
      if (res.isNotEmpty) {
        try {
          return cartUpdateModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return CartUpdateModel(error: true, message: 'Success', data: []);
        }
      } else {
        return CartUpdateModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return CartUpdateModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<DeleteCartResponseModel> deleteCartApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.removeCart, body: body);
      if (res.isNotEmpty) {
        try {
          return deleteCartResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return DeleteCartResponseModel(error: true, message: 'Success', data: []);
        }
      } else {
        return DeleteCartResponseModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return DeleteCartResponseModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<PlaceOrderModel> placeOrderApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.placeOrder, body: body);
      if (res.isNotEmpty) {
        try {
          return placeOrderModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PlaceOrderModel(error: true, orderId: '', message: 'Success',status:'0');
        }
      } else {
        return PlaceOrderModel(error: false, orderId: '', message: 'Something went wrong',status:'0');
      }
    } else {
      return PlaceOrderModel(error: false, orderId: '', message: 'No Internet', status:'0');
    }
  }

  Future<PaymentStatusModel> paymentStatusApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.paymentStatus, body: body);
      if (res.isNotEmpty) {
        try {
          return paymentStatusModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return PaymentStatusModel(error: true, message: 'Success', data: []);
        }
      } else {
        return PaymentStatusModel(error: false, message: 'Something Went Wrong', data: []);
      }
    } else {
      return PaymentStatusModel(error: false, message: 'No Internet', data: []);
    }
  }





  Future<GetAddressModelResponse> getAddressDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getAddress, body: body);
      if (res.isNotEmpty) {
        try {
          return getAddressModelResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetAddressModelResponse(error: true, message: 'Success', data: []);
        }
      } else {
        return GetAddressModelResponse(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetAddressModelResponse(error: false, message: 'No Internet', data: []);
    }
  }



  Future<AddAddressModelResponse> addAddressDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.addAddress, body: body);
      if (res.isNotEmpty) {
        try {
          return addAddressModelResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return AddAddressModelResponse(error: true, message: 'Success', data: []);
        }
      } else {
        return AddAddressModelResponse(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return AddAddressModelResponse(error: false, message: 'No Internet', data: []);
    }
  }


  Future<DeleteAddressResponseModel> deleteAddressDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.deleteAddress, body: body);
      if (res.isNotEmpty) {
        try {
          return deleteAddressResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return DeleteAddressResponseModel(error: true, message: 'Success', data: []);
        }
      } else {
        return DeleteAddressResponseModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return DeleteAddressResponseModel(error: false, message: 'No Internet', data: []);
    }
  }

  Future<UpdateAddressResponseModel> updateAddressDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.updateAddress, body: body);
      if (res.isNotEmpty) {
        try {
          return updateAddressResponseModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return UpdateAddressResponseModel(error: true, message: 'Success', data: []);
        }
      } else {
        return UpdateAddressResponseModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return UpdateAddressResponseModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<GetOrderModel> getOrderDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getOrder, body: body);
      if (res.isNotEmpty) {
        try {
          return getOrderModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetOrderModel(error: true, message: 'Success', data: []);
        }
      } else {
        return GetOrderModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetOrderModel(error: false, message: 'No Internet', data: []);
    }
  }


  Future<GetNotificationModel> getNotificationDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getNotification, body: body);
      if (res.isNotEmpty) {
        try {
          return getNotificationModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetNotificationModel(error: true, message: 'Success', data: []);
        }
      } else {
        return GetNotificationModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return GetNotificationModel(error: false, message: 'No Internet', data: []);
    }
  }

  Future<ContactUsModel> contactUsDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.getPageRecords, body: body);
      if (res.isNotEmpty) {
        try {
          return contactUsModelFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return ContactUsModel(error: true, message: 'Success', data:[]);
        }
      } else {
        return ContactUsModel(error: false, message: 'Something went wrong', data: []);
      }
    } else {
      return ContactUsModel(error: false, message: 'No Internet', data: []);
    }
  }

  Future<RegisterUserResponse> registerUserApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.registerUser, body: body);
      if (res.isNotEmpty) {
        try {
          return registerUserResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return RegisterUserResponse(error: true, message: e.toString(), data: []);
        }
      } else {
        return RegisterUserResponse(error: true, message: 'Something went wrong', data: []);
      }
    } else {
      return RegisterUserResponse(error: true, message: 'No Internet', data: []);
    }
  }

  Future<GetUserDetailsResponse> userDetailsDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.userDetails, body: body);
      if (res.isNotEmpty) {
        try {
          return getUserDetailsResponseFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return GetUserDetailsResponse(error: true, message: e.toString(), data: []);
        }
      } else {
        return GetUserDetailsResponse(error: true, message: 'Something went wrong', data: []);
      }
    } else {
      return GetUserDetailsResponse(error: true, message: 'No Internet', data: []);
    }
  }


  Future<OrderDetailsResponseData> orderDetailsDataApi(Map<String, String> body) async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
        await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
      String res =
      await _apiClient.postMethod(method: _apiMethods.orderDetails, body: body);
      if (res.isNotEmpty) {
        try {
          return orderDetailsResponseDataFromJson(res);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          return OrderDetailsResponseData(error: true, message: e.toString(), data: []);
        }
      } else {
        return OrderDetailsResponseData(error: true, message: 'Something went wrong', data: []);
      }
    } else {
      return OrderDetailsResponseData(error: true, message: 'No Internet', data: []);
    }
  }


  // Future<UpdateUserResponseModel> userDetailsUpdateApi(Map<String, String> body) async {
  //   if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
  //       await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
  //     String res =
  //     await _apiClient.postMethod(method: _apiMethods.userUpdateData, body: body);
  //
  //
  //     if (res.isNotEmpty) {
  //       try {
  //         return updateUserResponseModelFromJson(res);
  //       } catch (e) {
  //         if (kDebugMode) {
  //           print(e);
  //         }
  //         return UpdateUserResponseModel(error: true, message: e.toString(), data: []);
  //       }
  //     } else {
  //       return UpdateUserResponseModel(error: true, message: 'Something went wrong', data: []);
  //     }
  //   } else {
  //     return UpdateUserResponseModel(error: true, message: 'No Internet', data: []);
  //   }
  // }











// Future<ResetPasswordResponse> resetPasswordApi(Map<String, String> body) async {
  //   if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
  //       await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
  //     String res =
  //     await _apiClient.postMethod(method: _apiMethods.resetPassword, body: body);
  //     if (res.isNotEmpty) {
  //       try {
  //         return resetPasswordResponseFromJson(res);
  //       } catch (e) {
  //         if (kDebugMode) {
  //           print(e);
  //         }
  //         return ResetPasswordResponse(error: true, message: e.toString());
  //       }
  //     } else {
  //       return ResetPasswordResponse(error: true, message: 'Something went wrong');
  //     }
  //   } else {
  //     return ResetPasswordResponse(error: true, message: 'No Internet');
  //   }
  // }







}