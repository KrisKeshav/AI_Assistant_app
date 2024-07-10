import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/widget/message_card.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/controller/chat_controller.dart';
import 'package:get/get.dart';

class ChatBotFeature extends StatefulWidget {
  const ChatBotFeature({super.key});

  @override
  State<ChatBotFeature> createState() => _ChatBotFeatureState();
}

class _ChatBotFeatureState extends State<ChatBotFeature> {
  final _c = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with AI Assistant"),

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          Expanded(
              child: TextFormField(
                controller: _c.textC,
                textAlign: TextAlign.center,
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  filled: true,
                  isDense: true,
                  hintText: 'Ask me anything you want...',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))
                  )
                ),
              )),

        //       for adding some space
          const SizedBox(width: 8,),

        //   send button
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).buttonColor,
            child: IconButton(
              onPressed: _c.askQuestion,
              icon: const Icon(Icons.rocket_launch_rounded),
            ),
          )
        ],),
      ),

      body: Obx(
          () => ListView(
            physics: const BouncingScrollPhysics(),
            controller: _c.scrollC,
            padding: EdgeInsets.only(top: mq.height*0.02, bottom: mq.height*0.1),
          children: _c.list.map((e) => MessageCard(message: e,)).toList(),
        ),
      ),
    );
  }
}
