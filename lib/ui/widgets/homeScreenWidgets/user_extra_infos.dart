import 'package:flutter/material.dart';
import 'package:school_match/domain/models/user_profile_model.dart';

class UserExtraInfos extends StatefulWidget {
  final UserProfileModel candidate;

  const UserExtraInfos({Key? key, required this.candidate}) : super(key: key);

  @override
  _UserExtraInfosState createState() => _UserExtraInfosState();
}

class _UserExtraInfosState extends State<UserExtraInfos> {
  @override
  Widget build(BuildContext context) {
    // É uma boa prática extrair valores que podem ser nulos para facilitar a leitura
    final userAbout = widget.candidate.userAbout;
    final zodiacSign = userAbout?.zodiacSign?.toString() ?? "Não informado"; // <--- MODIFICADO
    final loveLanguage = userAbout?.loveLanguage?.toString() ?? "Não informado"; // <--- MODIFICADO

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .onError, // Use decoration to set color and borderRadius
        borderRadius: BorderRadius.circular(
            10), // Define the radius of the border corners
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 32,
                      color: Color(0xFFAAAAAA),
                    ),
                    Text(
                      " Informações Adicionais:",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Color(0xFFAAAAAA)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Signo",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 14, color: Color(0xFFAAAAAA)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.cake, size: 24),
                          Text(
                            " " + zodiacSign, // <--- MODIFICADO
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Semestre",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 14, color: Color(0xFFAAAAAA)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.square_foot, size: 24),
                          Text(
                            // Adicionando tratamento para semester também, por precaução
                            " ${widget.candidate.semester?.toString() ?? "Não informado"}", // <--- BOA PRÁTICA
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Linguagem do Amor",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 14, color: Color(0xFFAAAAAA)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.volunteer_activism, size: 24),
                          Text(
                            " $loveLanguage", // <--- MODIFICADO
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}