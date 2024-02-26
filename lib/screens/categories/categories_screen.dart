import 'package:decoar/helpers/slide_route.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/screens/products/products_screen.dart';
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
      'color': Colors.brown,
      'subcategories': [
        {
          'title': 'الأرائك',
          'products': [
            {
              'id': '1',
              'name': 'أريكة كلاسيكية',
              'image':
                  'https://5.imimg.com/data5/SELLER/Default/2023/3/ED/HH/SQ/184611494/whatsapp-image-2023-03-01-at-6-18-21-pm-1--500x500.jpg',
              'price': 299.99,
              "originalPrice": 200.99,
              "discount": 0.20,
            },
            {
              'id': '2',
              'name': 'أريكة حديثة',
              'image':
                  'https://officemaster.ae/img/2020/08/EVO-FRAME-2-Seater-Sofa.jpg',
              'price': 349.99,
              "originalPrice": 300.99,
              "discount": 0.20,
            },
          ],
        },
        {
          'title': 'طاولات القهوة',
          'products': [
            {
              'id': '3',
              'name': 'طاولة قهوة خشبية',
              'image': 'https://m.media-amazon.com/images/I/51ecJld3ZpL.jpg',
              'price': 129.99,
              "originalPrice": 149.99,
              "discount": 0.30,
            },
            {
              'id': '4',
              'name': 'طاولة قهوة زجاجية',
              'image':
                  'https://m.media-amazon.com/images/I/91WJfNSck7L._AC_UF1000,1000_QL80_.jpg',
              'price': 159.99,
              "originalPrice": 130.00,
              "discount": 0.10,
            },
          ],
        },
      ]
    },
    {
      'title': 'غرفة النوم',
      'image':
          'https://hips.hearstapps.com/hmg-prod/images/ghk090123homefeature-005-655b97aee4cbc.jpg?crop=0.828xw:1.00xh;0,0&resize=980:*', // استبدل بمسار الصورة الفعلي
      'color': Colors.deepPurple,
      'subcategories': []
    },
    {
      'title': 'الطعام',
      'image':
          'https://www.vanityliving.com/cdn/shop/products/CANELLI-6-WITH-DAVOS-LARGE.jpg?v=1689151274', // استبدل بمسار الصورة الفعلي
      'color': Colors.amber,
      'subcategories': []
    },
    {
      'title': 'المكتب',
      'image':
          'https://assets-global.website-files.com/5e72120a6f610062d1dae3b5/63b65f840f5cd6eef15b8aad_3A5A9831-min.jpg', // استبدل بمسار الصورة الفعلي
      'color': Colors.blueGrey,
      'subcategories': []
    },
    {
      'title': 'الخارجية',
      'image':
          'https://jysk.ae/media/magefan_blog/Outdoor-Furniture-Dubai.jpg', // استبدل بمسار الصورة الفعلي
      'color': Colors.green,
      'subcategories': []
    },
    {
      'title': 'الديكور',
      'image':
          'https://shop.static.ingka.ikea.com/category-images/Category_decorative-accessories.jpg', // استبدل بمسار الصورة الفعلي
      'color': Colors.orange,
      'subcategories': []
    },
    {
      'title': 'غرفة الأطفال',
      'image':
          'https://hips.hearstapps.com/hmg-prod/images/kids-rooms-ideas-hbx040122inspoopener-013-1649366709.jpg', // استبدل بمسار الصورة الفعلي
      'color': Colors.lightBlueAccent,
      'subcategories': []
    },
    {
      'title': 'المطبخ',
      'image':
          'https://www.bhg.com/thmb/MaQDVndcD-FF3qtf9e50rmfVml4=/4000x0/filters:no_upscale():strip_icc()/bhg-modern-kitchen-8RbSHoA8aKT9tEG-DcYr56-039892da05774ea78f8682b3f693bb5d.jpg', // استبدل بمسار الصورة الفعلي
      'color': Colors.redAccent,
      'subcategories': []
    },
    {
      'title': 'الإكسسوارات',
      'image':
          'https://cdn.shopify.com/s/files/1/0104/1524/3330/files/1_d090af01-ca9e-491f-918c-ded8f1153dc1.png?v=1692975635', // استبدل بمسار الصورة الفعلي
      'color': Colors.pinkAccent,
      'subcategories': []
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
          icon: const Icon(Icons.arrow_back_ios, color: whiteColor, size: 18),
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
          return GestureDetector(
              onTap: () {
                debugPrint('${categories[index]['title']}');
                Navigator.of(context).push(
                  SlideRoute(
                    screen: ProductsScreen(
                      subcategories: categories[index]['subcategories'],
                      category: categories[index]['title'],
                    ),
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: CategoryTileWidget(
                category: categories[index],
              ));
        },
      ),
    );
  }
}
