import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/features/auth/controller/auth_controller.dart';
import 'package:event_app/features/auth/login/login_screen.dart';
import 'package:event_app/features/auth/register/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/providers/app_language_provider.dart';
import 'core/services/shared_prefs.dart';
import 'core/utils/app_theme.dart';
import 'core/utils/app_route.dart';
import 'features/auth/forget password/forgot_password_screen.dart';
import 'features/events/create_event/create_event_screen.dart';
import 'features/events/edit_event/edit_event_screen.dart';
import 'features/events/event_details/event_details_screen.dart';
import 'features/home/controller/home_provider.dart';
import 'features/home/view/home_screen.dart';
import 'features/onBoarding/view/on_boarding_personalize.dart';
import 'features/onBoarding/view/on_boarding_screen.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();

  await FirebaseFirestore.instance.enableNetwork();
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnBoarding =
      prefs.getBool(SharedPrefsKeys.onBoardingCompleted) ?? false;
  final language = await getLanguage();
  final themeMode = await getThemeMode();

  final appLanguageProvider = AppLanguageProvider();
  await appLanguageProvider.init(language: language, themeMode: themeMode);



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => appLanguageProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(create: (context) => AuthController())

      ],
      child: MyApp(showOnBoarding: !hasSeenOnBoarding),
    ),

  );
}

class MyApp extends StatelessWidget {
  final bool showOnBoarding;

  const MyApp({super.key, required this.showOnBoarding});

  @override
  Widget build(BuildContext context) {
    final appLanguageProvider = Provider.of<AppLanguageProvider>(context);

    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appLanguageProvider.themeMode,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: appLanguageProvider.locale,

      initialRoute: showOnBoarding
          ? AppRoute.onBoardingPersonalizeRouteName
          : (FirebaseAuth.instance.currentUser != null
          ? AppRoute.homeRouteName
          : AppRoute.loginRouteName),

      routes: {
        AppRoute.homeRouteName: (context) => HomeScreen(),
        AppRoute.onBoardingRouteName: (context) => const OnBoardingScreen(),
        AppRoute.onBoardingPersonalizeRouteName: (context) =>
            const OnBoardingPersonalize(),
        AppRoute.loginRouteName: (context) => LoginScreen(),
        AppRoute.registerRouteName: (context) => RegisterScreen(),
        AppRoute.forgotPasswordRouteName: (context) => ForgotPasswordScreen(),
        AppRoute.createEventRouteName: (context) => CreateEventScreen(),
        AppRoute.eventDetailsRouteName: (context) => EventDetailsScreen(),
      
        AppRoute.editEventRouteName: (context) => EditEventScreen(),
      },
    );
  }
}
