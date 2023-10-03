import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tdd_courses_app/core/extensions/context_extension.dart';
import 'package:tdd_courses_app/core/extensions/string_extension.dart';
import 'package:tdd_courses_app/src/profile/presentation/widgets/edit_profile_form_field.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.fullnameController,
    required this.emailController,
    required this.oldPasswordController,
    required this.passwordController,
    required this.bioController,
    super.key,
  });

  final TextEditingController fullnameController;
  final TextEditingController emailController;
  final TextEditingController oldPasswordController;
  final TextEditingController passwordController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
          title: 'FULL NAME',
          controller: fullnameController,
          hintText: context.user!.fullName,
        ),
        const Gap(30),
        EditProfileFormField(
          title: 'EMAIL',
          controller: emailController,
          hintText: context.user!.email.obscureEmail,
        ),
        const Gap(30),
        EditProfileFormField(
          title: 'CURRENT PASSWORD',
          controller: oldPasswordController,
          hintText: '******',
        ),
        const Gap(30),
        StatefulBuilder(
          builder: (_, setState) {
            oldPasswordController.addListener(() => setState(() {}));
            return EditProfileFormField(
              title: 'NEW PASSWORD',
              controller: passwordController,
              hintText: '******',
              readOnly: oldPasswordController.text.isEmpty,
            );
          },
        ),
        const Gap(30),
        EditProfileFormField(
          title: 'BIO',
          controller: bioController,
          hintText: context.user!.bio,
        ),
      ],
    );
  }
}
