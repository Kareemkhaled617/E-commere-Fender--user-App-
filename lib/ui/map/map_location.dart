import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider.dart';
import 'package:test_provider/ui/home_services.dart';

import '../../component/custom_button.dart';
import '../home/first.dart';

class MapLocation extends StatefulWidget {
  const MapLocation({Key? key}) : super(key: key);

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  MapController mapController = MapController();
  Timer? timer;
  final PopupController _popupController = PopupController();
  List<Marker> mark = [];

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProviderController>(context);
    return Scaffold(
      body: Stack(
        children: [
          Consumer<ProviderController>(
            builder: (context, value, child) {
              return FlutterMap(
                options: MapOptions(
                  controller: mapController,
                  onMapCreated: (c) {
                    mapController = c;
                  },
                  onPointerHover: (xx, y) {
                    value.change(y.latitude, y.longitude);
                    value.savaAddress(y.latitude, y.longitude);
                    value.getAddressInfo(y.latitude, y.longitude);
                  },
                  plugins: [
                    MarkerClusterPlugin(),
                  ],
                  center: LatLng(value.lat!, value.long!),
                  maxZoom: 16,
                  minZoom: 10,
                  zoom: 20,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerClusterLayerOptions(
                    maxClusterRadius: 120,
                    disableClusteringAtZoom: 6,
                    size: const Size(40, 40),
                    anchor: AnchorPos.align(AnchorAlign.center),
                    fitBoundsOptions: const FitBoundsOptions(
                      padding: EdgeInsets.all(50),
                    ),
                    markers: [
                      Marker(
                        width: 50,
                        height: 50,
                        point: LatLng(value.lat!, value.long!),
                        builder: (ctx) => const Icon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.redAccent,
                          size: 35.0,
                        ),
                      )
                    ],
                    polygonOptions: const PolygonOptions(
                        borderColor: Colors.blueAccent,
                        color: Colors.black12,
                        borderStrokeWidth: 3),
                    popupOptions: PopupOptions(
                        popupSnap: PopupSnap.markerTop,
                        popupController: _popupController,
                        popupBuilder: (_, marker) => GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: 300,
                                child: const Text(
                                  '',
                                  maxLines: 3,
                                ),
                              ),
                            )),
                    builder: (context, markers) {
                      return FloatingActionButton(
                        onPressed: () {},
                        child: Text(markers.length.toString()),
                      );
                    },
                  ),
                  // MarkerLayerOptions(markers: mark),
                ],
              );
            },
          ),
          Selector<ProviderController, String>(
              builder: (context, value, child) {
                return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 30,
                      height: 230.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // dialog top
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: const Text(
                                    '           Location',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // dialog centre
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: false,
                                contentPadding: const EdgeInsets.only(
                                    left: 10.0,
                                    top: 10.0,
                                    bottom: 10.0,
                                    right: 10.0),
                                hintText: value,
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),

                          // dialog bottom
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomeServices()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF33b17c),
                                  borderRadius: BorderRadius.circular(20)),
                              height: 60,
                              child: const Center(
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              },
              selector: (context, pro) => pro.address),
          Positioned(
              bottom: 250,
              right: 10,
              child: FloatingActionButton(
                onPressed: () async {
                  pro.getCurrentLocation().whenComplete(() {
                    mapController.move(LatLng(pro.lat!, pro.long!), 13);
                  });
                },
                backgroundColor: Colors.white,
                child: const Icon(
                  FontAwesomeIcons.locationPin,
                  color: Colors.red,
                ),
              )),
        ],
      ),
    );
  }
}
