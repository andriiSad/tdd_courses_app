import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tdd_courses_app/core/res/colors.dart';
import 'package:tdd_courses_app/core/res/media_resources.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          //TODO: when assets will be found
          //replace with onBoardingBackground image
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Colours.gradient,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Lottie.asset(MediaRes.pageUnderConstructionLottie),
          ),
        ),
      ),
    );
  }
}
