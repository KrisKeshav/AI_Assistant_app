import 'dart:developer';

import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/widget/custom_btn.dart';
import 'package:ai_assistant/widget/custom_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ai_assistant/controller/image_controller.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  final ImageController _c = Get.put(ImageController());

  @override
  void dispose() {
    _c.textC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Image Creator"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
        actions: [
          Obx(() => _c.status.value == Status.complete
              ? IconButton(
              padding: const EdgeInsets.only(right: 6),
              onPressed: _c.shareImage,
              icon: const Icon(Icons.share))
              : const SizedBox(),
          )
        ],
      ),
      floatingActionButton: Obx(() => _c.status.value == Status.complete
          ? Padding(
        padding: const EdgeInsets.only(right: 6, bottom: 6),
        child: FloatingActionButton(
          onPressed: _c.downloadImage,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: const Icon(
            Icons.save_alt_rounded,
            size: 26,
          ),
        ),
      )
          : const SizedBox()),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mq.height * 0.02,
          bottom: mq.height * 0.1,
          left: mq.width * 0.04,
          right: mq.width * 0.04,
        ),
        children: [
          TextFormField(
            controller: _c.textC,
            textAlign: TextAlign.center,
            minLines: 2,
            maxLines: null,
            onTapOutside: (e) => FocusScope.of(context).unfocus(),
            decoration: const InputDecoration(
              hintText:
              'Imagine something wonderful and creative, describe here and I will create for you',
              hintStyle: TextStyle(fontSize: 13.5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          SizedBox(height: mq.height * 0.02), // Space between text bar and image
          Container(
            height: mq.height * 0.5,
            alignment: Alignment.center,
            child: Obx(() => _aiImage()),
          ),

          SizedBox(height: mq.height * 0.02),

          Obx(() => _c.imageList.isEmpty ? const SizedBox() : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Wrap(
              spacing: 10,
              children: _c.imageList.map((e) => InkWell(
                onTap: () {_c.url.value = e;},
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: CachedNetworkImage(
                    imageUrl: e,
                    height: 100,
                    errorWidget: (context, url, error) {
                      log('Failed to load image from URL: $url, Error: $error');
                      return const Icon(Icons.error, color: Colors.red);
                    },
                  ),
                ),
              ),).toList(),),
          ),),

          SizedBox(height: mq.height * 0.1), // Space between image and button
          CustomBtn(
            onTap: _c.searchAiImage,
            text: 'Create',
          ),
        ],
      ),
    );
  }

  Widget _aiImage() {
    switch (_c.status.value) {
      case Status.none:
        return Lottie.asset('assets/lottie/ai_play.json', height: mq.height * 0.3);
      case Status.loading:
        return const CustomLoading();
      case Status.complete:
        if (_c.url.value.isNotEmpty) {
          log('Attempting to load image from URL: ${_c.url.value}');
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: _c.url.value,
              placeholder: (context, url) {
                log('Loading placeholder for URL: $url');
                return const CustomLoading();
              },
              errorWidget: (context, url, error) {
                log('Failed to load image from URL: $url, Error: $error');
                return const Icon(Icons.error, color: Colors.red);
              },
            ),
          );
        } else {
          log('URL is empty');
          return const Text('No image URL provided', textAlign: TextAlign.center);
        }
      case Status.error:
        return Text(
          _c.errorMessage,
          style: const TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        );
      default:
        return const SizedBox();
    }
  }
}
