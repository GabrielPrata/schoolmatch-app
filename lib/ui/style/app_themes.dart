import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  final BuildContext context;
  double screenWidth = 375;

  AppThemes(this.context) {
    screenWidth = MediaQuery.of(context).size.width;
  }

  static const Color successGreen = Color(0xFF388E3C);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color yellowWarning = Color(0xFFFBC02D);
  static const Color greyColor = Color(0xFFBABABA);
  static const Color secondaryColor = Color(0xFFFF0000);

  ThemeData get classicTheme {
    return ThemeData(
      primaryColor: Color(0xFF110231),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF110231),
        secondary: secondaryColor,
        surface: Colors.white,
        error: errorColor,
        onPrimary: Color(0xFFFFFFFF),
        onSecondary: Colors.black,
        onSurface: Color.fromARGB(255, 50, 49, 71),
        onError: Color(0xFF09011B),
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserrat(
          fontSize: calculate(36),
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontSize: calculate(32),
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        titleSmall: GoogleFonts.montserrat(
          fontSize: calculate(26),
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: calculate(24),
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: calculate(18),
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: calculate(17),
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelLarge: GoogleFonts.montserrat(
          fontSize: calculate(24),
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: calculate(17),
          fontWeight: FontWeight.w600,
          color: Color(0xFF110231),
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontSize: calculate(20),
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFFF0000)),
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

  ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color(0xFF1B1B1B),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF1B1B1B),
        secondary: secondaryColor,
        surface: Colors.grey.shade700,
        error: errorColor,
        onPrimary: Color(0xFFFFFFFF),
        onSecondary: Colors.white,
        onSurface: Color(0xFF444444),
        onError: Color(0xFF0F0F0F),
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserrat(
          fontSize: calculate(36),
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontSize: calculate(32),
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        titleSmall: GoogleFonts.montserrat(
          fontSize: calculate(26),
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: calculate(24),
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: calculate(18),
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: calculate(17),
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelLarge: GoogleFonts.montserrat(
          fontSize: calculate(24),
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: calculate(17),
          fontWeight: FontWeight.w600,
          color: Color(0xFF1B1B1B),
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontSize: calculate(20),
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFFF0000)),
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

  ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.white,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.white,
          secondary: secondaryColor,
          surface: Color(0xFFBDBDBD),
          error: errorColor,
          // onPrimary: Color(0xFF000000),
          onPrimary: Color(0xFF110231),
          onSecondary: Colors.black,
          onSurface: Color(0xFFC0C0C0),
          onError: Color(0xFF575757)),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserrat(
          fontSize: calculate(36),
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontSize: calculate(32),
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        titleSmall: GoogleFonts.montserrat(
          fontSize: calculate(26),
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: calculate(24),
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: calculate(18),
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: calculate(17),
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        labelLarge: GoogleFonts.montserrat(
          fontSize: calculate(24),
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: calculate(17),
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontSize: calculate(20),
          fontWeight: FontWeight.w700,
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFFF0000)),
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

  double calculate(double baseSize) {
    // Define um tamanho base para a largura de 375 pixels (um ponto de referência comum)
    const double baseWidth = 450;
    // Define um fator de escala baseado na largura da tela
    double scaleFactor = screenWidth / baseWidth;
    // Retorna um tamanho de fonte base proporcional
    return baseSize * scaleFactor;
  }
}
