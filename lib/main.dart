import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/ui/screens/login_screen.dart';
import 'package:school_match/util/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await GetStorage.init(); // Initialize GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(context),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return GetMaterialApp(
            
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('pt', 'BR'), // Português do Brasil
            ],
            title: 'School Match',
            theme: themeProvider.themeData, // Apply the theme from ThemeProvider
            home: LoginScreen(), // Your home screen or initial route
          );
        },
      ),
    );
  }
}
