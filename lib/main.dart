import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/ui/screens/login_screen.dart';
import 'package:school_match/util/theme_provider.dart';

void main() async {
  await GetStorage.init(); // Initialize GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'School Match',
            theme: themeProvider.themeData, // Apply the theme from ThemeProvider
            home: LoginScreen(), // Your home screen or initial route
          );
        },
      ),
    );
  }
}
