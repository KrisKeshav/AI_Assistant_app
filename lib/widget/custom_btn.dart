import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomBtn({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).buttonColor,
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              elevation: 0,
              textStyle: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500),
              minimumSize: Size(mq.width * 0.4, 50)),
          onPressed: onTap,
          child: Text(text)),
    );
  }
}
