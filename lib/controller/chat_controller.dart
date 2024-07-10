import 'package:ai_assistant/apis/apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_assistant/model/message.dart';
import 'package:ai_assistant/helper/my_dialog.dart';

class ChatController extends GetxController {
  final textC = TextEditingController();
  final scrollC = ScrollController();

  final list = <Message>[
    Message(msg: 'Hello, How can I help you?', msgType: MessageType.bot)
  ].obs;

  Future<void> askQuestion() async {
    if (textC.text.trim().isNotEmpty) {
      // Add user's message
      list.add(Message(msg: textC.text, msgType: MessageType.user));

      // Add "Please wait" message
      list.add(Message(msg: '', msgType: MessageType.bot));
      _scrollDown();

      // Get response from API
      final res = await APIs.getAnswer(textC.text);

      // Clear the text field
      textC.text = '';

      // Update the last message with the bot's response
      list[list.length - 1] = Message(msg: res, msgType: MessageType.bot);
      _scrollDown();
    }else{
      MyDialog.info('Ask Something');
    }
  }

  void _scrollDown() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollC.animateTo(
        scrollC.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }
}

