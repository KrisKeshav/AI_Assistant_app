import 'package:ai_assistant/controller/image_controller.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/widget/custom_btn.dart';
import 'package:ai_assistant/widget/custom_loading.dart';
import 'package:ai_assistant/widget/language_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ai_assistant/controller/translate_controller.dart';

class TranslatorFeature extends StatefulWidget {
  const TranslatorFeature({super.key});

  @override
  State<TranslatorFeature> createState() => _TranslatorFeatureState();
}

class _TranslatorFeatureState extends State<TranslatorFeature> {
  final _c = TranslateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multi Language Translator"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: mq.height * 0.02, bottom: mq.height * 0.1),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // from language
              InkWell(
                onTap: () => Get.bottomSheet(LanguageSheet(c: _c, s: _c.from)),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: mq.width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Container(
                      alignment: Alignment.center,
                      child: Obx(() => Text(_c.from.isEmpty ? 'Auto' : _c.from.value))),
                ),
              ),
              IconButton(
                  onPressed: _c.swapLanguages,
                  icon: Obx(
                        () => Icon(CupertinoIcons.repeat,
                        color: _c.to.isNotEmpty && _c.from.isNotEmpty ? Colors.blue : Colors.grey
                    ),
                  )),
              // to language
              InkWell(
                onTap: () => Get.bottomSheet(LanguageSheet(c: _c, s: _c.to)),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: mq.width * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: const BorderRadius.all(Radius.circular(15))),
                  child: Container(
                      alignment: Alignment.center,
                      child: Obx(() => Text(_c.to.isEmpty ? 'To' : _c.to.value))),
                ),
              ),
            ],
          ),

          // text field
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.width * 0.04, vertical: mq.height * 0.035),
            child: TextFormField(
              controller: _c.textC,
              textAlign: TextAlign.center,
              minLines: 5,
              maxLines: null,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                hintText: 'Translate anything you want...',
                hintStyle: TextStyle(fontSize: 13.5),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),

          // result field
          Obx(() => translateResult()),

          // for adding some space
          SizedBox(
            height: mq.height * 0.04,
          ),

          CustomBtn(onTap: _c.translate, text: 'Translate')
        ],
      ),
    );
  }

  Widget translateResult() {
    if (_c.status.value == Status.none) {
      return const SizedBox();
    } else if (_c.status.value == Status.complete) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * 0.04),
        child: TextFormField(
          controller: _c.resultC,
          textAlign: TextAlign.center,
          maxLines: null,
          onTapOutside: (e) => FocusScope.of(context).unfocus(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      );
    } else if (_c.status.value == Status.loading) {
      return const Align(child: CustomLoading());
    }
    return const SizedBox(); // Fallback for unexpected status
  }
}
