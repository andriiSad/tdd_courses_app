import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tdd_courses_app/core/extensions/context_extension.dart';
import 'package:tdd_courses_app/core/res/colors.dart';
import 'package:tdd_courses_app/src/auth/data/models/user_model.dart';
import 'package:tdd_courses_app/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:tdd_courses_app/src/dashboard/presentation/utils/dashboard_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUserModel>(
      stream: DashBoardUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          context.userProvider.user = snapshot.data;
        }
        return Consumer<DashboardController>(
          builder: (_, controller, __) {
            return Scaffold(
              backgroundColor: Colours.whiteColour,
              body: IndexedStack(
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.currentIndex,
                showSelectedLabels: false,
                backgroundColor: Colours.whiteColour,
                elevation: 0,
                onTap: controller.changeIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 0
                          ? IconlyBold.home
                          : IconlyLight.home,
                      color: controller.currentIndex == 0
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Home',
                    backgroundColor: Colours.whiteColour,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 1
                          ? IconlyBold.document
                          : IconlyLight.document,
                      color: controller.currentIndex == 1
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Materials',
                    backgroundColor: Colours.whiteColour,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 2
                          ? IconlyBold.chat
                          : IconlyLight.chat,
                      color: controller.currentIndex == 2
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Chat',
                    backgroundColor: Colours.whiteColour,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 3
                          ? IconlyBold.profile
                          : IconlyLight.profile,
                      color: controller.currentIndex == 3
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'User',
                    backgroundColor: Colours.whiteColour,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
