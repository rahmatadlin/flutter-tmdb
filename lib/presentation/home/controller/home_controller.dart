import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_tmdb/model/results.dart';
import 'package:flutter_tmdb/presentation/home/bindings/extended/home_extended.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController with ExtendHome {
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
        fetchData(language, page, 'popular', responseDataPop),
        fetchData(language, page, 'now_playing', responseDataNow),
      ]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchData(
    String? language,
    int? page,
    String? genre,
    RxList<Results> responseDataList,
  ) async {
    try {
      var response = await api.fetchFilm(
        page: page ?? 1,
        genre: genre ?? 'popular',
        language: language ?? 'en',
      );

      if (response is List) {
        responseDataList.clear();
        for (var element in response) {
          if (element is Map) {
            responseDataList.add(Results.fromJson(element));
          }
        }
      }
    } catch (e) {
      // Handle specific fetch errors if needed
      Get.snackbar('Error', 'Failed to fetch $genre data: $e',
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

  filmFav(int id) async {
   try {
      var response = await api.filmFav(
        body: {"media_type": "movie", "useCaseCd": id, "favorite": true},
      ) as Map<String, dynamic>;

      return response;
    } catch (e) {
      // Handle specific fetch errors if needed
      Get.snackbar('Error', 'Failed to fetch  data: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  filmBook(int id) async {
    try {
      var response = await api.filmbook(
        body: {"media_type": "movie", "useCaseCd": id, "watchlist": true},
      ) as Map<String, dynamic>;

      return response;
    } catch (e) {
      // Handle specific fetch errors if needed
      Get.snackbar('Error', 'Failed to fetch  data: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
