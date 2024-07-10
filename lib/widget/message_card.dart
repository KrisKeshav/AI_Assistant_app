import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/model/message.dart';
import 'package:get/get.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const r = Radius.circular(15);

    return message.msgType == MessageType.bot
        ? Row(
      children: [
        const SizedBox(width: 6),
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/images/logo.png',
            width: 24,
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.width * 0.02),
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.02),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: const BorderRadius.only(
                  topLeft: r, topRight: r, bottomRight: r)),
            child: message.msg.isEmpty ? AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  ' Please wait... ',
                  speed: const Duration(milliseconds: 100),
                ),
              ],

              repeatForever: true,
            ) : Text(message.msg, textAlign: TextAlign.center,)
        ),
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.02),
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.02),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).lightTextColor),
              borderRadius: const BorderRadius.only(
                  topLeft: r, topRight: r, bottomLeft: r)),
          child: Text(
            message.msg,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ),
        const CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}

