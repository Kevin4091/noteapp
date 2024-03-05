import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noteapp/utils/constants/color_constants.dart';
import 'package:noteapp/utils/constants/image_constants.dart';
import 'package:noteapp/view/notescreen/notescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NoteScreen(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainBlack,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset(ImageConstants.appLogo),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Note pad",
              style: TextStyle(
                fontSize: 40,
                color: ColorConstants.mainLightGrey,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
    );
  }
}
