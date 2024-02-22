import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:decoar/widgets/category_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'غرفة المعيشة',
      'image':
          'https://hips.hearstapps.com/hmg-prod/images/bethany-adams-interiors-j-l-jordan-photography-657c85285a3a4.jpg?crop=0.647xw:0.971xh;0,0.0240xh&resize=640:*', // استبدل بمسار الصورة الفعلي
      'color': Colors.brown
    },
    {
      'title': 'غرفة النوم',
      'image':
          'https://hips.hearstapps.com/hmg-prod/images/ghk090123homefeature-005-655b97aee4cbc.jpg?crop=0.828xw:1.00xh;0,0&resize=980:*', // استبدل بمسار الصورة الفعلي
      'color': Colors.deepPurple
    },
    {
      'title': 'الطعام',
      'image':
          'https://www.vanityliving.com/cdn/shop/products/CANELLI-6-WITH-DAVOS-LARGE.jpg?v=1689151274', // استبدل بمسار الصورة الفعلي
      'color': Colors.amber
    },
    {
      'title': 'المكتب',
      'image':
          'https://assets-global.website-files.com/5e72120a6f610062d1dae3b5/63b65f840f5cd6eef15b8aad_3A5A9831-min.jpg', // استبدل بمسار الصورة الفعلي
      'color': Colors.blueGrey
    },
    {
      'title': 'الخارجية',
      'image':
          'https://jysk.ae/media/magefan_blog/Outdoor-Furniture-Dubai.jpg', // استبدل بمسار الصورة الفعلي
      'color': Colors.green
    },
    {
      'title': 'الديكور',
      'image':
          'https://shop.static.ingka.ikea.com/category-images/Category_decorative-accessories.jpg', // استبدل بمسار الصورة الفعلي
      'color': Colors.orange
    },
    {
      'title': 'غرفة الأطفال',
      'image':
          'https://hips.hearstapps.com/hmg-prod/images/kids-rooms-ideas-hbx040122inspoopener-013-1649366709.jpg', // استبدل بمسار الصورة الفعلي
      'color': Colors.lightBlueAccent
    },
    {
      'title': 'المطبخ',
      'image':
          'https://www.bhg.com/thmb/MaQDVndcD-FF3qtf9e50rmfVml4=/4000x0/filters:no_upscale():strip_icc()/bhg-modern-kitchen-8RbSHoA8aKT9tEG-DcYr56-039892da05774ea78f8682b3f693bb5d.jpg', // استبدل بمسار الصورة الفعلي
      'color': Colors.redAccent
    },
    {
      'title': 'الإكسسوارات',
      'image':
          'https://cdn.shopify.com/s/files/1/0104/1524/3330/files/1_d090af01-ca9e-491f-918c-ded8f1153dc1.png?v=1692975635', // استبدل بمسار الصورة الفعلي
      'color': Colors.pinkAccent
    },
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          localizations!.translate('ordernow'),
          style: TextStyle(
              fontSize: 18,
              color: whiteColor,
              fontFamily: languageProvider.locale.languageCode == 'en'
                  ? 'Tajawal'
                  : 'Cairo'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: whiteColor, size: 20),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryTileWidget(
            category: categories[index],
          );
        },
      ),
    );
  }
}
