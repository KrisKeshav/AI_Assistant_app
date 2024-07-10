import 'package:ai_assistant/helper/pref.dart';
import 'package:ai_assistant/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/screen/home_screen.dart';
import 'package:ai_assistant/screen/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
       // Navigator.of(context).pushReplacement(MaterialPageRoute(
           // builder: (_) => Pref.showOnboarding ? const OnBoardingScreen() : const HomeScreen()));
      Get.off(() => Pref.showOnboarding ? const OnBoardingScreen() : const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              const Spacer(flex: 2,),
              Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: EdgeInsets.all(mq.width*0.05),
                    child:
                        Image.asset('assets/images/logo.png', width: mq.width * 0.4),
                  )),
              const Spacer(),
              const CustomLoading(),
              const Spacer(),
            ],
          ),
        ));
  }
}
