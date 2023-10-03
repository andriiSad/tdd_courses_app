import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tdd_courses_app/core/common/app/providers/user_provider.dart';
import 'package:tdd_courses_app/core/extensions/context_extension.dart';
import 'package:tdd_courses_app/core/res/colors.dart';
import 'package:tdd_courses_app/core/res/media_resources.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        final image = user?.prifilePic;
        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: image != null
                  ? NetworkImage(image)
                  : const AssetImage(MediaRes.defaultImage) as ImageProvider,
            ),
            const Gap(16),
            Text(
              user?.fullName ?? 'Unknown',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            if (user?.bio != null && user!.bio!.isNotEmpty) ...[
              const Gap(8),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * .15,
                ),
                child: Text(
                  user.bio!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colours.neutralTextColour,
                  ),
                ),
              ),
            ],
            const Gap(16),
          ],
        );
      },
    );
  }
}
