import 'package:flutter/material.dart';


class LockScreenTitle extends StatelessWidget {
  final String? upperTitle;
  final String? title;

  const LockScreenTitle({
    Key? key,
    this.upperTitle,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          upperTitle!,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        Text(
          title!,
          style: const TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
