import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ai_assistant/screen/feature/chatbot_feature.dart';
import 'package:ai_assistant/screen/feature/image_feature.dart';
import 'package:ai_assistant/screen/feature/translator_feature.dart';

enum HomeType { aiChatBot, aiImage, aiTranslator }

extension MyHomeType on HomeType{
  String get title => switch(this) {
    HomeType.aiChatBot => "AI ChatBot",
    HomeType.aiImage => "AI Image Creator",
    HomeType.aiTranslator => "Language Translator",
  };

  String get lottie => switch(this) {
    HomeType.aiChatBot => "ai_hand_waving.json",
    HomeType.aiImage => "ai_play.json",
    HomeType.aiTranslator => "ai_ask_me.json",
  };

  bool get leftAlign => switch(this) {
    HomeType.aiChatBot => true,
    HomeType.aiImage => false,
    HomeType.aiTranslator => true,
  };

  EdgeInsets get padding => switch(this) {
    HomeType.aiChatBot => EdgeInsets.zero,
    HomeType.aiImage => const EdgeInsets.all(20),
    HomeType.aiTranslator => EdgeInsets.zero,
  };

  VoidCallback get onTap => switch(this) {
    HomeType.aiChatBot => () => Get.to(() => const ChatBotFeature()),
    HomeType.aiImage => () => Get.to(() => const ImageFeature()),
    HomeType.aiTranslator => () => Get.to(() => const TranslatorFeature()),
  };
}