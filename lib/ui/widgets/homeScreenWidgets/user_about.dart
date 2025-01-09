import 'package:flutter/material.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
class UserAbout extends StatefulWidget {
  final UserProfileModel candidate;

  const UserAbout({Key? key, required this.candidate}) : super(key: key);

  @override
  _UserAboutState createState() => _UserAboutState();
}

class _UserAboutState extends State<UserAbout> {
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
                      Icons.format_quote,
                      size: 32,
                      color: Color(0xFFAAAAAA),
                    ),
                    Text(
                      " Sobre mim:",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Color(0xFFAAAAAA)),
                    ),
                  ],
                ),
                Text(widget.candidate.bio.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
