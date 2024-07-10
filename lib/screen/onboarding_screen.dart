import 'package:ai_assistant/main.dart';
import 'package:ai_assistant/model/onboard.dart';
import 'package:ai_assistant/screen/home_screen.dart';
import 'package:ai_assistant/widget/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:ai_assistant/helper/global.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PageController();

    final list = [
      Onboard(
          title: "Ask me Anything",
          subtitle:
              "I can be your Best Friend & You can ask me anything & I will help you",
          lottie: "ai_ask_me"),
      Onboard(
          title: "Imagination to Reality",
          subtitle:
              "Just Imagine anything & let me know, I will create something wonderful for you",
          lottie: "ai_play")
    ];

    return Scaffold(
      body: PageView.builder(
        controller: c,
          itemCount: list.length,
          itemBuilder: (ctx, ind) {
            final isLast = ind==list.length-1;
            return Column(
              children: [
                Lottie.asset('assets/lottie/${list[ind].lottie}.json',
                    height: mq.height * 0.6),
                Text(
                  list[ind].title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5),
                ),
                SizedBox(
                  height: mq.height * 0.015,
                ),
                SizedBox(
                  width: mq.width * 0.7,
                  child: Text(
                    list[ind].subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 13.5,
                        letterSpacing: 0.5,
                        color: Theme.of(context).lightTextColor),
                  ),
                ),
                const Spacer(),
                Wrap(
                  spacing: 10,
                  children: List.generate(
                      list.length,
                      (i) => Container(
                            width: i == ind ? 15 : 10,
                            height: 8,
                            decoration: BoxDecoration(
                                color: i == ind ? Colors.blue : Colors.grey,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                          )),
                ),
                const Spacer(),

                CustomBtn(onTap: () {
            if(isLast){
            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
            Get.off(() => const HomeScreen());
            }else{
            c.nextPage(duration: const Duration(microseconds: 600), curve: Curves.ease);
            }
            }, text: isLast ? "Finish" : "Next"),
                const Spacer(
                  flex: 2,
                ),
              ],
            );
          }),
    );
  }
}
