import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trilo_admin/constants/app_themes.dart';
import 'package:trilo_admin/constants/ui_constants.dart';
import 'package:trilo_admin/firebase_options.dart';
import 'package:trilo_admin/locator.dart';
import 'package:trilo_admin/services/nav.dart';
import 'package:trilo_admin/services/router.dart';
import 'package:trilo_admin/view_models/theme_provider.dart';
import 'package:trilo_admin/views/auth/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      navigatorKey: NavigationService().navigationKey,
      title: 'Trilo Admin',
      theme: themeProvider.isDarkTheme ? triloDarkTheme : triloLightTheme,
      home: const LandingPage(),
    );
  }
}
