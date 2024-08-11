import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tmdb/model/results.dart';
import 'package:flutter_tmdb/services/rest_api.dart';

mixin ExtendUser on GetxController {
  RestApi api = RestApi();
  ScrollController controller = ScrollController();
  RxBool isLoading = false.obs;
  RxList<Results> responseDataBook = <Results>[].obs;
  RxList<Results> responseDataWatch = <Results>[].obs;
  
  
}
