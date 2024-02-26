import 'package:cached_network_image/cached_network_image.dart';
import 'package:decoar/helpers/slide_route.dart';
import 'package:decoar/helpers/snackerbar_helper.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/screens/cart/cart_screen.dart';
import 'package:decoar/screens/favorite/favorite_screen.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:decoar/providers/cart_provider.dart';
import 'package:decoar/providers/favorite_provider.dart';

class ProductScreen extends StatefulWidget {
  final Map product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    bool isFavorite = favoriteProvider.isFavorite(widget.product['id']);
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);
    bool isExpanded = false;
    final PageController controller = PageController();
    int currentPage = 0;

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    void addToCart() {
      cartProvider.addItem(widget.product['id'], widget.product['price'],
          widget.product['name'], widget.product['image'], quantity);

      showCustomSnackbar(
          context: context,
          message:
              '${widget.product['name']} ${localizations!.translate('addtocart')}',
          onActionPressed: () {
            Navigator.of(context).push(
              SlideRoute(
                screen: const CartScreen(),
                duration: const Duration(milliseconds: 500),
              ),
            );
          },
          backgroundColor: greenColor,
          textColor: whiteColor,
          fontFamily: languageProvider.locale.languageCode == 'en'
              ? 'Tajawal'
              : 'Cairo',
          actionLabel: localizations.translate('viewcart'));
    }

    void toggleFavorite() {
      isFavorite
          ? {
              favoriteProvider.removeFavorite(widget.product['id']),
              showCustomSnackbar(
                  context: context,
                  message:
                      '${widget.product['name']} ${localizations!.translate('removefromfav')}',
                  onActionPressed: () {
                    Navigator.of(context).push(
                      SlideRoute(
                        screen: const FavoriteScreen(),
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  backgroundColor: greenColor,
                  textColor: whiteColor,
                  fontFamily: languageProvider.locale.languageCode == 'en'
                      ? 'Tajawal'
                      : 'Cairo',
                  actionLabel: localizations.translate('viewfav'))
            }
          : {
              favoriteProvider.addFavorite(
                widget.product['id'],
                widget.product['name'],
                widget.product['price'],
                widget.product['image'],
              ),
              showCustomSnackbar(
                  context: context,
                  message:
                      '${widget.product['name']} ${localizations!.translate('addtofav')}',
                  onActionPressed: () {
                    Navigator.of(context).push(
                      SlideRoute(
                        screen: const FavoriteScreen(),
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  backgroundColor: greenColor,
                  textColor: whiteColor,
                  fontFamily: languageProvider.locale.languageCode == 'en'
                      ? 'Tajawal'
                      : 'Cairo',
                  actionLabel: localizations.translate('viewfav'))
            };
    }

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            PageView(
                              controller: controller,
                              children: [
                                CachedNetworkImage(
                                    imageUrl: widget.product['image'],
                                    fit: BoxFit.contain),
                                CachedNetworkImage(
                                    imageUrl: widget.product['image'],
                                    fit: BoxFit.contain),
                                CachedNetworkImage(
                                    imageUrl: widget.product['image'],
                                    fit: BoxFit.contain),
                              ],
                            ),
                            Positioned(
                              bottom: 8.0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List<Widget>.generate(3, (index) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: currentPage == index ? 24.0 : 8.0,
                                    height: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      color: currentPage == index
                                          ? primaryColor
                                          : accentColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.product['discount'] > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${widget.product['discount'] * 100}% ${localizations!.translate('off')}',
                            style: const TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                      Text(
                        widget.product['name'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: incrementQuantity,
                            backgroundColor: primaryColor,
                            elevation: 0,
                            mini: true,
                            child: const Icon(Icons.add, color: whiteColor),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: decrementQuantity,
                            backgroundColor: primaryColor,
                            elevation: 0,
                            mini: true,
                            child: const Icon(Icons.remove, color: whiteColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Card(
                        margin: const EdgeInsets.all(0.0),
                        elevation: 0,
                        color: accentColor,
                        child: ExpansionTile(
                          title: Text(
                            localizations!.translate('info'),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: blackColor),
                          ),
                          childrenPadding: const EdgeInsets.all(16.0),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          onExpansionChanged: (expanded) {
                            setState(() {
                              isExpanded = expanded;
                            });
                          },
                          trailing: Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up_outlined
                                : Icons.keyboard_arrow_down_outlined,
                            color: grayColor,
                          ),
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              widget.product['name'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: grayColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                  onTap: addToCart,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(width: 1, color: accentColor)),
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 3),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(39),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    localizations.translate('addtobasket'),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: whiteColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 130,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        ' ${widget.product['price']} ${localizations.translate('sar')}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: whiteColor,
                                        ),
                                      ),
                                      Text(
                                        '${widget.product['originalPrice'].toStringAsFixed(2)} ${localizations.translate('sar')}',
                                        style: const TextStyle(
                                          color: grayColor,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                size: 30,
                color: blackColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            right: 16,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 30,
              ),
              color: isFavorite ? redColor : blackColor,
              onPressed: toggleFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
