import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/domain/controllers/auth_controller.dart';
import 'package:school_match/ui/screens/forms/user_email_screen.dart';
import 'package:school_match/ui/style/app_themes.dart';
import 'package:vibration/vibration.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  ativaNotificacoes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserMailForm(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.only(top: 60, left: 30, right: 30),
        child: ListView(children: <Widget>[
          SizedBox(
            height: 50,
          ),
          SizedBox(
            child: Text(
              "Ativar notificações?",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            child: Text(
              "Fique sabendo quando fizer ou novo Match ou receber uma mensagem",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Theme.of(context).brightness == Brightness.dark
                ? Image.asset("assets/Notification.gif")
                : Image.asset("assets/Notification_azul.gif"),
            height: 400,
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            child: Column(
              children: [
                ElevatedButton(
                  style: Theme.of(context).filledButtonTheme.style,
                  onPressed: () => ativaNotificacoes(),
                  child: Text(
                    "ATIVAR NOTIFICAÇÕES",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () => print(""),
                  child: Text(
                    "NÃO ME ENCHE",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
