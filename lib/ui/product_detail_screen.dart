//
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import '../controller/product_controller.dart';
//
//
//
// class ProductDetailScreen extends StatelessWidget {
//
//   final String id;
//
//   ProductDetailScreen(this.id, {Key? key}) : super(key: key);
//
//   PreferredSizeWidget _appBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       leading: IconButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: const Icon(
//           Icons.arrow_back,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
//   final PageController _pageController = PageController(initialPage: 0);
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: _appBar(context),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: height * 0.42,
//                 width: width,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFE5E6E8),
//                   borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(200),
//                     bottomLeft: Radius.circular(200),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: height * 0.32,
//                       child: PageView.builder(
//                         itemCount: 2,
//                         controller: _pageController,
//                         onPageChanged: (i){},
//                         itemBuilder: (_, index) {
//                           return FittedBox(
//                             fit: BoxFit.none,
//                             child: Image.network(
//                               '',
//                               scale: 3,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     SmoothIndicator(
//                         effect:  const WormEffect(
//                             dotColor: Colors.white,
//                             activeDotColor:Colors.deepOrange),
//                         offset:2.5,
//                         count: 1)
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                      '',
//                       style: Theme.of(context).textTheme.headline2,
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       children: [
//                         RatingBar.builder(
//                             initialRating: 3,
//                             direction: Axis.horizontal,
//                             itemBuilder: (_, index) {
//                               return const Icon(Icons.star, color: Colors.amber);
//                             },
//                             onRatingUpdate: (rating) {}),
//                         const SizedBox(width: 30),
//                         const Text(
//                           "(4500 Reviews)",
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       children: const [
//                         Text(
//                          "{product.price}",
//
//                         ),
//                         SizedBox(width: 3),
//                         Visibility(
//                           visible:  false,
//                           child: Text(
//                             "{product.price}",
//                             style: TextStyle(
//                               decoration: TextDecoration.lineThrough,
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Text(
//                           "Not available",
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 30),
//                     Text(
//                       "About",
//                       style: Theme.of(context).textTheme.headline4,
//                     ),
//                     const SizedBox(height: 10),
//                     const Text('product.about'),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       height: 40,
//                       child: GetBuilder<ProductController>(
//                         builder: (ProductController controller) {
//                           return ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: 3,
//                             itemBuilder: (_, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   // controller.switchBetweenProductSizes(product, index);
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.only(right: 5, left: 5),
//                                   alignment: Alignment.center,
//                                   width: 70,
//                                   decoration: BoxDecoration(
//                                       color:Colors.orange,
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(color: Colors.grey, width: 0.4)),
//                                   child: const FittedBox(
//                                     child: Text(
//                                      'numerical',
//                                       style:
//                                       TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: null,
//                         child: Text("Add to cart"),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider_home.dart';
import 'package:test_provider/ui/cart/models/item.dart';


import '../values/values.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({Key? key,required this.data}) : super(key: key);
  final data;


  final List<SmProduct> smProducts = [
    SmProduct(image: 'assets/images/product-1.png'),
    SmProduct(image: 'assets/images/product-2.png'),
    SmProduct(image: 'assets/images/product-3.png'),
    SmProduct(image: 'assets/images/product-4.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
          Icons.chevron_left,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
            Icons.shopping_bag,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.network(data['image']),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chanel',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${data['name']}',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$135.00',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor consectetur tortor vitae interdum.',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Similar This',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 110,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 6),

                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Image(
                                 fit: BoxFit.cover,
                                  image: NetworkImage(data['image']),
                                ),
                              ),
                            ), separatorBuilder: (BuildContext context, int index)=>SizedBox(width: 6,),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color:AppColors.orange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.orange),
              ),
              child: const Icon(
                Icons.favorite_outline,
                size: 30,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () {
                   context.read<HomeProvider>().add(Item(title: data['name'],image:data['image'] ,price: 150));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '+ Add to Cart',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmProduct {
  String image;
  SmProduct({required this.image});
}
