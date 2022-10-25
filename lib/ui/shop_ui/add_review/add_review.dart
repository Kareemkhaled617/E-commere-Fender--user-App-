import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider_home.dart';
import 'package:test_provider/ui/shop_ui/add_review/proportionate.dart';
import 'package:test_provider/ui/shop_ui/add_review/rate/components/custom_app_bar.dart';
import 'package:test_provider/ui/shop_ui/add_review/rate/components/rounded_button.dart';


import 'constants.dart';

class RateScreen extends StatefulWidget {
   RateScreen({super.key,required this.shopId,required this.token,required this.what,this.servicesId});
  String shopId;
  String? servicesId;

   String token;
   bool what;


  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  String? review;
  double? rate;

  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              const AppHeader(),
              Positioned(
                  top: -380,
                  left: -187,
                  child: Opacity(
                      opacity: 0.9, child: Image.asset('assets/images/bg.png'))),
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(18.0 * 2),
                child: Column(
                  children: [
                    const CustomAppBar(),
                    const SizedBox(height: 18.0 * 2),
                    Image.asset(
                      'assets/images/profile_pic.png',
                      width: getScreenPropotionWidth(166, size),
                    ),
                    const SizedBox(height: 18.0),
                    const Text(
                      'Your Driver:',
                      style: TextStyle(color: kTextLightColor, fontSize: 14),
                    ),
                    const Text(
                      'Kareem Khaled',
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Divider(
                      color: kTextLightColor,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rate =rating;
                        });
                        print(rate);
                      },
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Divider(
                      color: kTextLightColor,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const Text(
                      'Mark,',
                      style: TextStyle(
                        color: kTextLightColor,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'How is your trip?',
                      style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    const SizedBox(height: kDefaultPadding),
                    Container(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                offset: const Offset(0.0, 15.0),
                                color: kTextColor.withAlpha(20))
                          ]),
                      child: TextFormField(
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter valid review';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) {
                          setState(() {
                            review = val;
                          });
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Additional comment',
                            hintStyle: TextStyle(
                              color: kTextLightColor,
                            )),
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Submit',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),

                        const SizedBox(width: kDefaultPadding),

                        RoundedButton(
                            icon: const Icon(Icons.arrow_forward),
                            iconColor: Colors.white,
                            bgColor: kPrimaryColor,
                            tap: () {
                              if(formKey.currentState!.validate()){
                                formKey.currentState!.save();
                                if(widget.what){
                                  context.read<HomeProvider>().addReview(token:widget.token, id: widget.shopId, review: review, rate: rate).whenComplete(() {
                                    Navigator.pop(context);

                                  });
                                }else{
                                  context.read<HomeProvider>().addReviewInServicesShop(token:widget.token,review: review, rate: rate, idShop: widget.shopId, idServices:widget.servicesId).whenComplete(() {
                                    Navigator.pop(context);

                                  });
                                }
                              }
                            }
                        )
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  const AppHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        width: double.infinity,
        height: 350.0,
        color: const Color(0XFF2DBB54),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 150);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 170);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
