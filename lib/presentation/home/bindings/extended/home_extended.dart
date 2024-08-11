import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tmdb/model/results.dart';
import 'package:flutter_tmdb/services/rest_api.dart';

mixin ExtendHome on GetxController {
  RestApi api = RestApi();
  ScrollController controller = ScrollController();
  RxBool isLoading = false.obs;
  RxList<Results> responseDataPop = <Results>[].obs;
  RxList<Results> responseDataNow = <Results>[].obs;
  
  
}
