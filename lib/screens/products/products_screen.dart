import 'package:decoar/helpers/slide_route.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/screens/search/search_screen.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:decoar/widgets/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  final List subcategories;
  final String category;

  const ProductsScreen({
    Key? key,
    required this.subcategories,
    required this.category,
  }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.subcategories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 140,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: whiteColor, size: 18),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        widget.category,
                        style: TextStyle(
                            fontSize: 18,
                            color: whiteColor,
                            fontFamily:
                                languageProvider.locale.languageCode == 'en'
                                    ? 'Tajawal'
                                    : 'Cairo'),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        _goToSearchScreen(context);
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: localizations!.translate('searchfor'),
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
                      )),
                  Align(
                    alignment: languageProvider.locale.languageCode == 'en'
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      labelStyle: TextStyle(
                          fontSize: 16,
                          color: whiteColor,
                          fontFamily:
                              languageProvider.locale.languageCode == 'en'
                                  ? 'Tajawal'
                                  : 'Cairo'),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: accentColor,
                            width: 4.0,
                          ),
                        ),
                      ),
                      tabs: widget.subcategories
                          .map((subcategory) => Tab(text: subcategory['title']))
                          .toList(),
                    ),
                  ),
                ],
              ))),
      body: TabBarView(
        controller: _tabController,
        children: widget.subcategories.map((subcategory) {
          return ProductsListScreen(products: subcategory['products']);
        }).toList(),
      ),
    );
  }
}

class ProductsListScreen extends StatelessWidget {
  final List products;

  const ProductsListScreen({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
    );
  }
}
