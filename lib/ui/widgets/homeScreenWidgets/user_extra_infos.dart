import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/show_user_details_bottomsheet.dart';
import 'package:school_match/util/functions.dart';

class UserExtraInfos extends StatefulWidget {
  final UserProfileModel candidate;

  const UserExtraInfos({Key? key, required this.candidate}) : super(key: key);

  @override
  _UserExtraInfosState createState() => _UserExtraInfosState();
}

class _UserExtraInfosState extends State<UserExtraInfos> {
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
                          Text(" " + widget.candidate.zodiacSign.toString(),
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
                          Text(" " + widget.candidate.semester.toString(),
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
                          Text(" " + widget.candidate.loveLanguage.toString(),
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
