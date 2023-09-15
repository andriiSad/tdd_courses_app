import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:tdd_courses_app/core/extensions/context_extension.dart';
import 'package:tdd_courses_app/core/res/colors.dart';
import 'package:tdd_courses_app/core/res/fonts.dart';
import 'package:tdd_courses_app/src/on_boarding/domain/entities/page_content.dart';
import 'package:tdd_courses_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    required this.content,
    super.key,
  });

  final PageContent content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          content.lottie,
          height: context.screenHeight * .4,
        ),
        Gap(context.screenHeight * .03),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                content.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Fonts.aeonik,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(context.screenHeight * .02),
              Text(
                content.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: Fonts.poppins,
                ),
              ),
              Gap(context.screenHeight * .05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  backgroundColor: Colours.primaryColour,
                  foregroundColor: Colours.whiteColour,
                ),
                onPressed: () {
                  // if (_pageIndex < 2) {
                  //   pageController.nextPage(
                  //     duration: const Duration(milliseconds: 500),
                  //     curve: Curves.easeInOut,
                  //   );
                  // }

                  context.read<OnBoardingCubit>().cacheFirstTimer();
                },
                child: const Text(
                  // _pageIndex < 2 ? 'Next' : 'Get Started',
                  'Get Started',
                  style: TextStyle(
                    fontFamily: Fonts.aeonik,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
