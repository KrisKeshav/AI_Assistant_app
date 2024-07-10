import 'package:ai_assistant/apis/apis.dart';
import 'package:ai_assistant/helper/pref.dart';
import 'package:flutter/material.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:flutter/services.dart';
import 'package:ai_assistant/widget/home_card.dart';
import 'package:ai_assistant/model/home_type.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _isDarkMode = Pref.isDarkMode.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Pref.showOnboarding = false;
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    // APIs.getAnswer('hii');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appName,
        ),

        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 10),
              onPressed: () {
                Get.changeThemeMode(_isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
                _isDarkMode.value = !_isDarkMode.value;
                Pref.isDarkMode = _isDarkMode.value;
              },
              icon: Obx(
                ()=> Icon(
                  _isDarkMode.value ? Icons.brightness_2_rounded :
                  Icons.brightness_4_rounded,
                  size: 26,
                ),
              ))
        ],

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: mq.width*0.04, vertical: mq.height*0.015
        ),
        children: HomeType.values.map((e) => HomeCard(homeType: e)).toList(),
      )
    );
  }
}
