import 'package:decoar/helpers/snackerbar_helper.dart';
import 'package:decoar/helpers/translate_number_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/providers/cart_provider.dart';
import 'package:decoar/theme/app_theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          localizations!.translate('mybaskets'),
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_sweep_outlined,
              color: whiteColor,
              size: 30,
            ),
            onPressed: () {
              if (cart.itemCount > 0) {
                _showClearCartDialog(cart);
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (cart.items.isEmpty) {
            return _buildEmptyCart(localizations);
          } else {
            return _buildCartList(cart, constraints, context);
          }
        },
      ),
    );
  }

  Widget _buildEmptyCart(AppLocalizations localizations) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.shopping_cart, size: 100, color: primaryColor),
          Text(
            localizations.translate('nobaskets'),
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            localizations.translate('nopendingbasket'),
            style: const TextStyle(fontSize: 16, color: grayColor),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog(CartProvider cart) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            AppLocalizations.of(context)!.translate('clearCart'),
            style: const TextStyle(color: primaryColor),
          ),
          content: Text(
            AppLocalizations.of(context)!.translate('clearCartConfirmation'),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: greenColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                cart.clear();
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.translate('clear'),
                style: const TextStyle(color: whiteColor),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: redColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.translate('cancel'),
                style: const TextStyle(color: whiteColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCartList(
      CartProvider cart, BoxConstraints constraints, BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);

    double calculateTotalPrice() {
      double totalPrice = 0.0;
      for (var item in cart.items.values) {
        totalPrice += item.price * item.quantity;
      }
      return totalPrice;
    }

    return Column(children: [
      Expanded(
          child: ListView.builder(
        itemCount: cart.itemCount,
        itemBuilder: (ctx, i) {
          final cartItem = cart.items.values.toList()[i];
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: constraints.maxHeight * 0.02,
              horizontal: constraints.maxWidth * 0.04,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(
                color: accentColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(constraints.maxHeight * 0.02),
              child: Row(
                children: [
                  Container(
                    width: constraints.maxHeight * 0.2,
                    height: constraints.maxHeight * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(cartItem.imgUrl),
                      ),
                    ),
                  ),
                  SizedBox(width: constraints.maxWidth * 0.05),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cartItem.title,
                              style: TextStyle(
                                  fontSize: constraints.maxHeight * 0.025),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline,
                                  color: greenColor),
                              onPressed: () =>
                                  cart.increaseItemQuantity(cartItem.id),
                            ),
                            Text(
                                '${translateNumberToArabic(cartItem.quantity)}x',
                                style: TextStyle(
                                    fontSize: constraints.maxHeight * 0.02)),
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: redColor),
                              onPressed: () =>
                                  cart.decreaseItemQuantity(cartItem.id),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${translateNumberToArabic((cartItem.price * cartItem.quantity).toStringAsFixed(2))} ${localizations!.translate('sar')} ',
                              style: TextStyle(
                                  fontSize: constraints.maxHeight * 0.025),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline,
                                  color: grayColor),
                              onPressed: () => {
                                cart.removeItem(cartItem.id),
                                showCustomSnackbar(
                                    context: context,
                                    message:
                                        '${cartItem.title} ${localizations.translate('removefromcart')}',
                                    onActionPressed: () {},
                                    backgroundColor: redColor,
                                    textColor: whiteColor,
                                    fontFamily:
                                        languageProvider.locale.languageCode ==
                                                'en'
                                            ? 'Tajawal'
                                            : 'Cairo',
                                    actionLabel: localizations.translate(''))
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations!.translate('total'),
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
            ),
            Text(
              '${translateNumberToArabic(calculateTotalPrice().toStringAsFixed(2))} ${localizations.translate('sar')} ',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
            ),
          ],
        ),
      ),
    ]);
  }
}
