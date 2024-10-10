import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/new_user_controller.dart';
import 'package:school_match/ui/screens/forms/user_like_find.dart';
import 'package:school_match/ui/widgets/forms/progress_bar.dart';
import 'package:school_match/util/alerts.dart';

class UserSexuality extends StatefulWidget {
  const UserSexuality({super.key});

  @override
  State<UserSexuality> createState() => _UserSexualityState();
}

NewUserController userController = Get.put(NewUserController());

class _UserSexualityState extends State<UserSexuality> {
  @override
  void initState() {
    userController.step += 1;
    super.initState();
  }

  salvarDados() {
    try {
      userController.setUserSexuality(
          selectedSexualityName, showSexualityInProfile);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UserLikeFind(),
        ),
      );
    } catch (e) {
      print(e);
      Alerts.showErrorSnackBar(e.toString(), context);
    }
  }

  late int selectedSexualityId =
      0; // Inicializa com 0 indicando nenhuma seleção
  late String selectedSexualityName = ""; // Inicializa vazio
  late bool showSexualityInProfile = true;

  final List<Map<String, dynamic>> sexualities = [
    {
      "id": 1,
      "name": "Heterossexual",
      "description":
          "Atração emocional, romântica e/ou sexual por pessoas do gênero oposto.",
      "selected": false
    },
    {
      "id": 2,
      "name": "Arromântico",
      "description":
          "Pessoas que não sentem atração romântica por outras. Elas podem formar conexões emocionais e sexuais, mas não têm interesse em relacionamentos românticos.",
      "selected": false
    },
    {
      "id": 3,
      "name": "Assexual",
      "description":
          "Falta ou baixa atração sexual por outras pessoas. Pessoas assexuais podem ter interesse em outras formas de relacionamento sem desejo sexual.",
      "selected": false
    },
    {
      "id": 4,
      "name": "Bissexual",
      "description":
          "Atração emocional, romântica e/ou sexual por mais de um gênero, incluindo homens e mulheres, mas também outras identidades de gênero.",
      "selected": false
    },
    {
      "id": 5,
      "name": "Gay",
      "description":
          "Geralmente se refere a homens que são atraídos por outros homens. Também pode ser usado como um termo guarda-chuva para pessoas que se atraem pelo mesmo gênero.",
      "selected": false
    },
    {
      "id": 6,
      "name": "Lésbica",
      "description":
          "Mulheres que são emocional, romântica e/ou sexualmente atraídas por outras mulheres.",
      "selected": false
    },
    {
      "id": 7,
      "name": "Onissexual",
      "description":
          "Atração emocional, romântica e/ou sexual por pessoas de todos os gêneros, com foco menos no gênero e mais na pessoa em si.",
      "selected": false
    },
    {
      "id": 8,
      "name": "Demissexual",
      "description":
          "Pessoas que só sentem atração sexual após desenvolver uma conexão emocional profunda com alguém.",
      "selected": false
    },
    {
      "id": 9,
      "name": "Pansexual",
      "description":
          "Atração emocional, romântica e/ou sexual por pessoas de qualquer gênero, onde a identidade de gênero não é um fator determinante.",
      "selected": false
    },
    {
      "id": 10,
      "name": "Queer",
      "description":
          "Termo guarda-chuva para descrever uma variedade de orientações sexuais e identidades de gênero fora da norma heterossexual e cisgênero.",
      "selected": false
    },
    {
      "id": 11,
      "name": "Questionando",
      "description":
          "Refere-se a pessoas que estão explorando sua identidade sexual ou de gênero e ainda não se identificam de forma definitiva com uma orientação.",
      "selected": false
    },
    {
      "id": 12,
      "name": "Não Listado",
      "description":
          "Indica que a pessoa sente que sua orientação sexual não está representada pelas categorias convencionais, preferindo um rótulo único ou personalizado.",
      "selected": false
    },
  ];

  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (result) {
        userController.step -= 1;
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
          ),
          child: ListView(children: <Widget>[
            ProgressBar(userController.step),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            SizedBox(
              child: Theme.of(context).brightness == Brightness.dark
                  ? Image.asset("assets/LogoSchoolMatchBranca.png")
                  : Image.asset("assets/LogoSchoolMatch.png"),
              height: 60,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
                child: Text(
              "Qual sua orientação sexual?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Column(
                    children: sexualities.map((sexuality) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0), // Ajuste do espaçamento
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0), // Tamanho do botão
                            backgroundColor: sexuality['selected']
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimary // Cor quando selecionado
                                : Theme.of(context)
                                    .primaryColor, // Cor quando não selecionado
                            side: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary, // Borda
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              sexualities.forEach((g) =>
                                  g['selected'] = false); // Desmarcar todos
                              sexuality['selected'] =
                                  true; // Marcar selecionado
                              selectedSexualityId = sexuality['id'];
                              selectedSexualityName = sexuality['name'];
                            });
                          },
                          child: SizedBox(
                            width: double.infinity, // Largura do botão
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sexuality['name'],
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: sexuality['selected']
                                              ? Theme.of(context)
                                                  .primaryColor // Cor do texto quando selecionado
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                        ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  Text(
                                    textAlign: TextAlign.left,
                                    sexuality['description'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: sexuality['selected']
                                              ? Theme.of(context)
                                                  .primaryColor // Cor do texto quando selecionado
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  SizedBox(
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.25,
                          child: Checkbox(
                            value: showSexualityInProfile,
                            onChanged: (bool? value) {
                              setState(() {
                                showSexualityInProfile = value!;
                              });
                            },
                            checkColor: Colors.white, // cor do tick
                            fillColor:
                                WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.selected)) {
                                return Theme.of(context)
                                    .colorScheme
                                    .secondary; // cor quando selecionado
                              }
                              return null; // cor padrão
                            }),
                          ),
                        ),
                        Text(
                          "Exibir no meu perfil",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ElevatedButton(
                    style: Theme.of(context).filledButtonTheme.style,
                    onPressed: () => salvarDados(),
                    child: Text(
                      "PRÓXIMO",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
