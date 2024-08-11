import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tmdb/config/routes/app_pages.dart';
import 'package:flutter_tmdb/model/results.dart';
import 'package:flutter_tmdb/presentation/home/controller/home_controller.dart';
import 'package:flutter_tmdb/presentation/home/widgets/grid_item.dart';
import 'package:flutter_tmdb/presentation/home/widgets/movies_slider.dart';
import 'package:flutter_tmdb/utils/common_shimmer.dart';
import 'package:flutter_tmdb/utils/constant.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie APP'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              Get.toNamed(
                Routes.myProfile,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildSection(
              title: 'List of Films Popular',
              data: homeController.responseDataPop,
              isLoading: homeController.isLoading,
              heightFactor: 0.36,
              useMoviesSlider: true,
              limit: 6,
            ),
            const SizedBox(height: 10),
            _buildSection(
              title: 'List of Films Now Playing',
              data: homeController.responseDataNow,
              isLoading: homeController.isLoading,
              heightFactor: 0.36,
              useMoviesSlider: false,
              limit: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required RxList<Results> data,
    required RxBool isLoading,
    required double heightFactor,
    required bool useMoviesSlider,
    required int limit,
  }) {
    return Obx(() {
      if (isLoading.isTrue) {
        return SizedBox(
          height: MediaQuery.of(Get.context!).size.height * heightFactor,
          child: const Center(child: CircularProgressIndicator()),
        );
      } else if (data.isEmpty) {
        return SizedBox(
          height: MediaQuery.of(Get.context!).size.height * heightFactor,
          child: const Center(
            child: Text(
              'No items available',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),
        );
      } else {
        final limitedData = data.take(limit).toList();

        return CommonShimmer(
          isLoading: isLoading.isTrue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(Get.context!).size.height * heightFactor,
                child: useMoviesSlider
                    ? MoviesSlider(
                        films: limitedData,
                        onItemTap: (index) {
                          Get.toNamed(
                            Routes.detailMovie,
                            arguments: limitedData[index].id,
                          );
                        },
                      )
                    : GridView.builder(
                        controller: homeController.controller,
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: limitedData.length,
                        itemBuilder: (context, index) {
                          final film = limitedData[index];
                          return GridItem(
                            onDetail: () {
                              Get.toNamed(Routes.detailMovie,
                                  arguments: limitedData[index].id);
                            },
                            onBook: () {
                              homeController.filmBook(film.id!);
                            },
                            ondownload: () {
                              print(
                                  '${Constant.imagePath}${film.posterPath ?? ''}');
                              homeController.downloadImage(
                                  '${Constant.imagePath}${film.posterPath ?? ''}');
                            },
                            onfav: () {
                              homeController.filmFav(film.id!);
                            },
                            film: film,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      }
    });
  }
}
