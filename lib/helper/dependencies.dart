import 'package:first_online_shopping_app/controller/auth_controller.dart';
import 'package:first_online_shopping_app/controller/location_controller.dart';
import 'package:first_online_shopping_app/data/api/api_client.dart';
import 'package:first_online_shopping_app/controller/cart_controller.dart';
import 'package:first_online_shopping_app/controller/popular_product_controller.dart';
import 'package:first_online_shopping_app/controller/recommended_product_controller.dart';
import 'package:first_online_shopping_app/data/repository/auth_repo.dart';
import 'package:first_online_shopping_app/data/repository/cart_repo.dart';
import 'package:first_online_shopping_app/data/repository/location_repo.dart';
import 'package:first_online_shopping_app/data/repository/popular_product_repo.dart';
import 'package:first_online_shopping_app/data/repository/recommended_product_repo.dart';
import 'package:first_online_shopping_app/data/repository/user_repo.dart';
import 'package:first_online_shopping_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/user_controller.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

//apiclient
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      AuthRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => LocationRepo(
      apiClient: Get.find(), sharedPreferences: sharedPreferences));

  //controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
