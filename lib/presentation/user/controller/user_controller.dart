import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_tmdb/model/results.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_tmdb/presentation/user/bindings/extended/user_extended.dart';

class UserController extends GetxController with ExtendUser {
  @override
  void onInit() {
    super.onInit();
    fetchAllData('en', 1); // Fetch all data concurrently on init
  }

  Future<void> fetchAllData(String? language, int? page) async {
    try {
      isLoading.value = true;

      // Fetch data concurrently
      await Future.wait([
        fetchDataFav(responseDataBook),
        fetchDataList(responseDataWatch),
      ]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDataFav(
    RxList<Results> responseDataList,
  ) async {
    try {
      var response = await api.fetchFilmFav();

      if (response is List) {
        responseDataList.clear();
        for (var element in response) {
          if (element is Map) {
            responseDataList.add(Results.fromJson(element));
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> fetchDataList(
    RxList<Results> responseDataList,
  ) async {
    try {
      var response = await api.fetchFilmList();

      if (response is List) {
        responseDataList.clear();
        for (var element in response) {
          if (element is Map) {
            responseDataList.add(Results.fromJson(element));
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> downloadImage(String url) async {
    try {
      // Get the application documents directory
      final directory = await getApplicationDocumentsDirectory();

      // Define the file path
      final filePath = '${directory.path}/${url.split('/').last}';

      // Download the image using Dio
      Dio dio = Dio();
      await dio.download(url, filePath);

      print('Download completed: $filePath');
    } catch (e) {
      print('Error downloading image: $e');
    }
  }
}
