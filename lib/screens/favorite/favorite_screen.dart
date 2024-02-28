import 'package:cached_network_image/cached_network_image.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/providers/favorite_provider.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteProvider>(context);
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          localizations!.translate('favorite'),
          style: TextStyle(
            fontSize: 18,
            color: whiteColor,
            fontFamily: languageProvider.locale.languageCode == 'en'
                ? 'Tajawal'
                : 'Cairo',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: whiteColor, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (favorite.favoriteItems.isEmpty) {
            return _buildEmptyFav(localizations);
          } else {
            return _buildFavList(favorite, constraints, context);
          }
        },
      ),
    );
  }

  Widget _buildEmptyFav(AppLocalizations localizations) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.favorite, size: 100, color: primaryColor),
          const SizedBox(height: 10),
          Text(
            localizations.translate('nopendingfav'),
            style: const TextStyle(fontSize: 16, color: grayColor),
          ),
        ],
      ),
    );
  }

  Widget _buildFavList(FavoriteProvider favorite, BoxConstraints constraints,
      BuildContext context) {
    final favoriteItems = Provider.of<FavoriteProvider>(context).favoriteItems;
    final languageProvider = Provider.of<LocalizationProvider>(context);

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        final favItem = favorite.favoriteItems.values.toList()[index];

        return Card(
          margin: const EdgeInsets.all(8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
                footer: GridTileBar(
                  backgroundColor: accentColor,
                  title: Text(
                    favItem.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: languageProvider.locale.languageCode == 'en'
                          ? 'Tajawal'
                          : 'Cairo',
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: redColor),
                    onPressed: () {
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .removeFavorite(favItem.id);
                    },
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: favItem.imgUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.photo,
                    color: grayColor,
                  ),
                )),
          ),
        );
      },
    );
  }
}
