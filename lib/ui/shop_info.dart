import 'dart:developer';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider.dart';
import 'package:test_provider/ui/product_review.dart';
import 'package:test_provider/ui/services_in_shop.dart';
import 'package:test_provider/ui/shop_ui/add_review/add_review.dart';
import 'package:test_provider/ui/sli.dart';

import 'package:url_launcher/url_launcher.dart';

import '../component/banner_slider_model.dart';
import '../component/cache_image_network.dart';
import '../config/constant.dart';
import '../model/reusable_widget.dart';
import 'menu/design_course_app_theme.dart';

class ShopInfo extends StatefulWidget {
  ShopInfo({Key? key, required this.id, required this.token})
      : super(key: key);
  String id;
  String token;

  @override
  _ShopInfoState createState() => _ShopInfoState();
}

class _ShopInfoState extends State<ShopInfo>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  final _reusableWidget = ReusableWidget();
  String review = '';
  GlobalKey<FormState> formKey = GlobalKey();
  bool slider=false;

  final AppinioSwiperController controller = AppinioSwiperController();

  List<Widget> cards = [];

  void _swipe(int index, AppinioSwiperDirection direction) {
    log("the card was swiped to the: " + direction.name);
  }

  void _unswipe(bool unswiped) {
    if (unswiped) {
      log("SUCCESS: card was unswiped");
    } else {
      log("FAIL: no card left to unswipe");
    }
  }



  @override
  void initState() {

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(seconds: 3));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(seconds: 3));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(seconds: 3));
    setState(() {
      opacity3 = 1.0;
    });
  }


  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);

    return Consumer<ProviderController>(builder: (context, value, child) {
      return FutureBuilder(
          future: value.getSelectedShops(widget.id, widget.token),
          builder: (context, snapshot) {
            if (snapshot.hasData && value.selectedShops.isNotEmpty) {
              final map = snapshot.data as Map;
           map['gallery'].forEach((value) {
             cards.add(Image.network(value));
           });
              return Container(
                color: DesignCourseAppTheme.nearlyWhite,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Stack(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1.6,
                              child: Image.network(
                                map['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 200),
                              decoration: BoxDecoration(
                                color: DesignCourseAppTheme.nearlyWhite,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(32.0),
                                    topRight: Radius.circular(32.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: DesignCourseAppTheme.grey
                                          .withOpacity(0.2),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8,top: 0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 6),
                                        child: Card(
                                          elevation: 0,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 184,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: const [
                                                      Icon(Icons
                                                          .info_outline_rounded),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        'Preferred Merchants',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(children: [
                                                  Container(
                                                    width: 120,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              map['image'])),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 16),
                                                          child: Text(map['name'],
                                                              style: const TextStyle(
                                                                  fontSize: 21,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Container(
                                                          margin: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 16),
                                                          child: Text(
                                                            map['category'],
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        Container(
                                                          margin: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 16),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .orange,
                                                                  size: 22),
                                                              const SizedBox(
                                                                  width: 2),
                                                              Text(
                                                                "${map['rate']['rate']}", style: const TextStyle(
                                                                  fontSize:
                                                                  18),
                                                              ),
                                                              const SizedBox(
                                                                  width: 6),
                                                              map['is_fav']
                                                                  ? const Icon(
                                                                      Icons
                                                                          .favorite_rounded,
                                                                      size: 18,
                                                                    )
                                                                  : const Icon(
                                                                      Icons
                                                                          .favorite_border_rounded,
                                                                      size: 18),
                                                              const SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                "${map['fav']}",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Card(
                                                    elevation: 5,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12)),
                                                    child: IconButton(
                                                      icon: Icon(
                                                        FontAwesomeIcons.phone,
                                                        color:
                                                            Colors.grey.shade700,
                                                      ),
                                                      onPressed: () {
                                                        launchUrl(Uri.parse(
                                                            'tel:/${map['phone']}'));
                                                      },
                                                    ),
                                                  )
                                                ]),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            bottom: 8,),
                                        child: Row(
                                          children:  [
                                            const Icon(Icons.local_offer_outlined,
                                                color: ASSENT_COLOR, size: 16),
                                            const  SizedBox(width: 4),
                                            const  Text('Check for available coupons'),
                                            const Spacer(),
                                            TextButton(
                                              child:const Text('See Coupons',),onPressed: (){},
                                            ),
                                          ],
                                        ),
                                      ),
                                      FutureBuilder(
                                          future: value.getServicesInShop(
                                              widget.id, widget.token),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final list1 = snapshot.data as List;
                                              return Column(
                                                children: [
                                                  Card(
                                                    elevation: 0,
                                                    color: Colors.white,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(30))),
                                                    child: Container(
                                                      padding: const EdgeInsets.fromLTRB(
                                                          8, 0, 8, 6),
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
                                                          Text(' Services',
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: 23,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Colors.grey.shade600)),
                                                          Expanded(child: Container()),
                                                          GestureDetector(
                                                            onTap: () {

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
                                                                      ServiceInfoInShop(
                                                                        shopId: map['id'],
                                                                        token: widget.token,
                                                                        serviceId: list1[index]
                                                                        ['id'],
                                                                      )));
                                                        },
                                                        child: Card(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(10),
                                                            ),
                                                            elevation: 2,
                                                            color: Colors.white,
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
                                                                        url: list1[index]['image'])),
                                                                Expanded(
                                                                  child: Container(
                                                                    margin:
                                                                    const EdgeInsets.all(10),
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                            '${list1[index]['name']}',
                                                                            style: const TextStyle(
                                                                                fontSize: 11,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .bold)),
                                                                        const SizedBox(height: 4),
                                                                        Text(
                                                                            '${list1[index]['rate']} Rate',
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
                                              return const CircularProgressIndicator();
                                            }
                                          }),
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text('Gallery',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold)),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: const Text('view all',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.bold,
                                                          color: PRIMARY_COLOR),
                                                      textAlign: TextAlign.end),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(top: 16),
                                              height: boxImageSize * 1.15,
                                              child: ListView.builder(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                scrollDirection: Axis.horizontal,
                                                itemCount:
                                                map['gallery'].length,
                                                itemBuilder:
                                                    (BuildContext context, int index) {
                                                  return SizedBox(
                                                    width: boxImageSize + 10,
                                                    child: Card(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(10),
                                                      ),
                                                      elevation: 2,
                                                      color: Colors.white,
                                                      child: GestureDetector(
                                                        behavior: HitTestBehavior.translucent,
                                                        onTap: () {
                                                          setState(() {
                                                            slider=true;
                                                          });
                                                        },
                                                        child: Column(
                                                          children: <Widget>[
                                                            ClipRRect(
                                                                borderRadius:
                                                                const BorderRadius.only(
                                                                    topLeft:
                                                                    Radius.circular(
                                                                        10),
                                                                    topRight:
                                                                    Radius.circular(
                                                                        10)),
                                                                child: buildCacheNetworkImage(
                                                                    width: boxImageSize + 10,
                                                                    height: boxImageSize + 10,
                                                                    url: value.selectedShops[
                                                                    'gallery'][index])),
                                                            // Container(
                                                            //   margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                                            //   child: Column(
                                                            //     mainAxisAlignment: MainAxisAlignment.start,
                                                            //     crossAxisAlignment: CrossAxisAlignment.start,
                                                            //     children: [
                                                            //       Container(
                                                            //         margin: const EdgeInsets.only(top:5),
                                                            //       ),
                                                            //       Container(
                                                            //         margin: const EdgeInsets.only(top:5),
                                                            //       )
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )),
                                        ],
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 12),
                                          padding: const EdgeInsets.all(16),
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                const EdgeInsets.fromLTRB(5, 16, 5, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Review',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold)),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                const ProductReviewPage()));
                                                      },
                                                      child: const Text('view all',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.bold,
                                                              color: PRIMARY_COLOR),
                                                          textAlign: TextAlign.end),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              value.selectedShops['reviews'].isNotEmpty
                                                  ? Column(
                                                  children: List.generate(
                                                      value.selectedShops['reviews']
                                                          .length<2?1:2, (index) {
                                                    return Column(
                                                      children: [
                                                        Divider(
                                                          height: 20,
                                                          color: Colors.grey[400],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                value.selectedShops[
                                                                'reviews'][index]
                                                                ['date'],
                                                                style: const TextStyle(
                                                                    fontSize: 13,
                                                                    color: SOFT_GREY)),
                                                            const SizedBox(height: 4),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Text(
                                                                    value.selectedShops[
                                                                    'reviews']
                                                                    [index]['user'],
                                                                    style: const TextStyle(
                                                                        fontSize: 14,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                                _reusableWidget.createRatingBar(
                                                                    rating: double.parse(
                                                                        '${value.selectedShops['reviews'][index]['rate']}'),
                                                                    size: 12),
                                                              ],
                                                            ),
                                                            const SizedBox(height: 4),
                                                            Text(value.selectedShops[
                                                            'reviews'][index]['review'])
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  }))
                                                  : Container(),

                                            ],
                                          )),
                                      AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity: opacity3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, bottom: 16, right: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[

                                              Expanded(
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                RateScreen(
                                                                  shopId: widget.id,
                                                                  token: widget.token, what: true,
                                                                )));
                                                  },
                                                  child: Container(
                                                    height: 48,
                                                    decoration: BoxDecoration(
                                                      color: DesignCourseAppTheme
                                                          .nearlyBlue,
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                        Radius.circular(16.0),
                                                      ),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                            color:
                                                                DesignCourseAppTheme
                                                                    .nearlyBlue
                                                                    .withOpacity(
                                                                        0.5),
                                                            offset: const Offset(
                                                                1.1, 1.1),
                                                            blurRadius: 10.0),
                                                      ],
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Add Review',
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18,
                                                          letterSpacing: 0.0,
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .nearlyWhite,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).padding.bottom,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: (MediaQuery.of(context).size.width / 1.2) - 170,
                              right: 35,
                              child: ScaleTransition(
                                alignment: Alignment.center,
                                scale: CurvedAnimation(
                                    parent: animationController!,
                                    curve: Curves.fastOutSlowIn),
                                child: Card(
                                  color: DesignCourseAppTheme.nearlyBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0)),
                                  elevation: 10.0,
                                  child: const SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Center(
                                      child: Icon(
                                        Icons.favorite,
                                        color: DesignCourseAppTheme.nearlyWhite,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top),
                              child: SizedBox(
                                width: AppBar().preferredSize.height,
                                height: AppBar().preferredSize.height,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(
                                        AppBar().preferredSize.height),
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: DesignCourseAppTheme.nearlyBlack,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      slider? CupertinoPageScaffold(
                        backgroundColor: Colors.grey.withOpacity(0.8),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: AppinioSwiper(
                                unlimitedUnswipe: true,
                                controller: controller,
                                unswipe: _unswipe,
                                cards: cards,
                                onSwipe: _swipe,
                                padding: const EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                  top: 50,
                                  bottom: 40,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 80,
                                ),
                                swipeLeftButton(controller,context),
                                const SizedBox(
                                  width: 20,
                                ),
                                swipeRightButton(controller),
                                const SizedBox(
                                  width: 20,
                                ),
                                unswipeButton(controller),
                              ],
                            )
                          ],
                        ),
                      ):Container(),
                    ],
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          });
    });
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//swipe card to the right side
  Widget swipeRightButton(AppinioSwiperController controller) {
    return ExampleButton(
      onTap: () => controller.swipeRight(),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: CupertinoColors.activeGreen,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.activeGreen.withOpacity(0.9),
              spreadRadius: -10,
              blurRadius: 20,
              offset: const Offset(0, 20), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.check,
          color: CupertinoColors.white,
          size: 40,
        ),
      ),
    );
  }

//swipe card to the left side
  Widget swipeLeftButton(AppinioSwiperController controller, BuildContext context) {
    return ExampleButton(
      onTap: () {
      setState(() {
        slider=false;
      });
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFFF3868),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF3868).withOpacity(0.9),
              spreadRadius: -10,
              blurRadius: 20,
              offset: const Offset(0, 20), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.close,
          color: CupertinoColors.white,
          size: 40,
        ),
      ),
    );
  }

//unswipe card
  Widget unswipeButton(AppinioSwiperController controller) {
    return ExampleButton(
      onTap: () => controller.unswipe(),
      child: Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: const Icon(
          Icons.rotate_left_rounded,
          color: CupertinoColors.systemGrey2,
          size: 40,
        ),
      ),
    );
  }
}
