class ApiMethods {
  static final ApiMethods _apiMethods = ApiMethods._internal();

  factory ApiMethods() {
    return _apiMethods;
  }

  ApiMethods._internal();

  String login = 'login';
  String getCategory = 'category';
  String getBanner = 'getbanner';
  String getProduct = 'product';
  String getProductDetails = 'single_product';
  String getSubcategory = 'subcategory';
  String addToFavorite = 'addfavorite';
  String removeToFavorite = 'removefavorite';
  String addToCart = 'Addtocart';
  String getCart = 'getcart';
  String removeCart = 'removecart';
  String getFavorite = 'getfavorite';
  String cartUpdate = 'Addtocartupdate';
  String placeOrder = 'place/order';
  String paymentStatus = 'payment/status';
  String getAddress = 'getaddress';
  String addAddress = 'addaddress';
  String deleteAddress = 'deleteaddress';
  String updateAddress = 'updateaddress';
  String getOrder = 'get-order';
  String getNotification = 'notification';
  String getPageRecords = 'get-page-records';
  String registerUser = 'registration';
  String userDetails = 'user/detailes';
  String userUpdateData = 'user/update';




}