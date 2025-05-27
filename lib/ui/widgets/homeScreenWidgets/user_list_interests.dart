import 'package:flutter/material.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
class UserListInterests extends StatefulWidget {
  final UserProfileModel candidate;

  const UserListInterests({Key? key, required this.candidate})
      : super(key: key);

  @override
  _UserListInterestsState createState() => _UserListInterestsState();
}

class _UserListInterestsState extends State<UserListInterests> {
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
                      Icons.interests,
                      size: 32,
                      color: Color(0xFFAAAAAA),
                    ),
                    Text(
                      " Interesses",
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
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Wrap(
                        spacing: 7.0,
                        runSpacing: 4.0,
                        children: widget.candidate.userInterests.map((item) {
                          return FilterChip(
                            label: Text(
                              item.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            onSelected: (bool selected) {
                              
                            },
                            selectedColor: Theme.of(context).colorScheme.secondary,
                            backgroundColor: Color(0xFF072675),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            showCheckmark: false,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20.0),
                      
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
