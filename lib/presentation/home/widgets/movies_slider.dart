import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tmdb/model/results.dart';
import 'package:flutter_tmdb/utils/constant.dart';

class MoviesSlider extends StatelessWidget {
  final List<Results> films;
  final void Function(int index) onItemTap;

  const MoviesSlider({super.key, required this.films, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Sesuaikan tinggi sesuai kebutuhan
      child: CarouselSlider.builder(
        itemCount: films.length,
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          viewportFraction: 0.7,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (context, index, realIndex) {
          final film = films[index];
          final imageUrl = '${Constant.imagePath}${film.posterPath ?? ''}';
          final title = film.title ?? 'No Title'; // Default title jika tidak tersedia

          return GestureDetector(
            onTap: () => onItemTap(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,  // Membatasi ukuran Column sesuai konten
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fitWidth,
                    height: 200,  // Tinggi untuk gambar
                    width: double.infinity,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                const SizedBox(height: 8),  // Spasi antara gambar dan teks
                Flexible(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,  // Membatasi jumlah baris teks
                    overflow: TextOverflow.ellipsis,  // Menangani teks panjang dengan elipsis
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
