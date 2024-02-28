import 'package:cached_network_image/cached_network_image.dart';
import 'package:decoar/helpers/slide_route.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/screens/gallery/image_slider_widget.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<Map<String, dynamic>> galleryPhotos = [
    {
      "imagePath":
          'https://i.pinimg.com/564x/23/34/ad/2334add890050736165fb0b9237c3e62.jpg',
    },
    {
      "imagePath":
          'https://i.pinimg.com/564x/0c/0d/4e/0c0d4e69c902e3cd5cf3e1f0c7e35029.jpg',
    },
    {
      "imagePath":
          'https://i.pinimg.com/564x/7b/c8/4e/7bc84e48d2852032be7274da6ea9667f.jpg',
    },
    {
      "imagePath":
          'https://i.pinimg.com/564x/94/fc/c5/94fcc5733d9d49f810717a50ac189263.jpg',
    },
    {
      "imagePath":
          'https://i.pinimg.com/564x/9d/4a/8d/9d4a8dfb889206a27401e3a2eb6c8150.jpg',
    },
    {
      "imagePath":
          'https://i.pinimg.com/564x/a2/07/52/a20752864c78cf0e0681e4eb9d693ab6.jpg',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          localizations!.translate('gallery'),
          style: TextStyle(
              fontSize: 18,
              color: whiteColor,
              fontFamily: languageProvider.locale.languageCode == 'en'
                  ? 'Tajawal'
                  : 'Cairo'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: whiteColor, size: 18),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: galleryPhotos.length,
          itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () {
              Navigator.of(context).push(
                SlideRoute(
                  screen: ImageSliderWidget(
                    initialPage: index,
                    galleryPhotos: galleryPhotos,
                  ),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: galleryPhotos[index]['imagePath'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.photo,
                      color: grayColor,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: redColor.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: whiteColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index.isEven ? 2.5 : 3),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ),
    );
  }
}
