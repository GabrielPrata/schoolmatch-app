import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/domain/models/enums/themes.dart';
import 'package:school_match/ui/screens/notification_screen.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/util/theme_provider.dart';

class SelectThemeScreen extends StatefulWidget {
  const SelectThemeScreen({super.key});

  @override
  State<SelectThemeScreen> createState() => _SelectThemeScreenState();
}

NewUserController userController = Get.put(NewUserController());
TextEditingController inputController = TextEditingController();

class _SelectThemeScreenState extends State<SelectThemeScreen> {
  Themes _selectedTheme = Themes.classicTheme;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.08,
          horizontal: MediaQuery.of(context).size.width * 0.07,
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 150,
              child: Theme.of(context).brightness == Brightness.dark
                  ? Image.asset("assets/LogoSchoolMatchBranca.png")
                  : Image.asset("assets/LogoSchoolMatch.png"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              "Escolha o tema que mais combina com você!",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            buildThemeOptionTile(context, 'Tema Clássico', Themes.classicTheme),
            buildThemeOptionTile(context, 'Tema Escuro', Themes.darkTheme),
            buildThemeOptionTile(context, 'Tema Claro', Themes.lightTheme),
            SizedBox(height: MediaQuery.of(context).size.height * 0.22),
            ElevatedButton(
              style: Theme.of(context).filledButtonTheme.style,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationScreen()),
              ),
              child: Text("PRONTO!",
                  style: Theme.of(context).textTheme.labelMedium),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03)
          ],
        ),
      ),
    );
  }

  Widget buildThemeOptionTile(
      BuildContext context, String title, Themes theme) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return ListTile(
      title: InkWell(
        onTap: () {
          setState(() {
            _selectedTheme = theme;
            themeProvider.setTheme(_selectedTheme);
          });
        },
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      leading: Transform.scale(
        scale: 1.35,
        child: Radio<Themes>(
          value: theme,
          groupValue: _selectedTheme,
          activeColor: Theme.of(context).colorScheme.secondary,
          onChanged: (Themes? value) {
            setState(() {
              _selectedTheme = value!;
              themeProvider.setTheme(_selectedTheme);
            });
          },
        ),
      ),
    );
  }
}
