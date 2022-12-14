import 'package:flutter/material.dart';
import 'package:test_provider/ui/login1/layers/layer_one.dart';
import 'package:test_provider/ui/login1/layers/layer_three.dart';
import 'package:test_provider/ui/login1/layers/layer_two.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/primaryBg.png'),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: <Widget>[
            const Positioned(
                top: 200,
                left: 59,
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'Poppins-Medium',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
            Positioned(top: 290, right: 0, bottom: 0, child: LayerOne()),
            Positioned(top: 318, right: 0, bottom: 28, child: LayerTwo()),
            LayerThree()
          ],
        ),
      ),
    );
  }
}
