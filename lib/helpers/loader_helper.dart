import 'package:flutter/material.dart';
import 'package:decoar/theme/app_theme.dart';

class LoaderHelper {
  static OverlayEntry? _overlayEntry;

  static void showLoader(BuildContext context) {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry(context);
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  static void hideLoader() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: whitegreyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  color: secondaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
