import 'dart:typed_data';
import 'dart:io';
import 'dart:developer';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/helper/my_dialog.dart';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/apis/apis.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

enum Status { none, loading, complete, error }

class ImageController extends GetxController {
  final textC = TextEditingController();
  final status = Status.none.obs;
  final url = ''.obs;
  final imageList = <String>[].obs;

  Uint8List? imageData;
  String errorMessage = '';

  Future<void> downloadImage() async {
    if (imageData != null) {
      try {
        MyDialog.showLoadingDialog();
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/temp_image.png';
        final file = File(filePath);
        await file.writeAsBytes(imageData!);
        await GallerySaver.saveImage(file.path, albumName: appName).then((success) {
          Get.back();
          if (success == true) {
            MyDialog.success('Image downloaded to Gallery');
          } else {
            MyDialog.error('Failed to save image');
          }
        });
      } catch (e) {
        Get.back();
        log('downloadImageE: $e');
        MyDialog.error('Failed to save image: $e');
      }
    } else {
      MyDialog.error('No image to save');
    }
  }

  Future<void> shareImage() async {
    if (imageData != null) {
      try {
        MyDialog.showLoadingDialog();
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/temp_image.png';
        final file = File(filePath);
        await file.writeAsBytes(imageData!);
        Get.back();
        await Share.shareXFiles([XFile(filePath)], text: 'Great picture');
      } catch (e) {
        Get.back();
        log('downloadImageE: $e');
        MyDialog.error('Failed to save image: $e');
      }
    } else {
      MyDialog.error('No image to save');
    }
  }

  Future<void> searchAiImage() async {
    if (textC.text.trim().isNotEmpty) {
      status.value = Status.loading;
      try {
        log('Searching for AI images with prompt: ${textC.text}');
        imageList.value = await APIs.searchAiImages(textC.text);
        log('Image list: ${imageList.toString()}');

        if (imageList.isEmpty) {
          MyDialog.error('Something went wrong (Try again in sometime)');
          status.value = Status.error;
          return;
        }
        url.value = imageList.first;
        log('Image URL: ${url.value}');

        // Fetch and set image data
        imageData = await fetchImageData(url.value);
        status.value = Status.complete;
      } catch (e) {
        log('Error in searchAiImage: $e');
        MyDialog.error('Failed to fetch image: $e');
        status.value = Status.error;
      }
    } else {
      MyDialog.info('Provide some beautiful image description!');
    }
  }

  Future<Uint8List?> fetchImageData(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        log('Failed to load image data from URL: $imageUrl');
        return null;
      }
    } catch (e) {
      log('Error fetching image data: $e');
      return null;
    }
  }
}
