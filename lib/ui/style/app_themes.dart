import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static const Color successGreen = Color(0xFF388E3C);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color yellowWarning = Color(0xFFFBC02D);
  static const Color greyColor = Color(0xFFBABABA);
  static const Color secondaryColor = Color(0xFFFF0000);

  static ThemeData get classicTheme {
    return ThemeData(
      primaryColor: Color(0xFF110231),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF110231),
        secondary: secondaryColor,
        surface: Colors.white,
        error: errorColor,
        onPrimary: Color(0xFF0B0022),
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xFF110231),
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
          minimumSize: WidgetStatePropertyAll<Size>(Size(double.infinity, 50)),
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll<Size>(Size(double.infinity, 50)),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: Colors.white, // Cor da borda
              width: 1.0, // Largura da borda
            ),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color(0xFF1B1B1B),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF1B1B1B),
        secondary: secondaryColor,
        surface: Colors.grey.shade700,
        error: errorColor,
        onPrimary: Color(0xFF080808),
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1B1B1B),
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
          minimumSize: WidgetStatePropertyAll<Size>(Size(double.infinity, 50)),
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll<Size>(Size(double.infinity, 50)),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: Colors.white, // Cor da borda
              width: 1.0, // Largura da borda
            ),
          ),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.white,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.white,
        secondary: secondaryColor,
        surface: Color(0xFFBDBDBD),
        error: errorColor,
        onPrimary: Color(0xFFBDBDBD),
        onSecondary: Colors.black,
        onSurface: Color(0xFF000000),
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
          minimumSize: WidgetStatePropertyAll<Size>(Size(double.infinity, 50)),
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll<Size>(Size(double.infinity, 50)),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: Colors.black, // Cor da borda
              width: 1.0, // Largura da borda
            ),
          ),
        ),
      ),
    );
  }
}

// static void classicTheme() {
//     Color primaryColor = Color(0xFF110231);
//     Color primaryVariant = Color(0xFF0B0022);
//     Color primaryTextColor = Color(0xFFFFFFFF);
//   }

//   static void darkTheme() {
//     Color primaryColor = Color(0x1B1B1B);
//     Color primaryVariant = Color(0xFF080808);
//     Color primaryTextColor = Color(0xFFFFFFFF);
//   }

//   static void lightTheme() {
//     Color primaryColor = Color(0xFFFFFFFF);
//     Color primaryVariant = Color(0xFFBDBDBD);
//     Color primaryTextColor = Color(0xFF000000);
//   }
