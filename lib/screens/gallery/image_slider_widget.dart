import 'package:cached_network_image/cached_network_image.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ImageSliderWidget extends StatelessWidget {
  final int initialPage;
  final List<Map<String, dynamic>> galleryPhotos;

  const ImageSliderWidget({
    Key? key,
    required this.initialPage,
    required this.galleryPhotos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: whiteColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: PageView.builder(
        itemCount: galleryPhotos.length,
        controller: PageController(initialPage: initialPage),
        itemBuilder: (context, index) {
          return InteractiveViewer(
            panEnabled: false,
            boundaryMargin: const EdgeInsets.all(80),
            minScale: 0.5,
            maxScale: 4,
            child: CachedNetworkImage(
              imageUrl: galleryPhotos[index]['imagePath'],
              fit: BoxFit.contain,
              errorWidget: (context, url, error) => const Icon(
                Icons.photo,
                color: grayColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
