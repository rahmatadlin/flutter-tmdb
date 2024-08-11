import 'package:get/get.dart';
import 'package:flutter_tmdb/presentation/detail/controller/detail_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(DetailController());
  }
}
