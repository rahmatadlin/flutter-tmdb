// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:flutter_tmdb/presentation/detail/view/detail_screen.dart';
import 'package:flutter_tmdb/presentation/home/bindings/home_bindings.dart';
import 'package:flutter_tmdb/presentation/home/view/home_screen.dart';
import 'package:flutter_tmdb/presentation/user/view/user_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
        name: _Paths.myProfile,
        page: () => UserScreen(),
        arguments: Get.arguments),
    GetPage(
      name: _Paths.detailMovie,
      page: () => DetailScreen(),
    ),
  ];
}
