import 'package:get/get.dart';
import 'package:flutter_tmdb/presentation/home/controller/home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
