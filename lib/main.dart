import 'package:flutter/material.dart';
import 'package:tdd_courses_app/core/res/colors.dart';
import 'package:tdd_courses_app/core/services/router.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Education App',
      theme: ThemeData(
        // fontFamily: Fonts.poppins,
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
