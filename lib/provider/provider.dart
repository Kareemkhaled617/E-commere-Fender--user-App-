import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/cache_image_network.dart';

class ProviderController extends ChangeNotifier {
  double? lat;
  double? long;
  List allServices = [];
  List popServices = [];
  Map servicesInfo = {};
  Map servicesInfoInShop = {};
  List popShops = [];
  List shops = [];
  List<Marker> shopsMarkers = [];
  List category = [];
  List pModule = [];
  List supCategory = [];
  Map selectedShops = {};
  List servicesInShop = [];
  List favShop = [];
  List favServices = [];
  List favProducts = [];
  List homeBanner = [];
  Map addressData = {};
  bool checkLogin = false;
  String address = '';
  LocationPermission? locationPermission;
  bool result = false;
  Locale? lang = const Locale('ar');
  List homeServices = [];
  int? module;
  bool end=false;

  void changeCat(int mod1) {
    module = mod1;
    notifyListeners();
  }
  void endValue(bool val){
    end = val;
    notifyListeners();
  }


  search(double lat, double long, String search, String token) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/shops.php?token=$token&lang=ar&lat=$lat&long=$long&cat=0&search=$search';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      allServices = data;
    } else {
      print("Error get All Services");
    }
    print('getAllServices');
    // notifyListeners();
    return allServices;
  }

  Future checkLocation() async {
    Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.denied) {
        Geolocator.requestPermission().then((value) {
          if (value == LocationPermission.denied) {
          } else if (value == LocationPermission.whileInUse) {
            locationPermission = LocationPermission.whileInUse;
            // getCurrentLocation();
          } else {}
        });
      } else {
        locationPermission = LocationPermission.whileInUse;
        // getCurrentLocation();
      }
    });
    print('Check');
    // notifyListeners();
    return locationPermission;
  }

  Future<Position?> getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position? lastPosition = await Geolocator.getLastKnownPosition();
    lat = lastPosition!.latitude;
    long = lastPosition.longitude;
    print(lat);
    print(long);
    end=false;
    notifyListeners();
    return lastPosition;
  }

  Future checkEnternet() async {
    bool result1 = await InternetConnectionChecker().hasConnection;
    if (result1 == true) {
      print('Connection Done');
      // checkLocation();
    } else {
      print('Connection failed');
    }
    result = result1;
    // notifyListeners();
    return result;
  }

  Future getHomeBanner(
      double lat1, double long1, String token, String cat) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/banners.php?lang=$lang&token=$token&lat=$lat1&long=$long1&cat=$cat&module=$module';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      // data.forEach((element) {
      //   homeBanner.add(
      //     ClipRRect(
      //       borderRadius: const BorderRadius.all(Radius.circular(8)),
      //       child: buildCacheNetworkImage(
      //           url:
      //               element['image'],
      //           width: 300,
      //       ),
      //     ),
      //   );
      // });
      homeBanner = data;
    } else {
      print("Error");
    }
    return homeBanner;
  }

  Future getAllServices(
      double lat1, double long1, String token, String search) async {
    String url =
        'https://ibtikarsoft.net/mapapi/services.php?token=$token&lang=$lang&lat=$lat1&long=$long1&search=$search';
    print('services $url');
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      allServices = data;
    } else {
      print("Error get All Services");
    }
    print('getAllServices');
    // notifyListeners();
    return allServices;
  }

  Future addFav({required String token, required String id}) async {
    String url =
        "https://ibtikarsoft.net/finder/api/user/fav_add.php?token=$token&type=shop&id=$id";
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      print(data);
    } else {
      print("Error get Shops");
    }
    return json.decode(res.body);
  }

  // Future _loadMoreVertical() async {
  //   setState(() {
  //     isLoadingVertical = true;
  //   });
  //
  //   // Add in an artificial delay
  //   await Future.delayed(const Duration(seconds: 2));
  //
  //   verticalData.addAll(
  //       List.generate(increment, (index) => verticalData.length + index));
  //
  //   setState(() {
  //     isLoadingVertical = false;
  //   });
  // }

  Future getShops(String id, double lat1, double long1, String token,
      String search, String page) async {
    // Testing Data
    // lat1=30.0374562;
    // long1=31.2095052;

    String url =
        'https://ibtikarsoft.net/finder/api/user/shops.php?token=$token&lang=$lang&lat=$lat1&long=$long1&cat=$id&module=$module&search=$search&page=$page';
    print(url);
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      data.forEach((element) {
        var isExist = shops.firstWhere(
            (element1) => element1['id'] == element['id'],
            orElse: () => null);
        if(isExist == null){
          shops.addAll(data);
        }
      });


    } else {
      print("Error get Shops");
    }
    return shops;
  }

  getPopShops(
      String id, double lat, double long, String cat, String token) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/shops.php?token=$token&lang=$lang&lat=$lat&long=$long&cat=$cat&pop=1&module=$module';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      popShops = data;
    } else {
      print("Error");
    }
    return popShops;
  }

  getPopServices(String id, double lat, double long, String token) async {
    String url =
        'https://ibtikarsoft.net/mapapi/services.php?token=$token&lang=$lang&lat=$lat&long=$long&pop=$id&module=$module';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      popServices = data;
      // notifyListeners();
      return data;
    } else {
      print("Error");
    }
    print('getPopServices');
    return res;
  }

  Future getSelectedShops(id, String token) async {
    // String url = 'https://ibtikarsoft.net/mapapi/shop.php?lang=ar&shop=$id';
    String url =
        'https://ibtikarsoft.net/finder/api/user/shop.php?lang=$lang&token=$token&shop=$id';

    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      selectedShops = data;
    } else {
      print("Error");
    }

    return selectedShops;
  }

  Future<List> getHomeServices(String token) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/modules.php?lang=ar&token=v4mdo2s8769e';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data.isNotEmpty) {
        homeServices = data;
      }
    } else {
      print("Error");
    }
    return homeServices;
  }

  Future postHomeServicesId(String id, String token) async {
    var vvvv = await http.post(
        Uri.parse(
            'https://ibtikarsoft.net/finder/api/user/modules.php?lang=ar&token=$token'),
        body: {'module': id});
  }

  Future getServicesInShop(id, String token) async {
    String url =
        'https://ibtikarsoft.net/mapapi/services.php?token=$token&lang=$lang&shop=$id';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data.isNotEmpty) {
        servicesInShop = data;
      }
    } else {
      print("Error");
    }
    return servicesInShop;
  }

  Future getFavShop(String token) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/fav_shops.php?lang=$lang&token=$token&module=1&page=1';
    print(url);
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data.isNotEmpty) {
        favShop = data;
      }
    } else {
      print("Error");
    }
    return favShop;
  }

  Future getFavProducts(String token) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/fav_shops.php?lang=$lang&token=$token&module=1&page=1';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data.isNotEmpty) {
        favProducts = data;
      }
    } else {
      print("Error");
    }
    return favProducts;
  }

  Future getFavServices(String token) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/fav_services.php?lang=$lang&token=$token&module=1&page=1';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data.isNotEmpty) {
        favServices = data;
      }
    } else {
      print("Error");
    }
    return favServices;
  }

  Future getServicesInfoInShop(
      String shopId, String token, String servicesID) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/shop_service.php?token=$token&lang=$lang&shop=$shopId&service=$servicesID';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data.isNotEmpty) {
        servicesInfoInShop = data;
      }
    } else {
      print("Error");
    }
    return servicesInfoInShop;
  }

  Future getServicesInfo(id, String token) async {
    String url =
        'https://ibtikarsoft.net/mapapi/service.php?token=$token&lang=$lang&service=$id';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data.isNotEmpty) {
        servicesInfo = data;
      }
    } else {
      print("Error");
    }
    return servicesInfo;
  }

  Future getData(String id) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/map_categories.php?lang=$lang&cat=$id';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data.isNotEmpty) {
        category = data;
      }
    } else {
      print("Error");
    }
    // notifyListeners();
    return category;
  }

  Future getPCategory(String token) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/pcategories.php?lang=$lang&token=$token&module=$module';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);

      pModule = data;
    } else {
      print("Error");
    }
    // notifyListeners();
    return pModule;
  }

  Future getSupData(String id) async {
    String url =
        'https://ibtikarsoft.net/mapapi/categories.php?lang=$lang&cat=$id';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      if (data.isNotEmpty) {
        supCategory = data;
      }
    } else {
      print("Error");
    }
    return supCategory;
  }

  void change(lat1, long1) {
    lat = lat1;
    long = long1;
    notifyListeners();
  }

  void changeLang(Locale locale) {
    lang = locale;
    // notifyListeners();
  }

  void getAddressInfo(double latAddress, double longAddress) async {
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latAddress&lon=$longAddress&accept-language=$lang';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      Map data = json.decode(res.body);
      if (data.isNotEmpty) {
        addressData = data;
        address = data['display_name'];
        savaAddressName(data['display_name']);
      }
    } else {
      print("Error");
    }
    notifyListeners();
  }

  Future savaAddressName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('AddressName', name);
    notifyListeners();
  }

  Future savaAddress(double lat, double long) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('lat', lat);
    prefs.setDouble('long', long);
  }

  Future saveModule(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('module', id);
  }

  Future getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lat = prefs.getDouble('lat');
    long = prefs.getDouble('long');
    module=prefs.getInt('module');
    notifyListeners();
  }

  Future getAddressName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    address = prefs.getString('AddressName') ?? '';
    notifyListeners();
  }

  Future getCheckFirstLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkLogin = prefs.getBool('status') ?? false;
    notifyListeners();
  }

  Future checkFirstLogin(bool vall) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('status', vall);
  }
}
