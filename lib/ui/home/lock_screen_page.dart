import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test_provider/ui/home/widgets/lock_button.dart';


class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
        Lottie.network(
            'https://assets8.lottiefiles.com/packages/lf20_jcikwtux.json'),
            Expanded(
              child: Container(),
            ),
            LockButton(
              onTap: () {},
              child: Image.asset(
                "assets/images/page_one_lock.png",
                width: 60.0,
                height: 60.0,
              ),
            ),
            const Text(
              "Tap to Login",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
