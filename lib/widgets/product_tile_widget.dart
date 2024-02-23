import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:decoar/helpers/slide_route.dart';
import 'package:decoar/helpers/snackerbar_helper.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/providers/cart_provider.dart';
import 'package:decoar/providers/favorite_provider.dart';
import 'package:decoar/screens/cart/cart_screen.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTileWidget extends StatefulWidget {
  final Map product;

  const ProductTileWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductTileWidgetState createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  @override
  Widget build(BuildContext context) {
    final isInCart =
        Provider.of<CartProvider>(context).isInCart(widget.product['id']);
    final localizations = AppLocalizations.of(context);
    final isFavorite =
        Provider.of<FavoriteProvider>(context).isFavorite(widget.product['id']);
    final languageProvider = Provider.of<LocalizationProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: accentColor, width: 0.4),
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: widget.product['id'],
              child: CachedNetworkImage(
                imageUrl: widget.product['image'],
                width: double.infinity,
                height: 200,
              ),
            ),
            Container(
              color: accentColor,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(top: 13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.product['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        '${widget.product['price'].toStringAsFixed(2)} ${localizations!.translate(
                          'sar',
                        )}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      if (widget.product.containsKey('discount') &&
                          widget.product['discount'] > 0)
                        Text(
                          '${widget.product['originalPrice'].toStringAsFixed(2)} ${localizations.translate('sar')}',
                          style: const TextStyle(
                            color: grayColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: redColor,
                        onPressed: () {
                          if (isFavorite) {
                            Provider.of<FavoriteProvider>(context,
                                    listen: false)
                                .removeFavorite(widget.product['id']);
                          } else {
                            Provider.of<FavoriteProvider>(context,
                                    listen: false)
                                .addFavorite(
                                    widget.product['id'],
                                    widget.product['name'],
                                    widget.product['price'],
                                    widget.product['image']);
                          }
                        },
                      ),
                      IconButton(
                        icon: !isInCart
                            ? const Icon(Icons.add_shopping_cart)
                            : const Icon(Icons.remove_shopping_cart),
                        color: !isInCart ? primaryColor : grayColor,
                        onPressed: () {
                          !isInCart
                              ? {
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .addItem(
                                          widget.product['id'],
                                          widget.product['price'],
                                          widget.product['name'],
                                          widget.product['image']),
                                  showCustomSnackbar(
                                      context: context,
                                      message:
                                          '${widget.product['name']} ${localizations.translate('addtocart')}',
                                      onActionPressed: () {
                                        Navigator.of(context).push(
                                          SlideRoute(
                                            screen: const CartScreen(),
                                            duration: const Duration(
                                                milliseconds: 500),
                                          ),
                                        );
                                      },
                                      backgroundColor: greenColor,
                                      textColor: whiteColor,
                                      fontFamily: languageProvider
                                                  .locale.languageCode ==
                                              'en'
                                          ? 'Tajawal'
                                          : 'Cairo',
                                      actionLabel: localizations.translate(''))
                                }
                              : {
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .removeItem(widget.product['id']),
                                  showCustomSnackbar(
                                      context: context,
                                      message:
                                          '${widget.product['name']} ${localizations.translate('removefromcart')}',
                                      onActionPressed: () {
                                        Navigator.of(context).push(
                                          SlideRoute(
                                            screen: const CartScreen(),
                                            duration: const Duration(
                                                milliseconds: 500),
                                          ),
                                        );
                                      },
                                      backgroundColor: redColor,
                                      textColor: whiteColor,
                                      fontFamily: languageProvider
                                                  .locale.languageCode ==
                                              'en'
                                          ? 'Tajawal'
                                          : 'Cairo',
                                      actionLabel: localizations.translate(''))
                                };
                        },
                      ),
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
