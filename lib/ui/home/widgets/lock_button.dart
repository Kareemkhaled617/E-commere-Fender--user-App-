import 'package:flutter/material.dart';
import 'package:test_provider/ui/login1/login_ui.dart';



class LockButton extends StatelessWidget {
  final Widget? child;
  final Function? onTap;

  const LockButton({
    Key? key,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.0,
      width: 125.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/lock_button.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        },
        child: Align(
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
