import 'dart:convert';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String onBoarding = '/on-boarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String accessLocation = '/access-location';
  static const String pickMap = '/pick-map';
  static const String interest = '/interest';
  static const String main = '/main';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String search = '/search';
  static const String restaurant = '/restaurant';
  static const String orderDetails = '/order-details';
  static const String profile = '/profile';
  static const String updateProfile = '/update-profile';
  static const String coupon = '/coupon';
  static const String notification = '/notification';
  static const String map = '/map';
  static const String address = '/address';
  static const String orderSuccess = '/order-successful';
  static const String payment = '/payment';
  static const String checkout = '/checkout';
  static const String orderTracking = '/track-order';
  static const String basicCampaign = '/basic-campaign';
  static const String html = '/html';
  static const String categories = '/categories';
  static const String categoryProduct = '/category-product';
  static const String popularFoods = '/popular-foods';
  static const String itemCampaign = '/item-campaign';
  static const String support = '/help-and-support';
  static const String rateReview = '/rate-and-review';
  static const String update = '/update';
  static const String cart = '/cart';
  static const String addAddress = '/add-address';
  static const String editAddress = '/edit-address';
  static const String restaurantReview = '/restaurant-review';
  static const String allRestaurants = '/restaurants';
  static const String wallet = '/wallet';
  static const String searchRestaurantItem = '/search-Restaurant-item';
  static const String productImages = '/product-images';
  static const String referAndEarn = '/refer-and-earn';

  static String getInitialRoute() => initial;

  static String getSplashRoute(int orderID) => '$splash?id=$orderID';

  static String getLanguageRoute(String page) => '$language?page=$page';

  static String getOnBoardingRoute() => onBoarding;

  static String getSignInRoute(String page) => '$signIn?page=$page';

  static String getSignUpRoute() => signUp;

  static String getVerificationRoute(
      String number, String token, String page, String pass) {
    return '$verification?page=$page&number=$number&token=$token&pass=$pass';
  }

  static String getAccessLocationRoute(String page) =>
      '$accessLocation?page=$page';

  static String getPickMapRoute(String page, bool canRoute) =>
      '$pickMap?page=$page&route=${canRoute.toString()}';

  static String getInterestRoute() => interest;

  static String getMainRoute(String page) => '$main?page=$page';

  static String getResetPasswordRoute(
          String phone, String token, String page) =>
      '$resetPassword?phone=$phone&token=$token&page=$page';

  static String getSearchRoute() => search;

  static String getRestaurantRoute(int id) => '$restaurant?id=$id';

  static String getOrderDetailsRoute(int orderID) {
    return '$orderDetails?id=$orderID';
  }

  static String getProfileRoute() => profile;

  static String getUpdateProfileRoute() => updateProfile;

  static String getNotificationRoute() => notification;

  static String getAddressRoute() => address;

  static String getOrderSuccessRoute(
          String orderID, String status, double amount) =>
      '$orderSuccess?id=$orderID&status=$status&amount=$amount';

  static String getPaymentRoute(String id, int user, double amount) =>
      '$payment?id=$id&user=$user&amount=$amount';

  static String getCheckoutRoute(String page) => '$checkout?page=$page';

  static String getOrderTrackingRoute(int id) => '$orderTracking?id=$id';

  static String getHtmlRoute(String page) => '$html?page=$page';

  static String getCategoryRoute() => categories;

  static String getCategoryProductRoute(int id, String name) {
    List<int> encoded = utf8.encode(name);
    String data = base64Encode(encoded);
    return '$categoryProduct?id=$id&name=$data';
  }

  static String getPopularFoodRoute(bool isPopular) =>
      '$popularFoods?page=${isPopular ? 'popular' : 'reviewed'}';

  static String getItemCampaignRoute() => itemCampaign;

  static String getSupportRoute() => support;

  static String getReviewRoute() => rateReview;

  static String getUpdateRoute(bool isUpdate) =>
      '$update?update=${isUpdate.toString()}';

  static String getCartRoute() => cart;

  static String getAddAddressRoute(bool fromCheckout, int zoneId) =>
      '$addAddress?page=${fromCheckout ? 'checkout' : 'address'}&zone_id=$zoneId';

  static String getRestaurantReviewRoute(int restaurantID) =>
      '$restaurantReview?id=$restaurantID';

  static String getAllRestaurantRoute(String page) =>
      '$allRestaurants?page=$page';

  static String getWalletRoute(bool fromWallet) =>
      '$wallet?page=${fromWallet ? 'wallet' : 'loyalty_points'}';

  static String getSearchRestaurantProductRoute(int productID) =>
      '$searchRestaurantItem?id=$productID';

  static String getReferAndEarnRoute() => referAndEarn;
}
