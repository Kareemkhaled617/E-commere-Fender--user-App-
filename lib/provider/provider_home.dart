
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dash/dashboard.dart';
import '../ui/cart/cart_screen.dart';
import '../ui/cart/models/item.dart';
import '../ui/favorite/favorite_screen.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../ui/menu/menu.dart';
import '../ui/home/setting.dart';

class HomeProvider with ChangeNotifier {
  int currentIndex = 0;
  int shopCurrentIndex = 0;
  Locale langu = const Locale('en');

  final List<Item> _items = [];

  double _totalPrice = 0.0;
  List<Sales> dash=[];
  final List<Sales> _smartphoneData = [
    Sales("2014", 5),

  ];

  final List<Sales> _refrigeratorData = [
    Sales("2014", 30),

  ];
  List series=[];


  void add(Item item) {
    _items.add(item);
    _totalPrice += item.price!;
    notifyListeners();
  }



  void remove(Item item) {
    _totalPrice -= item.price!;
    _items.remove(item);
    notifyListeners();
  }

  int get count {
    return _items.length;
  }



  double get totalPrice {
    return _totalPrice;
  }

  List<Item> get basketItems {
    return _items;
  }



  List<Widget> pages = [
    const Menu(),
     const FavoritePage(),
    const CartScreen(),
    const Settings(),
  ];

  void changeNavigateIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }

  void changeShopNavigateIndex(int value) {
    shopCurrentIndex = value;
    notifyListeners();
  }

  String val = 'en';

  Future getDataLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    val = prefs.getString('status') ?? 'en';
    notifyListeners();
    return prefs.getString('status');
  }

  Future saveDataLang(String vall) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('status', vall);
  }

  void changeLang(String lang) {
    langu = Locale(lang);
  }

  Future addReview({required String token,required id,required review,required rate}) async {
    Response res = await post(
        Uri.parse(
            'https://ibtikarsoft.net/finder/api/user/shop_add_review.php?token=$token&shop=$id'),
        body: {
          'review': review,
          "rate": '$rate',
        });
    print(res);

  }
  Future addReviewInServicesShop({required String token,required idShop,required idServices,required review,required rate}) async {
    Response res = await post(
        Uri.parse(
            'https://ibtikarsoft.net/finder/api/user/shop_service_add_review.php?token=$token&shop=$idShop&service=$idServices'),
        body: {
          'review': review,
          "rate": '$rate',
        });
    print(res.body);
  }

  Future getFavServices( ) async {
    String url =
        'https://ibtikarsoft.net/finder/api/admin/reports.php?lang=ar&token=aruv8kzsmyo7';
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      series = data;
      // data.forEach((element) {
      //   series.add(charts.Series(
      //       id: element['name'],
      //       domainFn: (Sales sales, _) => sales.year,
      //       measureFn: (Sales sales, _) => sales.sale,
      //       data: _smartphoneData
      //   ));
      // });

    } else {
      print("Error");
    }
    return series;
  }


}
