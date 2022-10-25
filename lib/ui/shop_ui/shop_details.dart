import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../component/banner_slider_model.dart';
import '../../component/cache_image_network.dart';
import '../../config/constant.dart';
import '../../model/reusable_widget.dart';
import '../../provider/provider.dart';
import '../product_review.dart';
import '../services_in_shop.dart';
import 'add_review/add_review.dart';

class ShopDetails extends StatefulWidget {
  ShopDetails({Key? key, required this.id, required this.token})
      : super(key: key);
  String id;
  String token;

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  final List<BannerSliderModel> _bannerData = [
    BannerSliderModel(
        id: 1,
        image:
            'https://eco-beauty.dior.com/dw/image/v2/BDGF_PRD/on/demandware.static/-/Sites-master_dior/default/dw62f926d0/assets/Y0996170/Y0996170_E03_GHC.jpg?sw=715&sh=773&sm=fit&imwidth=800'),
    BannerSliderModel(
        id: 2,
        image:
            'https://www.dior.com/couture/var/dior/storage/images/horizon/fragrance/mens-fragrance/sauvage/01-sauvage-elixir-20213/29604254-2-eng-US/01-sauvage-elixir-20212_1440_1200.jpg'),
    BannerSliderModel(
        id: 3,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_Vm3pJIXUjktAFP3XYbuPYR5hBwOFEvfp5g&usqp=CAU'),
    BannerSliderModel(
        id: 4,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYtkYsJZku4Al12weWQ3kBHSOLTi4AWPWujA&usqp=CAU'),
    BannerSliderModel(
        id: 5,
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0FM_KF_IvO7vVzkBAHdgJsr5S0Z_IN8DKGw&usqp=CAU')
  ];

  final _reusableWidget = ReusableWidget();
  String review = '';
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery.of(context).size.width / 3);
    return Consumer<ProviderController>(builder: (context, value, snapshot) {
      return FutureBuilder(
          future: value.getSelectedShops(widget.id, widget.token),
          builder: (context, snapshot) {
            if (snapshot.hasData && value.selectedShops.isNotEmpty) {
              final map = snapshot.data as Map;
              return Scaffold(
                body: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(map['image'])),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: SizedBox(
                            width: double.infinity,
                            height: 184,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Preferred Merchants',
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              value.addFav(
                                                  token: widget.token,
                                                  id: map['id']);
                                              setState(() {});
                                            },
                                            icon: map['is_fav']
                                                ? const Icon(
                                                    Icons.favorite_rounded)
                                                : const Icon(Icons
                                                    .favorite_border_rounded),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "${map['fav']}",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
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
                                          image: NetworkImage(map['image'])),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(map['name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: const Text(
                                            'Hot, Fresh, Steam',
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  color: Colors.orange,
                                                  size: 15),
                                              const SizedBox(width: 2),
                                              Text(
                                                "${map['rate']['rate']}",
                                              ),
                                              const SizedBox(width: 6),
                                              const Icon(Icons.location_pin,
                                                  color: ASSENT_COLOR,
                                                  size: 15),
                                              const SizedBox(width: 2),
                                              const Text(
                                                '0.7 miles',
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
                                            BorderRadius.circular(12)),
                                    child: IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.phone,
                                        color: Colors.grey.shade700,
                                      ),
                                      onPressed: () {
                                        launchUrl(
                                            Uri.parse('tel:/${map['phone']}'));
                                      },
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Row(
                              children: const [
                                Icon(Icons.local_offer_outlined,
                                    color: ASSENT_COLOR, size: 16),
                                SizedBox(width: 4),
                                Text('Check for available coupons'),
                                Spacer(),
                                Text(
                                  'See Coupons',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildHomeBanner(),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(' Services',
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
                        FutureBuilder(
                            future: value.getServicesInShop(
                                widget.id, widget.token),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final list1 = snapshot.data as List;
                                return GridView.count(
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
                                      value.selectedShops['gallery'].length,
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
                                          onTap: () {},
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
                                                .length, (index) {
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
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30, bottom: 20),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.orangeAccent),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RateScreen(
                                                      shopId: widget.id,
                                                      token: widget.token, what: true,
                                                    )));
                                      },
                                      child: const Text("Add your review"),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          });
    });
  }

  Widget _buildHomeBanner() {
    return CarouselSlider(
      items: _bannerData
          .map((item) => GestureDetector(
              onTap: () {},
              child:
                  buildCacheNetworkImage(width: 0, height: 0, url: item.image)))
          .toList(),
      options: CarouselOptions(
          aspectRatio: 2,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 6),
          autoPlayAnimationDuration: const Duration(milliseconds: 300),
          enlargeCenterPage: false,
          onPageChanged: (index, reason) {}),
    );
  }
}
