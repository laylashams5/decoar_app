import 'package:cached_network_image/cached_network_image.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CategoryTileWidget extends StatelessWidget {
  final Map<String, dynamic> category;

  const CategoryTileWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: whitegreyColor,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
              child: CachedNetworkImage(
            imageUrl: category['image'],
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )),
        ),
        Flexible(
          child: Text(
            category['title'],
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
