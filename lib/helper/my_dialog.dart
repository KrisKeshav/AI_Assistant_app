import 'package:ai_assistant/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialog{
//   info
  static void info(String msg){
    Get.snackbar('Info', msg, backgroundColor: Colors.blue.withOpacity(0.7), colorText: Colors.white);
  }

//   success
  static void success(String msg){
    Get.snackbar('Info', msg, backgroundColor: Colors.blue.withOpacity(0.7), colorText: Colors.white);
  }

//   error
  static void error(String msg){
    Get.snackbar('Info', msg, backgroundColor: Colors.blue.withOpacity(0.7), colorText: Colors.white);
  }

//   loading
  static void showLoadingDialog() {
    Get.dialog(const Center(child: CustomLoading(),));
  }
}