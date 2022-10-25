import 'package:flutter/material.dart';




class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20 / 2),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [BoxShadow(blurRadius: 32, offset: const Offset(0, 4), color: const Color(0xff087949).withOpacity(0.3))]),
      child: SafeArea(
          child: Row(
        children: [
          const Icon(Icons.mic, color: Color(0xFF00BF6D)),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20 * 0.75),
              decoration: BoxDecoration(
                color: const Color(0xFF00BF6D).withOpacity(0.07),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                    color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.64),
                  ),
                  const SizedBox(width: 20 / 2),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none, hintText: 'Type Message'),
                    ),
                  ),
                  Icon(
                    Icons.attach_file,
                    color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.64),
                  ),
                  const SizedBox(width: 20 / 4),
                  Icon(
                    Icons.camera_alt_outlined,
                    color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.64),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
