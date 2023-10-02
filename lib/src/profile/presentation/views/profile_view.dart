import 'package:flutter/material.dart';
import 'package:tdd_courses_app/core/common/widgets/gradient_background.dart';
import 'package:tdd_courses_app/core/res/colors.dart';
import 'package:tdd_courses_app/src/profile/presentation/widgets/profile_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colours.whiteColour,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
