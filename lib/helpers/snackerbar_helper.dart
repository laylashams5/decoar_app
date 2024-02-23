import 'dart:ui';

import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';

void showCustomSnackbar(
    {required BuildContext context,
    required String message,
    String? actionLabel = '',
    VoidCallback? onActionPressed,
    Color backgroundColor = greenColor,
    Color? textColor,
    double blurSigma = 5.0,
    String fontFamily = ''}) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top, left: 15.0, right: 15.0),
    content: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: textColor,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
              if (onActionPressed != null)
                TextButton(
                  onPressed: onActionPressed,
                  child: Text(actionLabel!,
                      style: TextStyle(
                        color: textColor,
                        fontFamily: fontFamily,
                      )),
                ),
            ],
          ),
        ),
      ),
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
