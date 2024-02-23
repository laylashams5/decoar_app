import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CartButtonWithBadge extends StatelessWidget {
  final int itemCount;
  final VoidCallback onPressed;

  const CartButtonWithBadge({
    Key? key,
    required this.itemCount,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: whiteColor,
            size: 30,
          ),
          onPressed: onPressed,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              '$itemCount',
              style: const TextStyle(
                color: whiteColor,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
