import 'package:cached_network_image/cached_network_image.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<String> popularSearches = [
    'صفرة',
    'كرسي',
    'مكتب',
  ];
  List products = [
    {
      "name": 'صوفا',
      "image":
          'https://www.homesrus.ae/media/catalog/product/5/1/5121100303411_6_1.jpg?quality=80&bg-color=255,255,255&fit=bounds&height=840&width=840&canvas=840:840',
      "price": 99.99
    },
  ];
  List filteredProducts = [];

  @override
  void initState() {
    super.initState();
    // filteredProducts = products;
    searchController.addListener(() {
      filterProducts();
    });
  }

  void filterProducts() {
    final query = searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        filteredProducts = products
            .where((product) =>
                product['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredProducts = products;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 10,
        leadingWidth: 40,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: localizations!.translate('searchfor'),
            suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: whiteColor,
          ),
          textAlignVertical: TextAlignVertical.center,
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: whiteColor, size: 20),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: const [
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.translate('popularsearches'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: List<Widget>.generate(
                popularSearches.length,
                (int index) {
                  return ActionChip(
                    label: Text(popularSearches[index]),
                    onPressed: () {},
                  );
                },
              ),
            ),
            if (filteredProducts.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Center(
                  child: Icon(
                    Icons.search,
                    size: 60,
                    color: grayColor,
                  ),
                ),
              ),
            if (filteredProducts.isEmpty)
              Center(
                child: Text(
                  localizations.translate('recentsearches'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: grayColor,
                    fontSize: 16,
                  ),
                ),
              ),
            if (filteredProducts.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.4,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return Card(
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: product['image'],
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Text(product['name']),
                          Text('\$${product['price'].toStringAsFixed(2)}'),
                        ],
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
