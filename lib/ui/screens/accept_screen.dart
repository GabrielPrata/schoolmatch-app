import 'package:flutter/material.dart';
// import 'package:rc_mineracao/domain/controllers/auth_controller.dart';
// import 'package:rc_mineracao/util/alerts.dart';
import 'package:school_match/ui/screens/forms/user_email_screen.dart';
import 'package:school_match/ui/widgets/acceptScreen/terms_of_use_box.dart';

class AcceptScreen extends StatefulWidget {
  const AcceptScreen({super.key});

  @override
  State<AcceptScreen> createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {
  @override
  void initState() {
    super.initState();
  }

  static const _meusTermos = '''
Bem-vindo! Estes Termos de Uso regulam o uso do aplicativo...
1. Coleta de Dados
   Explicamos como os dados são tratados...
2. Responsabilidades do Usuário
   Você concorda em não...
3. Licença de Uso
   Você recebe uma licença limitada...
4. Links úteis: https://minha-empresa.com/politica
... Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis id turpis neque. Morbi posuere erat id neque venenatis, a dignissim ipsum accumsan. Curabitur varius lobortis nibh, dapibus faucibus ex bibendum a. Nam accumsan sodales gravida. Sed feugiat dignissim scelerisque. Duis at turpis mauris. Aenean ultricies elementum ante, vitae egestas orci suscipit eu. Ut tristique dolor quis viverra fermentum. Ut posuere ultricies dolor sed semper. Sed congue neque dignissim enim faucibus imperdiet. Cras condimentum turpis dolor. Donec semper, diam ut condimentum tincidunt, tellus nunc ullamcorper tortor, nec aliquam odio nisi sit amet tortor. Etiam efficitur, dui vulputate viverra ultricies, risus risus tristique erat, sit amet semper urna leo ut eros. In eget mi lectus.

Mauris lobortis tellus commodo, tincidunt mauris a, viverra nunc. Etiam pharetra felis lectus, et accumsan diam placerat nec. Nulla vitae fringilla mauris. Fusce in diam a nisl aliquet finibus sed a lorem. Pellentesque ut rutrum ex, ut cursus nulla. Pellentesque eget rutrum nibh. Aenean vehicula at felis a facilisis. Maecenas ac dui justo. Proin vulputate mattis semper. In vitae odio at massa commodo auctor. Sed nibh diam, viverra at leo non, suscipit dapibus odio. Sed ut turpis dui. Sed in erat libero.

Curabitur vel malesuada nunc. Etiam eu lorem sit amet tellus congue ullamcorper sed quis lectus. Nunc non maximus sapien, in mollis est. Morbi augue est, vestibulum quis pretium vel, pharetra vel lacus. Proin malesuada tincidunt magna, sed ullamcorper turpis tristique sodales. Maecenas ac odio interdum leo suscipit blandit ac sodales felis. Nunc lobortis viverra ex, at commodo tellus vehicula vel. Etiam rhoncus nisi eu dapibus finibus. Morbi facilisis id eros id accumsan. Vestibulum pellentesque, nisl pharetra bibendum vehicula, justo ex dignissim augue, at volutpat magna orci in risus. Sed eu nulla suscipit, dictum tellus a, ullamcorper libero. Vestibulum tortor lacus, porttitor in arcu et, pulvinar lacinia purus. Praesent faucibus tincidunt vulputate. Nam dapibus, orci nec cursus consectetur, dui lorem ornare velit, nec dictum velit nisi in elit. Sed posuere dignissim augue, vel blandit nisi ullamcorper vitae. Fusce imperdiet tortor ut dolor pretium porttitor.

Sed auctor a tortor eu tristique. Cras scelerisque tellus sed nibh malesuada, eget lacinia leo ultrices. Suspendisse elementum condimentum lacus, ac sodales mi aliquet in. Fusce eu ante sit amet est condimentum vestibulum vel ac nunc. Nunc suscipit, felis ut luctus consectetur, mi augue varius augue, vel sollicitudin velit leo eget justo. Vivamus sed interdum quam, at semper arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nunc euismod vel nunc vel aliquet.

Integer vitae ante ut ante fringilla rhoncus. Aliquam molestie nec nunc in porttitor. In commodo luctus velit nec auctor. Duis urna nunc, laoreet eu ultricies ut, bibendum eu magna. Nulla convallis iaculis lacus, et rhoncus velit efficitur ut. Aenean eleifend ligula dolor, feugiat posuere arcu egestas ut. Nullam id tortor mauris. Phasellus at viverra mi. Nulla dictum malesuada cursus. Donec sodales neque eu diam aliquet fringilla. Praesent viverra porta tellus, sit amet fermentum tortor sagittis id. In massa eros, egestas eu mi sit amet, lacinia porta quam. Ut sed consectetur nulla, a bibendum mi.
''';



  bool _aceitou = false;

  aceitaTermos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserMailForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.07,
          left: MediaQuery.of(context).size.width * 0.07,
          right: MediaQuery.of(context).size.width * 0.07,
        ),
        child: ListView(children: <Widget>[
          SizedBox(
            child: Text(
              "Termos de uso:",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            child: Text(
              "Aceite nossos termos de uso para prosseguir com o cadastro",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          TermsOfUseBox(
            title: 'Termos de Uso',
            height: 260,
            termsText: _meusTermos,
            onAcceptedChanged: (v) => setState(() => _aceitou = v),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          SizedBox(
            child: Column(
              children: [
                SizedBox(
                  child: _aceitou
                      ? ElevatedButton(
                          style: Theme.of(context).filledButtonTheme.style,
                          onPressed: _aceitou
                              ? aceitaTermos
                              : null, // <— desabilita quando false
                          child: Text(
                            "EU ACEITO OS TERMOS",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                      : OutlinedButton(
                          onPressed: null,
                          child: Text(
                            "Aceite os termos para continuar",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
        ]),
      ),
    );
  }
}
