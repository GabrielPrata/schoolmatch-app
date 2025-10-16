import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({
    super.key,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.88,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Theme.of(context).brightness == Brightness.dark
                ? Image.asset("assets/LogoSchoolMatchBranca.png")
                : Image.asset("assets/LogoSchoolMatch.png"),
          ),
          const Spacer(),
          IconButton(
            color: Theme.of(context).colorScheme.onPrimary,
            icon: const Icon(Icons.tune),
            onPressed: () => debugPrint("Tune icon pressed"),
            tooltip: 'Configurações',
          ),
          IconButton(
            color: Theme.of(context).colorScheme.onPrimary,
            icon: const Icon(Icons.notifications),
            onPressed: () => debugPrint("Notifications icon pressed"),
            tooltip: 'Notificações',
          ),
        ],
      ),
    );
  }
}
