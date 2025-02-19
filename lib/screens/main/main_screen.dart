import 'package:cached_network_image/cached_network_image.dart';
import 'package:decoar/helpers/app_constants.dart';
import 'package:decoar/helpers/slide_route.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/providers/cart_provider.dart';
import 'package:decoar/screens/account/account_screen.dart';
import 'package:decoar/screens/categories/categories_screen.dart';
import 'package:decoar/screens/contactus/contactus_screen.dart';
import 'package:decoar/screens/gallery/gallery_screen.dart';
import 'package:decoar/screens/products/products_screen.dart';
import 'package:decoar/screens/request/request_screen.dart';
import 'package:decoar/screens/search/search_screen.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:decoar/widgets/category_tile_widget.dart';
import 'package:decoar/widgets/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
  final List<Map<String, dynamic>> offers = [
    {
      "imagePath":
          'https://www.shutterstock.com/image-illustration/flash-sale-banner-template-special-260nw-2222845749.jpg',
      "title": 'FLASH SALE!',
      "description": 'up to 70% OFF',
    },
    {
      "imagePath":
          'https://www.shutterstock.com/shutterstock/videos/1096472843/thumb/1.jpg?ip=x480',
      "title": 'FLASH SALE!',
      "description": 'up to 70% OFF',
    },
  ];
  final List<Map<String, dynamic>> galleryPhotos = [
    {
      "imagePath":
          'https://i.pinimg.com/564x/23/34/ad/2334add890050736165fb0b9237c3e62.jpg',
    },
    {
      "imagePath":
          'https://i.pinimg.com/564x/0c/0d/4e/0c0d4e69c902e3cd5cf3e1f0c7e35029.jpg',
    },
    {
      "imagePath":
          'https://i.pinimg.com/564x/7b/c8/4e/7bc84e48d2852032be7274da6ea9667f.jpg',
    },
  ];

  final List<Map<String, dynamic>> partners = [
    {
      "logoPath":
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Ikea_logo.svg/800px-Ikea_logo.svg.png',
      "name": 'Ikea',
    },
    {
      "logoPath":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIYjbtk5Y9eYw6OnEGiY9Rltvwa7I06RV9CB1EuKTrqzPM3kedQ7HtmFoWCuKpUykQQVo&usqp=CAU',
      "name": 'TJX',
    },
    {
      "logoPath":
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/HNI_logo.svg/1200px-HNI_logo.svg.png',
      "name": 'HNI',
    },
    {
      "logoPath":
          'https://searchlogovector.com/wp-content/uploads/2018/07/steelcase-logo-vector-xs.png',
      "name": 'Steelcase',
    },
    {
      "logoPath":
          'https://www.liblogo.com/img-logo/as7236ab08-ashley-furniture-logo-ashley-furniture-logo-png-transparent-logo--com.png',
      "name": 'Ashley',
    },
  ];
  final List<Map<String, dynamic>> vendors = [
    {
      "logoPath":
          'https://upload.wikimedia.org/wikipedia/commons/4/4a/Amazon_icon.svg',
      "name": 'Amazon',
    },
    {
      "logoPath":
          'https://upload.wikimedia.org/wikipedia/commons/a/a9/Apple_logo_black.svg',
      "name": 'Apple',
    },
    {
      "logoPath":
          'https://upload.wikimedia.org/wikipedia/commons/2/26/Google_2015_logo.svg',
      "name": 'Google',
    },
    {
      "logoPath":
          'https://upload.wikimedia.org/wikipedia/commons/c/cf/Microsoft_logo_(2012).svg',
      "name": 'Microsoft',
    },
    {
      "logoPath":
          'https://upload.wikimedia.org/wikipedia/commons/f/fa/Walmart_logo.svg',
      "name": 'Walmart',
    },
  ];

  List products = [
    {
      "id": "1",
      "name": 'منتج ١',
      "image": 'https://m.media-amazon.com/images/I/51zVJbBSksL._AC_SY879_.jpg',
      "price": 99.99,
      "originalPrice": 149.99,
      "discount": 0.20,
    },
    {
      "id": "2",
      "name": 'منتج ٢',
      "image":
          'https://fatimafurniture.ae/wp-content/uploads/2022/11/Flared-Arm-Tufted-Velvet-3-Seater-Sofa-1.jpg',
      "price": 79.99,
      "originalPrice": 89.99,
      "discount": 0.10,
    },
    {
      "id": "3",
      "name": 'منتج ٣',
      "image":
          'https://m.media-amazon.com/images/I/81Ddh54rbQL._AC_UF1000,1000_QL80_.jpg',
      "price": 49.99,
      "originalPrice": 69.99,
      "discount": 0.25,
    },
    {
      "id": "4",
      "name": 'منتج ٤',
      "image":
          'https://www.ikea.com/ae/en/images/products/paerup-2-seat-sofa-gunnared-dark-grey__1041901_pe841181_s5.jpg',
      "price": 49.99,
      "originalPrice": 69.99,
      "discount": 0.25,
    },
  ];

  void _goToSearchScreen(BuildContext context) {
    Navigator.of(context).push(
      SlideRoute(
        screen: const SearchScreen(),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    String? deliveryAddress;
    void updateDeliveryAddress(String newAddress) {
      setState(() {
        deliveryAddress = newAddress;
      });
    }

    final cart = Provider.of<CartProvider>(context);

    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          decoration: const BoxDecoration(
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: lightBlackColor,
                offset: Offset(0, 2),
                blurRadius: 0,
                spreadRadius: 1,
              ),
            ],
          ),
          child: AppBar(
            toolbarHeight: 140,
            automaticallyImplyLeading: false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          AppConstants.logoHeader,
                          width: 30,
                          height: 30,
                          color: whiteColor,
                        ),
                        Text(
                          localizations!.translate('appTitle'),
                          style: TextStyle(
                              fontFamily:
                                  languageProvider.locale.languageCode == 'en'
                                      ? 'Tajawal'
                                      : 'Cairo',
                              color: whiteColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                SlideRoute(
                                  screen: const ContactusScreen(),
                                  duration: const Duration(milliseconds: 500),
                                ),
                              );
                            },
                            child: const Icon(Icons.message,
                                color: whiteColor, size: 28)),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                SlideRoute(
                                  screen: const AccountScreen(),
                                  duration: const Duration(milliseconds: 500),
                                ),
                              );
                            },
                            child: const Icon(Icons.more_vert_rounded,
                                color: whiteColor, size: 30)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                    onTap: () {
                      _goToSearchScreen(context);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: localizations.translate('searchfor'),
                          prefixIcon:
                              const Icon(Icons.search, color: greyColor),
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: whiteColor,
                        ),
                      ),
                    ))
              ],
            ),
            elevation: 0,
            backgroundColor: primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  SlideRoute(
                    screen: const RequestScreen(),
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: greyColor.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.face_retouching_natural_sharp,
                        color: primaryColor),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        deliveryAddress ?? localizations.translate('howhelp'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: greyColor),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.translate('categories'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      SlideRoute(
                        screen: const CategoriesScreen(),
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Text(
                    localizations.translate('seeall'),
                    style: const TextStyle(fontSize: 14, color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (categories.length / 2).ceil(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 4, bottom: 4),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.8,
                        child: Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                  onTap: () {
                                    debugPrint(
                                        '${categories[index * 2]['title']}');
                                    Navigator.of(context).push(
                                      SlideRoute(
                                        screen: ProductsScreen(
                                          subcategories: categories[index * 2]
                                              ['subcategories'],
                                          category: categories[index * 2]
                                              ['title'],
                                        ),
                                        duration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    );
                                  },
                                  child: CategoryTileWidget(
                                    category: categories[index * 2],
                                  )),
                            ),
                            if (index * 2 + 1 < categories.length)
                              AspectRatio(
                                aspectRatio: 1,
                                child: GestureDetector(
                                    onTap: () {
                                      debugPrint(
                                          '${categories[index * 2 + 1]['title']}');
                                      Navigator.of(context).push(
                                        SlideRoute(
                                          screen: ProductsScreen(
                                            subcategories:
                                                categories[index * 2 + 1]
                                                    ['subcategories'],
                                            category: categories[index * 2 + 1]
                                                ['title'],
                                          ),
                                          duration:
                                              const Duration(milliseconds: 500),
                                        ),
                                      );
                                    },
                                    child: CategoryTileWidget(
                                      category: categories[index * 2 + 1],
                                    )),
                              ),
                          ],
                        ),
                      ),
                    ));
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.translate('gallery'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      SlideRoute(
                        screen: const GalleryScreen(),
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Text(
                    localizations.translate('seeall'),
                    style: const TextStyle(fontSize: 14, color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: galleryPhotos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Stack(
                      children: <Widget>[
                        CachedNetworkImage(
                            imageUrl: galleryPhotos[index]['imagePath'],
                            width: MediaQuery.of(context).size.width * 0.5,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(
                                  Icons.photo,
                                  color: grayColor,
                                ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              localizations.translate('offers'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: offers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Stack(
                      children: <Widget>[
                        CachedNetworkImage(
                            imageUrl: offers[index]['imagePath'],
                            width: MediaQuery.of(context).size.width * 0.8,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(
                                  Icons.photo,
                                  color: grayColor,
                                ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              localizations.translate('clients'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: partners.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                  imageUrl: partners[index]['logoPath'],
                                  width: 60,
                                  height: 60,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.photo,
                                    color: grayColor,
                                  ),
                                ))),
                      ),
                      Text(
                        partners[index]['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              localizations.translate('vendors'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: vendors.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                  imageUrl: vendors[index]['logoPath'],
                                  width: 60,
                                  height: 60,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.photo,
                                    size: 60,
                                    color: grayColor,
                                  ),
                                ))),
                      ),
                      Text(
                        vendors[index]['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              localizations.translate('featuredproducts'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductTileWidget(
                product: product,
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      )),
    );
  }
}
