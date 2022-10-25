import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/login_controller.dart';

import '../../component/color.dart';
import '../../component/custom_shape.dart';
import '../../provider/map_provider.dart';
import '../home/first.dart';
import '../recommend_item.dart';
import '../shop_ui/shop.dart';

class MapPage extends StatelessWidget {
  MapPage({Key? key, required this.lat, required this.long}) : super(key: key);
  final _pageController=PageController();

  double lat;
  double long;
  MapController mapController = MapController();
  Timer? timer;
  List<Marker> mark = [];

  @override
  Widget build(BuildContext context) {
    var x = Provider.of<ProviderState>(context);

    if (mark.isNotEmpty) {
      mark.clear();
      for (var element in x.sliderData) {
        mark.add(Marker(
          width: 50,
          height: 50,
          point: LatLng(
              double.parse(element['lat']), double.parse(element['long'])),
          builder: (context) => InkWell(
            onTap: () {
              // _pageController.animateTo(3, duration: const Duration(seconds: 2), curve: Curves.bounceOut,);
              context.read<LoginController>().getDataUser().whenComplete(() {
                String tok =
                    context.read<LoginController>().userData['token'] ?? "";
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Shop(
                          id: element['id'],
                          token: tok,
                        )));
              });
            },
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(150, 110),
                  painter: RPSCustomPainter(
                      color: HexColor.fromHex(element['color'])),
                ),
                Positioned(
                  right: 16,
                  top: 5,
                  child: Icon(
                    IconDataSolid(int.parse(element['icon_name'])),
                    color: Colors.white,
                    size: 22.0,
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    } else {
      x.sliderData.forEach((element) {
        mark.add(Marker(
          width: 50,
          height: 50,
          point: LatLng(
              double.parse(element['lat']), double.parse(element['long'])),
          builder: (context) => InkWell(
            onTap: () {
              // _pageController.animateTo(3, duration: const Duration(seconds: 2), curve: Curves.bounceOut,);
              context.read<LoginController>().getDataUser().whenComplete(() {
                String tok =
                    context.read<LoginController>().userData['token'] ?? "";
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Shop(
                          id: element['id'],
                          token: tok,
                        )));
              });
            },
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(150, 110),
                  painter: RPSCustomPainter(
                      color: HexColor.fromHex(element['color'])),
                ),
                Positioned(
                  right: 16,
                  top: 5,
                  child: Icon(
                    IconDataSolid(int.parse(element['icon_name'])),
                    color: Colors.grey,
                    size: 22.0,
                  ),
                ),
              ],
            ),
          ),
        ));
      });
    }
    mark.add(Marker(
      width: 50,
      height: 50,
      point: LatLng(lat, long),
      builder: (ctx) => const Icon(
        FontAwesomeIcons.locationDot,
        color: Colors.redAccent,
        size: 35.0,
      ),
    ));
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            key: ValueKey(MediaQuery.of(context).orientation),
            options: MapOptions(
                controller: mapController,
                onMapCreated: (c) {
                  mapController = c;
                },
                maxZoom: 18,
                minZoom: 10,
                zoom: 15,
                onPositionChanged: (center, val) {
                  print("North : " '${center.bounds!.north}');
                  print("Center : " '${center.bounds!.center}');
                  print("South : " '${center.bounds!.south}');
                  print("East : " '${center.bounds!.east}');
                  print("NorthEast : " '${center.bounds!.northEast}');
                  print("SouthWest : " '${center.bounds!.southWest}');
                  print("zoom : " '${center.zoom}');
                  timer?.cancel();
                  timer = Timer(const Duration(milliseconds: 50), () {
                    x.getSliderData(
                        '0', center.center!.latitude, center.center!.longitude);
                    x.change(center.center!.latitude, center.center!.longitude);
                  });
                },
                plugins: [
                  MarkerClusterPlugin(),
                  const LocationMarkerPlugin(),
                ],
                center: LatLng(lat, long),
                // center: LatLng(30.4203482, 31.0699247),
                interactiveFlags: InteractiveFlag.drag |
                    InteractiveFlag.pinchMove |
                    InteractiveFlag.pinchZoom),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              // MarkerClusterLayerOptions(
              //   maxClusterRadius: 120,
              //   disableClusteringAtZoom: 6,
              //   size: const Size(40, 40),
              //   anchor: AnchorPos.align(AnchorAlign.center),
              //   fitBoundsOptions: const FitBoundsOptions(
              //     padding: EdgeInsets.all(50),
              //   ),
              //   markers: x.markers,
              //   polygonOptions: const PolygonOptions(
              //       borderColor: Colors.blueAccent,
              //       color: Colors.black12,
              //       borderStrokeWidth: 3),
              //   popupOptions: PopupOptions(
              //       popupSnap: PopupSnap.markerTop,
              //       popupController: _popupController,
              //       popupBuilder: (_, marker) => GestureDetector(
              //             onTap: ()  {
              //             },
              //             child: Container(
              //               width: 300,
              //               height: 200,
              //               color: Colors.white,
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //
              //                 ],
              //               ),
              //             ),
              //           )),
              //   builder: (context, markers) {
              //     return FloatingActionButton(
              //       onPressed: () {
              //         print('///////////////-----------------------**********');
              //       },
              //       child: Text(markers.length.toString()),
              //     );
              //   },
              // ),
              MarkerLayerOptions(markers: mark),
            ],
          ),
          Container(
            height: 240,
            decoration: const BoxDecoration(color: Colors.transparent),
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      elevation: 2,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 26,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        },
                      ),
                    ),
                    Expanded(child: Container()),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      elevation: 2,
                      child: IconButton(
                        icon: const Icon(
                          Icons.search_sharp,
                          size: 26,
                        ),
                        onPressed: () {},
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: IconButton(
                          onPressed: () {
                            x.getData('0');
                            x.getSliderData('0', lat, long);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: 25,
                            color: Colors.black,
                          )),
                    ),
                    Expanded(
                        child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(left: 15),
                            child: ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 15,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: x.category.length,
                              itemBuilder: (context, index) =>
                                  ElevatedButton.icon(
                                onPressed: () {
                                  x.getData(x.category[index]['id']);
                                  // x.getMarkers(
                                  //     x.category[index]['id'], x.lat!, x.long!);
                                  x.getSliderData(
                                      x.category[index]['id'], x.lat!, x.long!);
                                },
                                icon: Icon(
                                  IconDataSolid(
                                    int.parse(x.category[index]['icon_name']),
                                  ),
                                  color: HexColor.fromHex('#3c3f41'),
                                  size: 23,
                                ),
                                label: Text(
                                  x.category[index]['name'],
                                  style: TextStyle(
                                      color: HexColor.fromHex('#3c3f41')),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: const BorderSide(
                                                color: Colors.white)))),
                              ),
                            )))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 140,
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: FutureBuilder(future: context.read<LoginController>().getDataUser(),
              builder: (context,snapshot){
                final map = context.read<LoginController>().userData;
                return buildPageView(x.sliderData,context,map);
              },
              ),

              // ListView.builder(
              //   itemBuilder: (context, index) => Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: GestureDetector(
              //       onTap: () async {
              //         Navigator.of(context).push(MaterialPageRoute(
              //             builder: (context) => shop(
              //                   id: x.sliderData[index]['id'],
              //                 )));
              //       },
              //       child: Container(
              //         decoration: const BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.only(
              //               topLeft: Radius.circular(25),
              //               topRight: Radius.circular(25)),
              //         ),
              //         child: Column(
              //           children: <Widget>[
              //             SizedBox(
              //               width: 290,
              //               height: 190,
              //               child: ClipRRect(
              //                 borderRadius: const BorderRadius.only(
              //                     topLeft: Radius.circular(25),
              //                     topRight: Radius.circular(25)),
              //                 child: Image(
              //                   fit: BoxFit.cover,
              //                   image:
              //                       NetworkImage(x.sliderData[index]['image']),
              //                 ),
              //               ),
              //             ),
              //             Row(
              //               children: [
              //                 Column(
              //                   children: <Widget>[
              //                     Text(
              //                       x.sliderData[index]['name'],
              //                       style: const TextStyle(
              //                           color: Color(0xff6200ee),
              //                           fontSize: 24.0,
              //                           fontWeight: FontWeight.w600),
              //                     ),
              //                     Row(
              //                       children: [
              //                         Text(
              //                           '${x.sliderData[index]['rate']}',
              //                           style: const TextStyle(
              //                               color: Colors.black54,
              //                               fontSize: 18.0,
              //                               fontWeight: FontWeight.w700),
              //                         ),
              //                         const SizedBox(
              //                           width: 10,
              //                         ),
              //                         Row(
              //                           children: [
              //                             SizedBox(
              //                                 height: 30,
              //                                 child: ListView.builder(
              //                                   scrollDirection:
              //                                       Axis.horizontal,
              //                                   shrinkWrap: true,
              //                                   itemCount: x.sliderData[index]
              //                                       ['rate'],
              //                                   itemBuilder: (context, index) =>
              //                                       const Icon(
              //                                     FontAwesomeIcons.solidStar,
              //                                     color: Colors.amber,
              //                                     size: 18.0,
              //                                   ),
              //                                 )),
              //                             SizedBox(
              //                                 height: 30,
              //                                 child: ListView.builder(
              //                                   scrollDirection:
              //                                       Axis.horizontal,
              //                                   shrinkWrap: true,
              //                                   itemCount: -(x.sliderData[index]
              //                                           ['rate']) +
              //                                       5,
              //                                   //  itemCount: 5-int.parse(p.sliderData[index]['rate']),
              //                                   itemBuilder: (context, index) =>
              //                                       const Icon(
              //                                     FontAwesomeIcons.star,
              //                                     color: Colors.amber,
              //                                     size: 18.0,
              //                                   ),
              //                                 )),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   width: 49,
              //                 ),
              //                 InkWell(
              //                   onTap: () {
              //                     mapController.move(LatLng( double.parse(x.sliderData[index]['lat']),
              //                         double.parse(
              //                             x.sliderData[index]['long'])), 17);
              //                     // MapUtils.map(
              //                     //     double.parse(x.sliderData[index]['lat']),
              //                     //     double.parse(
              //                     //         x.sliderData[index]['long']));
              //                   },
              //                   child: const Card(
              //                     color: Colors.white,
              //                     elevation: 0,
              //                     child: Padding(
              //                       padding: EdgeInsets.all(12.0),
              //                       child: Icon(
              //                         FontAwesomeIcons.directions,
              //                         size: 40,
              //                         color: Colors.deepOrange,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             const Text(
              //               "Closed \u00B7 Opens 17:00 Thu",
              //               style: TextStyle(
              //                   color: Colors.black54,
              //                   fontSize: 18.0,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              //   itemCount: x.sliderData.length,
              //   scrollDirection: Axis.horizontal,
              // ),
            ),
          ),
          Positioned(
              bottom: 180,
              right: 5,
              child:Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            elevation: 2,
            child: IconButton(
              icon: const Icon(
                Icons.my_location,
                size: 26,
                color: Colors.blue,
              ),
              onPressed: () {
                x.getCurrentLocation().whenComplete((){
                  mapController.move(LatLng(x.lat!, x.long!), 13);
                });
                // mapController.move(LatLng(lat, long), 13);
              },
            ),
          ))
        ],
      ),
    );
  }

  Widget buildPageView(List sliderData, BuildContext context, Map map){
    return PageView.builder(
        controller:_pageController ,
        itemCount: sliderData.length,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder:(context,index){
          return Container(
            margin: const EdgeInsets.only(right: 15),
            child: RecommendItem(
              data: sliderData[index],
              onTap: () {
                print( map['token']);
                print( map['token']);
                print( map['token']);
                Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context) => Shop(
                      id: sliderData[index]['id'],  token: map['token']??'',
                    )));
              },
              onFavoriteTap: () {},
            ),
          );
        });
  }
}

Widget buildRecommend(List sliderData, BuildContext context, Map map) {
  return SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
        sliderData.length,
        (index) => Container(
          margin: const EdgeInsets.only(right: 15),
          child: RecommendItem(
            data: sliderData[index],
            onTap: () {
              print( map['token']);
              print( map['token']);
              print( map['token']);
              Navigator.of(context)
                  .push(MaterialPageRoute(
                  builder: (context) => Shop(
                    id: sliderData[index]['id'],  token: map['token']??'',
                  )));
            },
            onFavoriteTap: () {},
          ),
        ),
      ),
    ),
  );
}




