import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tmdb/config/routes/app_pages.dart';
import 'package:flutter_tmdb/model/results.dart';
import 'package:flutter_tmdb/presentation/home/widgets/grid_item.dart';
import 'package:flutter_tmdb/presentation/user/controller/user_controller.dart';
import 'package:flutter_tmdb/utils/common_shimmer.dart';
import 'package:flutter_tmdb/utils/constant.dart';

class UserScreen extends StatelessWidget {
  // Inisialisasi UserController dengan Get.find
  final UserController userController = Get.put(UserController());

  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildSection(
              title: 'List of Films Bookmark',
              data: userController.responseDataBook,
              isLoading: userController.isLoading,
              heightFactor: 0.36,
              limit: 6,
            ),
            const SizedBox(height: 10),
            _buildSection(
              title: 'List of Films Favorite',
              data: userController.responseDataWatch,
              isLoading: userController.isLoading,
              heightFactor: 0.36,
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
                child: GridView.builder(
                  controller: userController.controller,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      onBook: () {},
                      ondownload: () {
                        userController.downloadImage(
                            '${Constant.imagePath}${film.posterPath ?? ''}');
                      },
                      onfav: () {},
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
