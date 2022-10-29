import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/ui/custom_image.dart';
import 'package:test_provider/ui/favorite/taps/service_tap.dart';
import 'package:test_provider/ui/favorite/taps/shop_tap.dart';

import '../../provider/login_controller.dart';
import '../category_item.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int index = 0;
  int selectedCategoryIndex = 0;

  final cat = [
    {
      'name': 'Shop',
      'image':
          'https://ibtikarsoft.net/la2iny_V1/public/app-assets/imgs/search_icons/markets.png',
    },
    {
      'name': 'Services',
      'image':
          'https://ibtikarsoft.net/la2iny_V1/public/app-assets/imgs/search_icons/services.png',
    },
    {
      'name': 'Product',
      'image':
          'https://ibtikarsoft.net/la2iny_V1/public/app-assets/imgs/search_icons/products.png',
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var token = context.read<LoginController>().userData['token'] ?? '';
    final List<Widget> pages = [
      ShopTap(token: token),
      ServicesTap(token: token),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              children: [
            buildCategory(cat),
            IndexedStack(
              index: selectedCategoryIndex,
              children: pages,
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildCategory(List list) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 5, 7, 20),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          list.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryItem(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              data: list[index],
              isSelected: index == selectedCategoryIndex,
              onTap: () {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
