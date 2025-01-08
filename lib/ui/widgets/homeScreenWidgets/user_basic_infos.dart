import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/show_user_details_bottomsheet.dart';
import 'package:school_match/util/functions.dart';

class UserBasicInfos extends StatefulWidget {
  final UserProfileModel candidate;

  const UserBasicInfos({Key? key, required this.candidate}) : super(key: key);

  @override
  _UserBasicInfosState createState() => _UserBasicInfosState();
}

class _UserBasicInfosState extends State<UserBasicInfos> {
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
                      Icons.badge,
                      size: 32,
                      color: Color(0xFFAAAAAA),
                    ),
                    Text(
                      " Informações Básicas:",
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
                Row(
                  children: [
                    Icon(
                      Icons.cake,
                      size: 24,
                    ),
                    Text(" " + widget.candidate.course.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 16)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.school,
                      size: 24,
                    ),
                    Text(
                        " ${Functions.calculateAge(widget.candidate.birthDate!)} anos",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 16)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 24,
                    ),
                    Text(widget.candidate.city.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 16)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                widget.candidate.showSexuality!
                    ? Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 24,
                          ),
                          Text(" " + widget.candidate.sexuality.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 16)),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
