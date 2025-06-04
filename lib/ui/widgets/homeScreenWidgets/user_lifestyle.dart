import 'package:flutter/material.dart';
import 'package:school_match/domain/models/user_profile_model.dart';

class UserLifestyle extends StatefulWidget {
  final UserProfileModel candidate;

  const UserLifestyle({Key? key, required this.candidate}) : super(key: key);

  @override
  _UserLifestyleState createState() => _UserLifestyleState();
}

class _UserLifestyleState extends State<UserLifestyle> {
  @override
  Widget build(BuildContext context) {
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
                      Icons.loyalty,
                      size: 32,
                      color: Color(0xFFAAAAAA),
                    ),
                    Text(
                      " Estilo de Vida:",
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
                        "Pets?",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 14, color: Color(0xFFAAAAAA)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.pets, size: 24),
                          Text(" " + widget.candidate.userAbout!.pets.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 18)),
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
                        "Bebidas?",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 14, color: Color(0xFFAAAAAA)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.local_bar, size: 24),
                          Text(" " + widget.candidate.userAbout!.drink.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 18)),
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
                        "Fuma?",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 14, color: Color(0xFFAAAAAA)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.smoking_rooms_rounded, size: 24),
                          Text(" " + widget.candidate.userAbout!.smoker.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 18)),
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
                        "Atividade Física?",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 14, color: Color(0xFFAAAAAA)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.fitness_center, size: 24),
                          Text(" " + widget.candidate.userAbout!.physicalActivity.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 18)),
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
                        "Tipo de Rolê?",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 14, color: Color(0xFFAAAAAA)),
                      ),
                      Row(
                        children: [
                          Icon(Icons.celebration, size: 24),
                          Text(" " + widget.candidate.userAbout!.typeOfOuting.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 18)),
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
