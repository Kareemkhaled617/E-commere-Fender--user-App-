

import 'package:flutter/material.dart';

import '../add_review.dart';
import '../constants.dart';
import '../proportionate.dart';
import 'components/custom_app_bar.dart';
import 'components/main_button.dart';
import 'components/multiline_input.dart';
import 'components/ride_stat.dart';

class RateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const AppHeader(),

            Positioned(
              top: -380,
              left: -187,
              child: Opacity(
                opacity: 0.9,
                child: Image.asset('assets/images/bg.png')
              )
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding * 2),
                child: Column(
                  children: [
                    CustomAppBar(),

                    SizedBox(height: kDefaultPadding * 2),

                    Image.asset(
                      'assets/images/driver.png',
                      width: getScreenPropotionWidth(166, size),
                    ),

                    SizedBox(height: kDefaultPadding),

                    Text(
                      'Your Driver:',
                      style: TextStyle(
                        color: kTextLightColor,
                        fontSize: 14
                      ),
                    ),

                    Text(
                      'Wasilij Smith',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(height: kDefaultPadding),

                    Divider(
                      color: kTextLightColor,
                    ),

                    SizedBox(height: kDefaultPadding),

                    RideStats(),

                    SizedBox(height: kDefaultPadding),

                    Divider(
                      color: kTextLightColor,
                    ),

                    SizedBox(height: kDefaultPadding),

                    Text(
                      'Mark,',
                      style: TextStyle(
                        color: kTextLightColor,
                        fontSize: 14,
                      ),
                    ),

                    Text(
                      'How is your trip?',
                      style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),

                    SizedBox(height: kDefaultPadding),



                    SizedBox(height: kDefaultPadding),

                    MultilineInput(),

                    SizedBox(height: kDefaultPadding),

                    MainButton()
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}