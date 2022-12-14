
import 'package:flutter/material.dart';

import 'ChatMessage.dart';
import 'chat_input_fields.dart';
import 'message.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: demeChatMessages.length,
            itemBuilder: (context, index) => Message(message: demeChatMessages[index]),
          ),
        )),
        const ChatInputField()
      ],
    );
  }
}
