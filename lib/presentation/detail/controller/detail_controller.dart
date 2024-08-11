
import 'package:get/get.dart';
import 'package:flutter_tmdb/model/results.dart';
import 'package:flutter_tmdb/presentation/detail/bindings/extended/detail_extended.dart';


class DetailController extends GetxController with ExtendDetail {
  @override
  void onInit() {
    fetchData(Get.arguments as int);

    super.onInit();
  }

  Future<void> fetchData(
    int? id,
  ) async {
    try {
      isLoading.value = true;

      var response = await api.detailFilm(
        id: id ?? 1,
      );
      if (response is Map) {
        Details details = Details.fromJson(response);
        model.value = details;
      }
    } catch (e) {
      // Handle specific fetch errors if needed
      Get.snackbar('Error', 'Failed to fetch $id data: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
