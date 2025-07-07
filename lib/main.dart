import 'package:flutter/material.dart';

import 'core/utils/app_ theme.dart';
import 'core/utils/app_route.dart';
import 'features/home/view/home_screen.dart';
import 'features/onBoarding/on_boarding_personalize.dart';
import 'features/onBoarding/on_boarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoute.onBoardingPersonalizeRouteName,
      routes: {

        AppRoute.homeRouteName: (context) => const HomeScreen(),
        AppRoute.onBoardingRouteName: (context) => const OnBoardingScreen(),
        AppRoute.onBoardingPersonalizeRouteName: (context) => const OnBoardingPersonalize(),
      },

    );
  }
}
