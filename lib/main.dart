import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: MyPropertiesScreen(),
    );
  }
}

class MyPropertiesScreen extends StatelessWidget {
  final List<Property> properties = sampleProperties;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Properties',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/ic_back.svg",
            width: 15,
            height: 15,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: properties.length,
        itemBuilder: (context, index) {
          return PropertyCard(property: properties[index]);
        },
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Property property;

  PropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/image_demo.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                  top: 15,
                  left: 15,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text('${property.dateListed}', style: const TextStyle(color: Colors.black, fontSize: 12)),
                  )),
              Positioned(
                top: 10,
                right: 10,
                child: PopupMenuButton<String>(
                  icon: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: SvgPicture.asset(
                      "assets/ic_more.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  offset: const Offset(0, 50),
                  onSelected: (value) {
                    if (value == 'Edit Propety') {
                      // Handle edit action
                      print('Edit ${property.address}');
                    } else if (value == 'Delete Propety') {
                      // Handle delete action
                      print('Delete ${property.address}');
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Edit Propety', 'Delete Propety'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('${property.price.toCurrency(removeTrailingZero: true)}',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  Spacer(),
                  if (property.status.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text('${property.status}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                    )
                ],
              ),
              if (property.status.isEmpty) const SizedBox(height: 7),
              Text(
                property.address,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  SvgPicture.asset("assets/ic_bed.svg"),
                  const SizedBox(width: 4),
                  Text('${property.bedrooms}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(width: 15),
                  SvgPicture.asset("assets/ic_bathtub.svg"),
                  const SizedBox(width: 4),
                  Text('${property.bathrooms}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(width: 15),
                  SvgPicture.asset("assets/ic_sqf.svg"),
                  const SizedBox(width: 4),
                  Text('${property.size.toCommaSeparated(removeTrailingZero: true)} Sqft',
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(width: 15),
                  SvgPicture.asset("assets/ic_buiding.svg"),
                  const SizedBox(width: 4),
                  Text('${property.type}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Property {
  final String id;
  final String address;
  final double price;
  final int bedrooms;
  final int bathrooms;
  final double size;
  final String status;
  final String type;
  final String dateListed;

  Property({
    required this.id,
    required this.address,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.size,
    required this.type,
    required this.status,
    required this.dateListed,
  });
}

List<Property> sampleProperties = [
  Property(
    id: '1',
    address: '123 Dedap Link',
    price: 122387,
    bedrooms: 4,
    bathrooms: 3,
    size: 3258,
    status: 'Reserved',
    type: "Landed",
    dateListed: '1 day ago',
  ),
  Property(
    id: '2',
    address: '456 Another St',
    price: 150000,
    bedrooms: 5,
    bathrooms: 4,
    size: 4000,
    status: '',
    type: "Landed",
    dateListed: '1 day ago',
  ),
  Property(
    id: '3',
    address: '456 Another St',
    price: 150000,
    bedrooms: 5,
    bathrooms: 4,
    size: 4000,
    status: '',
    type: "Landed",
    dateListed: '1 day ago',
  ),
];

extension NumberFormatting on num {
  /// Format number with comma grouping (e.g., 1,234,567)
  String toCommaSeparated({bool removeTrailingZero = false}) {
    String result = NumberFormat('#,###.##').format(this);
    return removeTrailingZero && result.endsWith('.00') ? result.replaceAll('.00', '') : result;
  }

  /// Format number as currency with a specific locale and symbol
  String toCurrency({String locale = 'en_US', String symbol = '\$', bool removeTrailingZero = false}) {
    String result = NumberFormat.currency(locale: locale, symbol: symbol).format(this);
    return removeTrailingZero && result.endsWith('.00') ? result.replaceAll('.00', '') : result;
  }

  /// Format number to a fixed number of decimal places and remove `.00` if needed
  String toFixedDecimal({int decimalPlaces = 2, bool removeTrailingZero = false}) {
    String pattern = '0.${'0' * decimalPlaces}';
    String result = NumberFormat(pattern).format(this);
    return removeTrailingZero && result.endsWith('.00') ? result.replaceAll('.00', '') : result;
  }

  /// Add leading zeros (e.g., 007)
  String toPadded({int totalDigits = 3}) {
    return toInt().toString().padLeft(totalDigits, '0');
  }
}
