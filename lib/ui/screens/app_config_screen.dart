import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/services/user_service.dart';
import 'package:school_match/ui/screens/select_theme_screen.dart';
import 'package:school_match/ui/widgets/app_header.dart';
import 'package:school_match/util/alerts.dart';

class AppConfigScreen extends StatelessWidget {
  const AppConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    Future<void> _requestUserData() async {
      final userId = box.read('userId');
      if (userId == null) {
        Alerts.showErrorSnackBar('Usuário não encontrado.', context);
        return;
      }

      // Guarde o contexto da tela
      final rootContext = context;

      showDialog(
        context: rootContext,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: Theme.of(dialogContext).colorScheme.primary,
            title: const Text('Confirmar Ação'),
            content: const Text(
              'Você tem certeza que deseja solicitar todos os seus dados?',
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancelar',
                  style: Theme.of(dialogContext).textTheme.labelMedium,
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Confirmar',
                  style: Theme.of(dialogContext).textTheme.labelMedium,
                ),
                onPressed: () async {
                  // Feche o diálogo usando o contexto do diálogo
                  Navigator.of(dialogContext).pop();

                  try {
                    final response = await UserService
                        .requestUserData(userId.toString());

                    if (response.statusCode == 200) {
                      // Mostre o snackbar usando o contexto da tela
                      Alerts.showSuccessSnackBar(
                        'Sua solicitação foi enviada com sucesso! Verifique seu e-mail.',
                        rootContext,
                      );
                    } else {
                      Alerts.showErrorSnackBar(
                        'Ocorreu um erro ao solicitar seus dados.',
                        rootContext,
                      );
                    }
                  } catch (e) {
                    Alerts.showErrorSnackBar(
                      'Ocorreu um erro ao solicitar seus dados.',
                      rootContext,
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const AppHeader(),
            // Evite ListView dentro de Column sem Expanded
            Expanded(
              child: ListView(
                children: [
                  Text(
                    'Configurações do App',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.palette),
                    title: Text(
                      "Mudar Tema",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SelectThemeScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.data_usage),
                    title: Text(
                      "Solicitar meus dados",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: _requestUserData,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
