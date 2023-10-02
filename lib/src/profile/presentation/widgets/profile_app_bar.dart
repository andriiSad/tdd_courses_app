import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:tdd_courses_app/core/common/widgets/popup_item.dart';
import 'package:tdd_courses_app/core/extensions/context_extension.dart';
import 'package:tdd_courses_app/core/res/colors.dart';
import 'package:tdd_courses_app/core/services/injection_container/injection_container.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Account',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          surfaceTintColor: Colours.whiteColour,
          icon: const Icon(Icons.more_horiz),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              onTap: () => context.push(const Placeholder()),
              child: PopupItem(
                title: 'Edit Profile',
                icon: Icon(
                  Icons.edit,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              onTap: () => context.push(const Placeholder()),
              child: PopupItem(
                title: 'Notification',
                icon: Icon(
                  IconlyLight.notification,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              onTap: () => context.push(const Placeholder()),
              child: PopupItem(
                title: 'Help',
                icon: Icon(
                  Icons.help_outline_outlined,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              height: 1,
              padding: EdgeInsets.zero,
              child: Divider(
                height: 1,
                color: Colors.grey.shade300,
                endIndent: 16,
                indent: 16,
              ),
            ),
            PopupMenuItem<void>(
              onTap: () async {
                await serviceLocator<FirebaseAuth>().signOut();
                if (context.mounted) {
                  unawaited(
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    ),
                  );
                }
              },
              child: const PopupItem(
                title: 'Logout',
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
