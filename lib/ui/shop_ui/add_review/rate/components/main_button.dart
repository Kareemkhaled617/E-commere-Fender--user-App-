
import 'package:flutter/material.dart';
import 'package:test_provider/ui/shop_ui/add_review/rate/components/rounded_button.dart';
import '../../constants.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          tap: () {}
        )
      ],
    );
  }
}