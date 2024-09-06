import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/ui/screens/login_page.dart';
import 'package:school_match/ui/style/app_themes.dart';
import 'package:school_match/util/theme_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(AppThemes.classicTheme),
      child: MyApp(),
    ),
  );


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RC Mineração',
      debugShowCheckedModeBanner: false,
       theme: Provider.of<ThemeProvider>(context).themeData,
      home: LoginPage(),
      // home: SplashScreen(),
    );
  }
}

