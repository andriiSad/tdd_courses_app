import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_courses_app/core/common/app/providers/user_provider.dart';
import 'package:tdd_courses_app/src/auth/data/models/user_model.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  UserProvider get userProvider => read<UserProvider>();

  LocalUserModel? get user => userProvider.user;
}
