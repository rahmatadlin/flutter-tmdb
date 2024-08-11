import 'package:flutter/material.dart';
import 'package:flutter_tmdb/model/results.dart';
import 'package:flutter_tmdb/utils/constant.dart';

class GridItem extends StatelessWidget {
  final Results? film;
  final Function() onDetail, ondownload, onfav, onBook;

  const GridItem(
      {super.key,
      this.film,
      required this.onDetail,
      required this.ondownload,
      required this.onfav,
      required this.onBook});

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${Constant.imagePath}${film!.posterPath ?? ''}';

    return Card(
      child: InkWell(
        onTap: onDetail,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Container(
                height: 160,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) {
                        return child; // If loading is complete, display the image
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                  (progress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ); // Display loading indicator while image is loading
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    film?.title ?? "No Title",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2, // Ensure the title is limited to 2 lines
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.bookmark_border,
                            color: Colors.red,
                          ),
                          color: Colors.red, // Set icon color to red
                          highlightColor: Colors.transparent,
                          splashColor: Colors.red.withOpacity(0.2),
                          onPressed: onBook),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        highlightColor: Colors.red,
                        color: Colors.black,
                        onPressed: onfav,
                      ),
                      IconButton(
                          icon: const Icon(Icons.download),
                          color: Colors.black,
                          onPressed: ondownload),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
