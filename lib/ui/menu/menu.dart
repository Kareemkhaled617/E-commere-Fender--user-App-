import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/login_controller.dart';
import 'package:test_provider/provider/provider.dart';
import 'package:test_provider/ui/search/search_page.dart';
import 'package:test_provider/ui/service_info.dart';

import '../../component/cache_image_network.dart';
import '../../config/constant.dart';
import '../../constants.dart';
import '../all_services.dart';
import '../all_shops.dart';
import '../amazing_deals.dart';
import '../category_item.dart';
import '../color.dart';
import '../data.dart';

import '../map/location.dart';
import '../popular_item.dart';
import '../property_item.dart';
import '../recommend_item.dart';
import '../services_in_shop.dart';
import '../shop_ui/shop.dart';
import 'discount_banner.dart';
import 'icon_btn_with_counter.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int selectedCategoryIndex = 0;
  String idCat = '0';
  String search = '';
  bool isLoadingVertical = false;
  int numOfPage = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, val, child) {
        return FutureBuilder(
            future: val.getDataUser(),
            builder: (context, snapshot) {
              final Map m = val.userData;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => screen_location(
                              get: false,
                            )));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 19, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text('  Address',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  size: 26,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 60,
                              width: 300,
                              child: Text(
                                  context.watch<ProviderController>().address,
                                  maxLines: 2,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).splashColor)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PreferredSize(
                      preferredSize: const Size.fromHeight(80),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: kSecondaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(15),
                                        ),
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          search = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 14),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText: "Search product",
                                          prefixIcon: Icon(Icons.search)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconBtnWithCounter(
                                  svgSrc: "assets/icons/Search Icon.svg",
                                  press: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => SearchPage(
                                                  token: m['token'] ?? '',
                                                  search: search,
                                                )));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    buildHeader(),
                    const SizedBox(height: 30),
                    Consumer<ProviderController>(
                        builder: (context, value, child) {
                      return FutureBuilder(
                          future: value.getHomeBanner(
                              value.lat!, value.long!, m['token'] ?? '', idCat),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                value.homeBanner.isNotEmpty) {
                              final list = snapshot.data as List;
                              return CarouselSlider(
                                items: list.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: const BoxDecoration(
                                              color: Colors.amber),
                                          child: GestureDetector(
                                              child: Image.network(i['image']),
                                              onTap: () {
                                                if (i['type'] == 'shop') {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Shop(
                                                                id: '${i['shop']}',
                                                                token:
                                                                    m['token'] ??
                                                                        '',
                                                              )));
                                                } else {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ServiceInfoInShop(
                                                                shopId:
                                                                    '${i['shop']}',
                                                                token:
                                                                    m['token'] ??
                                                                        '',
                                                                serviceId:
                                                                    '${i['service']}',
                                                              )));
                                                }
                                              }));
                                    },
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                    aspectRatio: 3,
                                    viewportFraction: 0.9,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 4),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 300),
                                    autoPlayCurve: Curves.bounceInOut,
                                    enlargeCenterPage: false,
                                    onPageChanged: (index, reason) {}),
                              );
                            } else {
                              return Lottie.network(
                                  'https://assets1.lottiefiles.com/datafiles/dCoEZJcl8sFV0r4/data.json');
                            }
                          });
                    }),

                    const SizedBox(height: 10),
                    const DiscountBanner(),
                    const SizedBox(
                      height: 10,
                    ),

                    Consumer<ProviderController>(
                      builder: (BuildContext context, value, Widget? child) {
                        return FutureBuilder(
                            future: value.getPCategory(m['token'] ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  value.pModule.isNotEmpty) {
                                final list = snapshot.data as List;
                                return SingleChildScrollView(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 7, 10),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      list.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8, left: 8),
                                        child: CategoryItem(
                                          data: list[index],
                                          isSelected:
                                              index == selectedCategoryIndex,
                                          onTap: () {
                                            // value.getData(list[index]['id']);
                                            setState(() {
                                              selectedCategoryIndex = index;
                                              idCat = list[index]['id'];
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Lottie.network(
                                    'https://assets5.lottiefiles.com/packages/lf20_iPPFod.json');
                              }
                            });
                      },
                    ),

                    Consumer<ProviderController>(
                        builder: (context, value, child) {
                      return FutureBuilder(
                          future: value.getPopServices(
                              '0', value.lat!, value.long!, m['token'] ?? ''),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                value.popServices.isNotEmpty) {
                              final map = snapshot.data as List;
                              return Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: Theme.of(context)
                                        .backgroundColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30))),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 16, 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.local_laundry_service,
                                            color: Colors.blueGrey,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text('Popular Services',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey.shade600)),
                                          Expanded(child: Container()),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllServices(
                                                            token: m['token'] ??
                                                                '',
                                                          )));
                                            },
                                            child: const Text('view all',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: PRIMARY_COLOR),
                                                textAlign: TextAlign.end),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GridView.count(
                                    padding: const EdgeInsets.all(12),
                                    primary: false,
                                    childAspectRatio: 4 / 1.6,
                                    shrinkWrap: true,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                    crossAxisCount: 2,
                                    children: List.generate(4, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ServicesDetials(
                                                          id: map[index]['id'],
                                                          token: m['token'] ??
                                                              '')));
                                        },
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 2,
                                            color:Theme.of(context)
                                                .backgroundColor,
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10)),
                                                    child: buildCacheNetworkImage(
                                                        width: (MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    2) *
                                                                (1.6 / 4) -
                                                            12 -
                                                            1,
                                                        height: (MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    2) *
                                                                (1.6 / 4) -
                                                            12 -
                                                            1,
                                                        url: map[index]
                                                            ['image'])),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            '${map[index]['name']}',
                                                            style: const TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                            '${map[index]['rate']} Rate',
                                                            style: const TextStyle(
                                                                fontSize: 9,
                                                                color: Color(
                                                                    0xFF37474f)))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      );
                                    }),
                                  ),
                                ],
                              );
                            } else {
                              return Container(
                                child: Lottie.network(
                                    'https://assets2.lottiefiles.com/packages/lf20_ESYRqy.json'),
                              );
                            }
                          });
                    }),
                    // Stack(
                    //   alignment: Alignment.centerLeft,
                    //   children: [
                    //     Card(
                    //       elevation: 0,
                    //       color: Colors.white,
                    //       shape: const RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.only(topLeft: Radius.circular(30))
                    //       ),
                    //       child: Container(
                    //         padding: const EdgeInsets.fromLTRB(63, 16, 16, 16),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text('   Services ',
                    //                 style: GoogleFonts.roboto(
                    //                     fontSize: 23,
                    //                     fontWeight: FontWeight.w700,
                    //                     color: Colors.grey.shade600
                    //                 )),
                    //             GestureDetector(
                    //               onTap: () {},
                    //               child: const Text('view all',
                    //                   style: TextStyle(
                    //                       fontSize: 13,
                    //                       fontWeight: FontWeight.bold,
                    //                       color: PRIMARY_COLOR),
                    //                   textAlign: TextAlign.end),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     const  Padding(
                    //       padding:  EdgeInsets.symmetric(horizontal: 10),
                    //       child:  CircleAvatar(
                    //         radius: 34,
                    //         backgroundColor: Colors.blueGrey,
                    //         child: Icon(Icons.category,color: Colors.white,),
                    //       ),
                    //     ),
                    //
                    //   ],
                    // ),
                    // const Divider(
                    //   indent: 50,
                    //   endIndent: 20,
                    //   thickness: 2,
                    //   color: Colors.blueGrey,
                    // ),
                    // Selector<ProviderController, Future>(
                    //     selector: (context, pro) =>
                    //         pro.getAllServices(pro.lat!, pro.long!),
                    //     builder: (context, value, child) {
                    //       return FutureBuilder(
                    //           future: value,
                    //           builder: (context, snapshot) {
                    //             if (snapshot.hasData) {
                    //               final map = snapshot.data as List;
                    //               return GridView.count(
                    //                 childAspectRatio: 1.1,
                    //                 primary: false,
                    //                 shrinkWrap: true,
                    //                 crossAxisSpacing: 0,
                    //                 mainAxisSpacing: 0,
                    //                 crossAxisCount: 3,
                    //                 children: List.generate(6, (index) {
                    //                   return GestureDetector(
                    //                       onTap: () {
                    //                         Navigator.of(context).push(
                    //                             MaterialPageRoute(
                    //                                 builder: (context) =>
                    //                                     ServicesDetials(
                    //                                       id: map[index]['id'],
                    //                                     )));
                    //                       },
                    //                       child: Container(
                    //                         decoration: BoxDecoration(
                    //                             border: Border.all(
                    //                                 color: Colors.grey[100]!,
                    //                                 width: 0.5),
                    //                             color: Colors.white),
                    //                         padding: const EdgeInsets.all(8),
                    //                         child: Center(
                    //                             child: Column(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment.center,
                    //                                 children: [
                    //                               buildCacheNetworkImage(
                    //                                   width: 40,
                    //                                   height: 40,
                    //                                   url: map[index]['image'],
                    //                                   plColor: Colors.redAccent),
                    //                               Container(
                    //                                 margin: const EdgeInsets.only(
                    //                                     top: 12),
                    //                                 child: Text(
                    //                                   map[index]['name'],
                    //                                   style: const TextStyle(
                    //                                     color: Colors.black,
                    //                                     fontWeight:
                    //                                         FontWeight.bold,
                    //                                     fontSize: 11,
                    //                                   ),
                    //                                   textAlign: TextAlign.center,
                    //                                 ),
                    //                               )
                    //                             ])),
                    //                       ));
                    //                 }),
                    //               );
                    //             } else {
                    //               return const CircularProgressIndicator();
                    //             }
                    //           });
                    //     }),

                    Consumer<ProviderController>(
                        builder: (context, value, child) {
                      return FutureBuilder(
                          future: value.getShops(idCat, value.lat!, value.long!,
                              m['token'] ?? '', search, '$numOfPage'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && value.shops.isNotEmpty) {
                              final map = snapshot.data as List;
                              return Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: Theme.of(context)
                                        .backgroundColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30))),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 16, 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.shop,
                                            color: Colors.blueGrey,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text('Shops',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey.shade600)),
                                          Expanded(child: Container()),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllShops(
                                                              token:
                                                                  m['token'] ??
                                                                      '')));
                                            },
                                            child: const Text('view all',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: PRIMARY_COLOR),
                                                textAlign: TextAlign.end),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.only(left: 15),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: List.generate(
                                      map.length,
                                      (index) => Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        child: PopularItem(
                                          data: map[index],
                                          onFavoriteTap: () {
                                            value.addFav(
                                                token: m['token'] ?? '',
                                                id: map[index]['id']);
                                            setState(() {});
                                          },
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) => Shop(
                                                          id: map[index]['id'],
                                                          token:
                                                              m['token'] ?? '',
                                                        )));
                                          },
                                        ),
                                      ),
                                    )),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }),

                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 3,
                      color: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(30))),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('AMAZING DEALS !',
                                style: GoogleFonts.roboto(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blueGrey.shade600)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 210,
                      child: MealsListView(),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ProviderController>(
                        builder: (context, value, child) {
                      return FutureBuilder(
                          future: value.getShops(idCat, value.lat!, value.long!,
                              m['token'] ?? '', search, '1'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && value.shops.isNotEmpty) {
                              final map = snapshot.data as List;
                              return Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: Theme.of(context)
                                        .backgroundColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30))),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 16, 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.near_me_rounded,
                                            color: Colors.blueGrey,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text('Shop Around You ',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey.shade600)),
                                          Expanded(child: Container()),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllShops(
                                                            token: m['token'] ??
                                                                '',
                                                          )));
                                            },
                                            child: const Text('view all',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: PRIMARY_COLOR),
                                                textAlign: TextAlign.end),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.only(left: 15),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: List.generate(
                                      map.length,
                                      (index) => Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        child: PopularItem(
                                          data: map[index],
                                          onFavoriteTap: () {
                                            value.addFav(
                                                token: m['token'] ?? '',
                                                id: map[index]['id']);
                                            setState(() {});
                                          },
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) => Shop(
                                                          id: map[index]['id'],
                                                          token:
                                                              m['token'] ?? '',
                                                        )));
                                          },
                                        ),
                                      ),
                                    )),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }),

                    Consumer<ProviderController>(
                      builder: (BuildContext context, value, Widget? child) {
                        return FutureBuilder(
                            future: value.getPopShops(idCat, value.lat!,
                                value.long!, idCat, m['token'] ?? ''),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  value.popShops.isNotEmpty) {
                                final list = snapshot.data as List;
                                return Column(
                                  children: [
                                    Card(
                                      elevation: 0,
                                      color:Theme.of(context)
                                          .backgroundColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30))),
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 16, 16, 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.shop_2,
                                              color: Colors.blueGrey,
                                              size: 30,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text('Popular Shop ',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 23,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        Colors.grey.shade600)),
                                            Expanded(child: Container()),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllShops(
                                                              token:
                                                                  m['token'] ??
                                                                      '',
                                                            )));
                                              },
                                              child: const Text('view all',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: PRIMARY_COLOR),
                                                  textAlign: TextAlign.end),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    CarouselSlider(
                                        options: CarouselOptions(
                                          height: 240,
                                          enlargeCenterPage: true,
                                          disableCenter: true,
                                          viewportFraction: .8,
                                        ),
                                        items: List.generate(
                                            list.length,
                                            (index) => PropertyItem(
                                                  data: list[index],
                                                  token: m['token'] ?? '',
                                                ))),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            });
                      },
                    ),

                    // Consumer<ProviderController>(
                    //     builder: (context, value, child) {
                    //       return FutureBuilder(
                    //           future: value.getAllServices(value.lat!, value.long!,'',''),
                    //           builder: (context, snapshot) {
                    //             if (value.allServices.isNotEmpty) {
                    //               final map = snapshot.data as List;
                    //               return Column(
                    //                 children: [
                    //                   Container(
                    //                     margin:
                    //                     const EdgeInsets.fromLTRB(16, 24, 16, 0),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         const Text('Top',
                    //                             style: TextStyle(
                    //                               fontSize: 20,
                    //                               fontWeight: FontWeight.w800,
                    //                             )),
                    //                         GestureDetector(
                    //                           onTap: () {},
                    //                           child: const Text('View All',
                    //                               style: TextStyle(
                    //                                 fontSize: 13,
                    //                                 fontWeight: FontWeight.bold,
                    //                               )),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                   GridView.builder(
                    //                     primary: false,
                    //                     shrinkWrap: true,
                    //                     itemCount: map.length,
                    //                     gridDelegate:
                    //                     const SliverGridDelegateWithFixedCrossAxisCount(
                    //                         childAspectRatio: 10 / 16,
                    //                         crossAxisCount: 2,
                    //                         mainAxisSpacing: 10,
                    //                         crossAxisSpacing: 10),
                    //                     itemBuilder: (_, index) {
                    //                       return OpenContainerWrapper(
                    //                           data: map[index],
                    //                           child: GridTile(
                    //                             header: Padding(
                    //                               padding: const EdgeInsets.all(10.0),
                    //                               child: Row(
                    //                                 mainAxisAlignment:
                    //                                 MainAxisAlignment
                    //                                     .spaceBetween,
                    //                                 children: [
                    //                                   Visibility(
                    //                                     visible: true,
                    //                                     child: Container(
                    //                                       decoration: BoxDecoration(
                    //                                           borderRadius:
                    //                                           BorderRadius
                    //                                               .circular(30),
                    //                                           color: Colors.white),
                    //                                       width: 80,
                    //                                       height: 30,
                    //                                       alignment: Alignment.center,
                    //                                       child: const Text(
                    //                                         "30% OFF",
                    //                                         style: TextStyle(
                    //                                             fontWeight:
                    //                                             FontWeight.w600),
                    //                                       ),
                    //                                     ),
                    //                                   ),
                    //                                   IconButton(
                    //                                       onPressed: () {
                    //
                    //
                    //                                       },
                    //                                       icon:  const Icon(
                    //                                           Icons.favorite,
                    //                                           color: Colors.red)
                    //
                    //                                   ),
                    //                                   // IconButton(
                    //                                   //   icon: const Icon(
                    //                                   //     Icons.favorite,
                    //                                   //     color: Color(0xFFA6A3A0),
                    //                                   //   ),
                    //                                   //   onPressed: () {
                    //                                   //     context
                    //                                   //         .read<HomeProvider>()
                    //                                   //         .addFav(FavItem(
                    //                                   //             title: map[index]
                    //                                   //                 ['name'],
                    //                                   //             price: 300,image: map[index]['image']));
                    //                                   //   },
                    //                                   // ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                             footer: Padding(
                    //                               padding: const EdgeInsets.all(8.0),
                    //                               child: Container(
                    //                                 padding: const EdgeInsets.all(10),
                    //                                 decoration: const BoxDecoration(
                    //                                   color: Colors.white,
                    //                                   borderRadius: BorderRadius.only(
                    //                                     bottomLeft:
                    //                                     Radius.circular(15),
                    //                                     bottomRight:
                    //                                     Radius.circular(15),
                    //                                   ),
                    //                                 ),
                    //                                 child: Column(
                    //                                   mainAxisAlignment:
                    //                                   MainAxisAlignment.center,
                    //                                   crossAxisAlignment:
                    //                                   CrossAxisAlignment.start,
                    //                                   children: [
                    //                                     FittedBox(
                    //                                       child: Text(
                    //                                         map[index]['name'],
                    //                                         overflow:
                    //                                         TextOverflow.ellipsis,
                    //                                         maxLines: 1,
                    //                                         style: const TextStyle(
                    //                                             fontWeight:
                    //                                             FontWeight.w500,
                    //                                             color: Colors.grey),
                    //                                       ),
                    //                                     ),
                    //                                     const SizedBox(height: 5),
                    //                                     Row(
                    //                                       children: [
                    //                                         Text(
                    //                                           "500",
                    //                                           style: Theme.of(context)
                    //                                               .textTheme
                    //                                               .headline4,
                    //                                         ),
                    //                                         const SizedBox(width: 3),
                    //                                         const Visibility(
                    //                                           visible: true,
                    //                                           child: Text(
                    //                                             "600",
                    //                                             style: TextStyle(
                    //                                               decoration:
                    //                                               TextDecoration
                    //                                                   .lineThrough,
                    //                                               color: Colors.grey,
                    //                                               fontWeight:
                    //                                               FontWeight.w500,
                    //                                             ),
                    //                                           ),
                    //                                         )
                    //                                       ],
                    //                                     )
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             child: Container(
                    //                               padding: const EdgeInsets.all(15),
                    //                               decoration: BoxDecoration(
                    //                                 color: const Color(0xFFE5E6E8),
                    //                                 borderRadius:
                    //                                 BorderRadius.circular(20),
                    //                               ),
                    //                               child: Image.network(
                    //                                 map[index]['image'],
                    //                                 scale: 3,
                    //                               ),
                    //                             ),
                    //                           ));
                    //                     },
                    //                   ),
                    //                 ],
                    //               );
                    //             } else {
                    //               return const CircularProgressIndicator();
                    //             }
                    //           });
                    //     }),

                    Consumer<ProviderController>(
                        builder: (context, value, child) {
                      return FutureBuilder(
                          future: value.getShops(idCat, value.lat!, value.long!,
                              m['token'] ?? '', search, '1'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && value.shops.isNotEmpty) {
                              final list = snapshot.data as List;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: Theme.of(context)
                                        .backgroundColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30))),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 16, 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.shop,
                                            color: Colors.blueGrey,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text('Shops',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey.shade600)),
                                          Expanded(child: Container()),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AllShops(
                                                            token: m['token'] ??
                                                                '',
                                                          )));
                                            },
                                            child: const Text('view all',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: PRIMARY_COLOR),
                                                textAlign: TextAlign.end),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 0, 15),
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      children: List.generate(
                                        list.length,
                                        (index) => Container(
                                          margin: const EdgeInsets.only(
                                              right: 15, bottom: 15, left: 3),
                                          child: RecommendItem(
                                            data: list[index],
                                            onTap: () {},
                                            onFavoriteTap: () {
                                              value.addFav(
                                                  token: m['token'] ?? '',
                                                  id: list[index]['id']);
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }),
                  ],
                ),
              );
            });
      },
    );
  }

  Widget buildCategory() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 5, 7, 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryItem(
              data: categories[index],
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

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text:  TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Stay at home, \nmake your own ',
                  style: TextStyle(
                    height: 1.3,
                    color: Theme.of(context)
                        .primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
                const TextSpan(
                  text: 'food',
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
