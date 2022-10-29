import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/ui/custom_image.dart';
import 'package:test_provider/ui/search/taps/service_tap.dart';
import 'package:test_provider/ui/search/taps/shop_tap.dart';

import '../../provider/login_controller.dart';
import '../category_item.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.token, required this.search})
      : super(key: key);
  String token;
  String search;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
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
      ShopTap(token: token, search:widget.search,),
      ServicesTap(token: token, search:widget.search,),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:  Icon(Icons.arrow_back,color:Colors.blueGrey.shade400,),onPressed: (){
          Navigator.of(context).pop();
        },),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Result',style: GoogleFonts.acme(
          color: Colors.blueGrey.shade400,
          fontSize: 28,
          fontWeight: FontWeight.w500
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              children: [
                const SizedBox(height: 20,),
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


