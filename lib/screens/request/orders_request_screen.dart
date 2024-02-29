import 'package:decoar/helpers/translate_number_helper.dart';
import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersRequestScreen extends StatefulWidget {
  const OrdersRequestScreen({Key? key}) : super(key: key);

  @override
  _OrdersRequestScreenState createState() => _OrdersRequestScreenState();
}

class _OrdersRequestScreenState extends State<OrdersRequestScreen> {
  final List _requests = [
    {
      "id": '1',
      "title": 'كراسي جديدة',
      "description": 'طلب 20 كرسي مريح جديد للمكتب.',
      "date": DateTime.now(),
      "status": 'Delivered',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          localizations!.translate('requests'),
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
      body: ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          final request = _requests[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      request['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: grayColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${localizations.translate('status')}: ${request['status']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: request['status'] == 'Delivered'
                                ? greenColor
                                : request['status'] == 'Cancelled'
                                    ? redColor
                                    : grayColor,
                          ),
                        ),
                        Text(
                          '${translateNumberToArabic(request['date'].day)}/${translateNumberToArabic(request['date'].month)}/${translateNumberToArabic(request['date'].year)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: grayColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
