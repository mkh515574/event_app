import 'package:flutter/material.dart';

import 'core/utils/app_route.dart';
import 'features/home/view/home_screen.dart';

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

      initialRoute: AppRoute.homeRouteName,
      routes: {

        AppRoute.homeRouteName: (context) => const HomeScreen(),
      },

    );
  }
}
