import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/screens/forms/user_images.dart';
import 'package:school_match/ui/screens/forms/user_interests.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_about.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_basic_infos.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_extra_infos.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_lifestyle.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_list_images.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_list_interests.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_music.dart';
import 'package:school_match/util/functions.dart';

class ShowUserDetailsBottomsheet extends StatefulWidget {
  final UserProfileModel candidate;

  const ShowUserDetailsBottomsheet({Key? key, required this.candidate})
      : super(key: key);

  @override
  State<ShowUserDetailsBottomsheet> createState() =>
      _ShowUserDetailsBottomsheetState();
}

class _ShowUserDetailsBottomsheetState
    extends State<ShowUserDetailsBottomsheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "${widget.candidate.firstName} ${widget.candidate.lastName}",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontSize: 30),
            ),
            SizedBox(
              height: 5,
            ),
            UserListImages(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserAbout(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserBasicInfos(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserExtraInfos(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserListInterests(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserLifestyle(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserMusic(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
