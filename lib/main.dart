import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_courses_app/core/common/app/providers/user_provider.dart';
import 'package:tdd_courses_app/core/res/colors.dart';
import 'package:tdd_courses_app/core/res/fonts.dart';
import 'package:tdd_courses_app/core/services/injection_container/injection_container.dart';
import 'package:tdd_courses_app/core/services/router/router.dart';
import 'package:tdd_courses_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //init service locator
  await init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'Education App',
        theme: ThemeData(
          fontFamily: Fonts.poppins,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colours.primaryColour,
          ),
          useMaterial3: true,
        ),
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
