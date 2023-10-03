import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdd_courses_app/core/common/widgets/gradient_background.dart';
import 'package:tdd_courses_app/core/common/widgets/nested_back_button.dart';
import 'package:tdd_courses_app/core/enums/update_user.dart';
import 'package:tdd_courses_app/core/extensions/context_extension.dart';
import 'package:tdd_courses_app/core/res/media_resources.dart';
import 'package:tdd_courses_app/core/utils/core_utils.dart';
import 'package:tdd_courses_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:tdd_courses_app/src/profile/presentation/widgets/edit_profile_form.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();

  File? pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  bool get nameChanged =>
      context.user?.fullName.trim() != fullnameController.text.trim();
  bool get emailChanged => emailController.text.isNotEmpty;
  bool get passwordChanged => passwordController.text.trim().isNotEmpty;
  bool get bioChanged => context.user!.bio?.trim() != bioController.text.trim();

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged &&
      !passwordChanged &&
      !bioChanged &&
      !imageChanged;

  @override
  void initState() {
    super.initState();
    final user = context.user;
    fullnameController.text = user!.fullName.trim();
    bioController.text = user.bio?.trim() ?? '';
  }

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    passwordController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          CoreUtils.showSnackBar(context, 'Profile updated successfully');
          context.pop();
        } else if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: const NestedBackButton(),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (nothingChanged) context.pop();
                  final bloc = context.read<AuthBloc>();
                  if (passwordChanged) {
                    if (oldPasswordController.text.trim().isEmpty) {
                      CoreUtils.showSnackBar(
                        context,
                        'Please enter your old password',
                      );
                      return;
                    } else {
                      bloc.add(
                        UpdateUserEvent(
                          userData: jsonEncode({
                            'oldPassword': oldPasswordController.text.trim(),
                            'newPassword': passwordController.text.trim(),
                          }),
                          action: UpdateUserAction.password,
                        ),
                      );
                    }
                    bloc.add(
                      UpdateUserEvent(
                        userData: passwordController.text.trim(),
                        action: UpdateUserAction.password,
                      ),
                    );
                  }
                  if (nameChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        userData: fullnameController.text.trim(),
                        action: UpdateUserAction.displayName,
                      ),
                    );
                  }
                  if (emailChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        userData: emailController.text.trim(),
                        action: UpdateUserAction.email,
                      ),
                    );
                  }
                  if (bioChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        userData: bioController.text.trim(),
                        action: UpdateUserAction.bio,
                      ),
                    );
                  }
                  if (imageChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        userData: pickedImage,
                        action: UpdateUserAction.profilePic,
                      ),
                    );
                  }
                },
                child: state is AuthLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : StatefulBuilder(
                        builder: (_, refresh) {
                          fullnameController.addListener(() => refresh(() {}));
                          emailController.addListener(() => refresh(() {}));
                          passwordController.addListener(() => refresh(() {}));
                          bioController.addListener(() => refresh(() {}));
                          return Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: nothingChanged
                                  ? Colors.grey
                                  : Colors.blueAccent,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          body: GradientBackground(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Builder(
                  builder: (context) {
                    final user = context.user!;
                    final userImage =
                        user.prifilePic == null || user.prifilePic!.isEmpty
                            ? null
                            : user.prifilePic;
                    return Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: pickedImage != null
                              ? FileImage(pickedImage!)
                              : userImage != null
                                  ? NetworkImage(userImage)
                                  : const AssetImage(
                                      MediaRes.defaultImage,
                                    ) as ImageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.multiply,
                          ),
                        ),
                      ),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: pickImage,
                        icon: Icon(
                          pickedImage != null || user.prifilePic != null
                              ? Icons.edit
                              : Icons.add_a_photo,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'We recomend an image of at least 400x400',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Gap(30),
                EditProfileForm(
                  fullnameController: fullnameController,
                  emailController: emailController,
                  oldPasswordController: oldPasswordController,
                  passwordController: passwordController,
                  bioController: bioController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
