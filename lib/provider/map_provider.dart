import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:latlong2/latlong.dart';


import '../component/color.dart';
import '../component/custom_container.dart';


class ProviderState with ChangeNotifier {
  List<Marker> markers = [];
  List location = [];
  List category = [];
  List sliderData = [];
  bool search = false;
  bool slider = false;
  bool result = false;
  LocationPermission? val;
  Map addressData = {};
  String address = '';
  double? lat;
  double? long;
  bool end=false;

  void changeState() {
    search = !search;
    notifyListeners();
  }

 Future getData(String id) async {
    String url =
        'https://ibtikarsoft.net/mapapi/categories.php?lang=en&cat=$id';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      if (data.isNotEmpty) {
        category = data;
      }

    } else {
      print("Error");
    }
    notifyListeners();
    return category;

  }

 Future getSliderData(String id, double lat, double long) async {
    String url =
        'https://ibtikarsoft.net/finder/api/user/map_slider.php?lang=ar&lat=$lat&long=$long&cat=$id';
    final res = await http.get(Uri.parse(url));
     print(url);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      sliderData = data;
      print(sliderData);
    } else {
      print("Error");
    }
    notifyListeners();
  }

  getMarkers(String id, double lat, double long) async {
    String url =
        'https://ibtikarsoft.net/mapapi/map_markers.php?lang=ar&lat=$lat&long=$long&cat=$id';
    final res = await http.get(Uri.parse(url)).then((value) {
      if (value.statusCode == 200) {
        var data = json.decode(value.body);
        location = data;
        notifyListeners();
        markers.clear();
        location.forEach((element) {
          markers.add(Marker(
            width: 50,
            height: 50,
            point: LatLng(
                double.parse(element['lat']), double.parse(element['long'])),
            builder: (ctx) => CustomPaint(
              painter: Chevron(),
              child: Icon(
                IconDataSolid(int.parse(element['icon_name'])),
                color: HexColor.fromHex(element['color']),
                size: 25.0,
              ),
            ),
          ));
        });
        markers.add(Marker(
          width: 50,
          height: 50,
          point: LatLng(lat, long),
          builder: (ctx) => const Icon(
            FontAwesomeIcons.locationDot,
            color: Colors.redAccent,
            size: 35.0,
          ),
        ));
        notifyListeners();
      }
    });
  }

  Future<Position?> checkLocation() async {
    Geolocator.checkPermission().then((value) {
      print(value);
      if (value == LocationPermission.denied) {
        Geolocator.requestPermission().then((value) {
          if (value == LocationPermission.denied) {
            print("denied");
          } else if (value == LocationPermission.whileInUse) {
            print('go ');
            val = LocationPermission.whileInUse;
            getCurrentLocation();
            notifyListeners();
          } else {
            // getCurrentLocation();
          }
        });
      } else {
        getCurrentLocation();
      }
    });
    notifyListeners();
    return null;
  }

  Future<Position?> getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position? lastPsition = await Geolocator.getLastKnownPosition();
    print('*------*------------------*************-----------*******--------');
    print(lastPsition?.latitude);
    print(lastPsition?.longitude);
    lat = lastPsition!.latitude;
    long = lastPsition.longitude;
    end=false;

    notifyListeners();
    return lastPsition;

  }
  void endValue(bool val){
    end = val;
    notifyListeners();
  }

  void checkEnternet() async {
    bool result1 = await InternetConnectionChecker().hasConnection;
    if (result1 == true) {
      print('Connection Done');
    } else {
      print('Connection failed');
    }
    result = result1;
    notifyListeners();
  }

  void changeSlider() {
    slider = !slider;
    notifyListeners();
  }

  void change(lat1,long1) {
    lat = lat1;
    long =long1;
    notifyListeners();
  }


  void getAddressInfo(double latAddress, double longAddress) async {
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latAddress&lon=$longAddress&accept-language=eg-Arab';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      Map data = json.decode(res.body);
      if (data.isNotEmpty) {
        addressData = data;

        address = data['display_name'];

      }
    } else {
      print("Error");
    }
    notifyListeners();
  }
}
