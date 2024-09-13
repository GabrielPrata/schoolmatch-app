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
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      _selectedTheme =
          themeProvider.getCurrentTheme(); // Obter o tema atual do Provider
      _isInit = false;
    }
  }

  SalvarTema() {
    userController.setUserName(inputController.text);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NotificationScreen(),
      ),
    );
  }

  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.only(top: 60, left: 30, right: 30),
        child: ListView(children: <Widget>[
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 300,
            height: 150,
            child: Theme.of(context).brightness == Brightness.dark
                ? Image.asset("assets/LogoSchoolMatchBranca.png")
                : Image.asset("assets/LogoSchoolMatch.png"),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            child: Text(
              "Escolha o tema que mais combina com você!",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ListTile(
            title: Text('Tema Clássico',
                style: Theme.of(context).textTheme.labelLarge),
            leading: Transform.scale(
              scale: 1.35, // Aumenta o tamanho do Radio
              child: Radio<Themes>(
                value: Themes.classicTheme,
                groupValue: _selectedTheme,
                activeColor: Theme.of(context)
                    .colorScheme
                    .secondary, // Cor quando o radio está selecionado
                fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Theme.of(context)
                        .colorScheme
                        .secondary; // Cor quando selecionado
                  }
                  return Colors.grey; // Cor padrão quando não selecionado
                }),
                onChanged: (Themes? value) {
                  setState(() {
                    _selectedTheme = value!;
                    themeProvider.setTheme(
                        _selectedTheme); // Atualiza o tema globalmente
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Tema Escuro',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            leading: Transform.scale(
              scale: 1.35, // Aumenta o tamanho do Radio
              child: Radio<Themes>(
                value: Themes.darkTheme,
                groupValue: _selectedTheme,
                activeColor: Theme.of(context)
                    .colorScheme
                    .secondary, // Cor quando o radio está selecionado
                fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Theme.of(context)
                        .colorScheme
                        .secondary; // Cor quando selecionado
                  }
                  return Colors.grey; // Cor padrão quando não selecionado
                }),
                onChanged: (Themes? value) {
                  setState(() {
                    _selectedTheme = value!;
                    themeProvider.setTheme(
                        _selectedTheme); // Atualiza o tema globalmente
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Tema Claro',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            leading: Transform.scale(
              scale: 1.35, // Aumenta o tamanho do Radio
              child: Radio<Themes>(
                value: Themes.lightTheme,
                groupValue: _selectedTheme,
                activeColor: Theme.of(context)
                    .colorScheme
                    .secondary, // Cor quando o radio está selecionado
                fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Theme.of(context)
                        .colorScheme
                        .secondary; // Cor quando selecionado
                  }
                  return Colors.grey; // Cor padrão quando não selecionado
                }),
                onChanged: (Themes? value) {
                  setState(() {
                    _selectedTheme = value!;
                    themeProvider.setTheme(
                        _selectedTheme); // Atualiza o tema globalmente
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 260,
          ),
          ElevatedButton(
            style: Theme.of(context).filledButtonTheme.style,
            onPressed: () => SalvarTema(),
            child: Text(
              "PRONTO!",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ]),
      ),
    );
  }
}
