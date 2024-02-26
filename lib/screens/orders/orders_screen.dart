import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> orders = [
    {
      'orderNo': '102',
      'date': '22/04/2022',
      'quantity': '01',
      'totalAmount': '40',
      'status': 'Delivered',
    },
    {
      'orderNo': '204',
      'date': '22/04/2022',
      'quantity': '02',
      'totalAmount': '80',
      'status': 'Delivered',
    },
    {
      'orderNo': '205',
      'date': '22/04/2022',
      'quantity': '02',
      'totalAmount': '80',
      'status': 'Cancelled',
    },
    {
      'orderNo': '206',
      'date': '22/04/2022',
      'quantity': '02',
      'totalAmount': '60',
      'status': 'Processing',
    },
  ];
  late TabController _tabController;

  List<Map<String, dynamic>> getOrdersByStatus(String status) {
    return orders.where((order) => order['status'] == status).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          localizations!.translate('myorders'),
          style: TextStyle(
              fontSize: 18,
              color: whiteColor,
              fontFamily: languageProvider.locale.languageCode == 'en'
                  ? 'Tajawal'
                  : 'Cairo'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Align(
            alignment: languageProvider.locale.languageCode == 'en'
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: whiteColor),
                insets: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              labelColor: whiteColor,
              labelStyle: TextStyle(
                  fontSize: 16,
                  color: whiteColor,
                  fontFamily: languageProvider.locale.languageCode == 'en'
                      ? 'Tajawal'
                      : 'Cairo'),
              unselectedLabelColor: accentColor,
              tabs: [
                Tab(text: localizations.translate('delivered')),
                Tab(text: localizations.translate('processing')),
                Tab(text: localizations.translate('cancelled')),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        OrdersList(orders: getOrdersByStatus('Delivered')),
        OrdersList(orders: getOrdersByStatus('Processing')),
        OrdersList(orders: getOrdersByStatus('Cancelled')),
      ]),
    );
  }
}

class OrdersList extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrdersList({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return orders.isEmpty
        ? _buildEmptyOrders(localizations!)
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                color: whitegreyColor,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${localizations!.translate('orderno')} ${order['orderNo']}'),
                          Text(order['date']),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${localizations.translate('quantity')}: ${order['quantity']}'),
                          Text(
                              '${localizations.translate('totalamount')}:  ${order['totalAmount']} ${localizations.translate('sar')}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              localizations.translate('detail'),
                              style: const TextStyle(color: primaryColor),
                            ),
                          ),
                          Text(
                            order['status'],
                            style: TextStyle(
                                color: order['status'] == 'Delivered'
                                    ? greenColor
                                    : order['status'] == 'Cancelled'
                                        ? redColor
                                        : grayColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildEmptyOrders(AppLocalizations localizations) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            size: 100,
            color: primaryColor,
          ),
          Text(
            localizations.translate('anyorderyet'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: blackColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            localizations.translate('everyorder'),
            style: const TextStyle(
              fontSize: 16,
              color: grayColor,
            ),
          ),
        ],
      ),
    );
  }
}
