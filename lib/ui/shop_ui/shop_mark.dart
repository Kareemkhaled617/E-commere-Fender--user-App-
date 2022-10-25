import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider.dart';

import '../../component/custom_button.dart';
import '../../component/custom_shape.dart';
import '../../component/to_map.dart';
import '../home/first.dart';

class ShopMark extends StatefulWidget {
  ShopMark({Key? key, required this.lat, required this.long}) : super(key: key);
  double lat;
  double long;

  @override
  State<ShopMark> createState() => _ShopMarkState();
}

class _ShopMarkState extends State<ShopMark> {
  final MapController mapController = MapController();
  Timer? timer;
  final PopupController _popupController = PopupController();
  List<Marker> mark = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
            controller: mapController,
            plugins: [
              MarkerClusterPlugin(),
            ],
            onTap: (k, l) => _popupController.hideAllPopups(),
            // center: LatLng(x.lat!, x.long!),
            center: LatLng(widget.lat, widget.long),
            zoom: 18.0,
            interactiveFlags: InteractiveFlag.drag |
                InteractiveFlag.pinchMove |
                InteractiveFlag.pinchZoom),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
            MarkerLayerOptions(markers: [
              Marker(
                width: 50,
                height: 50,
                point: LatLng(widget.lat
                   , widget.long),
                builder: (context) => CustomPaint(
                  size: const Size(150, 110),
                  painter: RPSCustomPainter(
                      color: Colors.red),
                ),
              )
            ]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
              Icons.location_on_rounded,
              size: 25,
              color: Colors.red),
        onPressed: (){
        MapUtils.map(
            widget.lat,
            widget.long);
      },),
    );
  }
}
