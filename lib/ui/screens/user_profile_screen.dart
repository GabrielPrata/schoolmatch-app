import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/user_profile_controller.dart';
import 'package:school_match/domain/services/account_service.dart';
import 'package:school_match/ui/screens/forms/user_bio.dart';
import 'package:school_match/ui/widgets/app_header.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_about.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_basic_infos.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_extra_infos.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_lifestyle.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_list_images.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_list_interests.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_music.dart';
import 'package:school_match/ui/widgets/matchesScreen/user_match_card.dart';
import 'package:school_match/util/alerts.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserProfileController controller = Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
    controller.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppHeader(),
                  const SizedBox(height: 20),
                  Text(
                    "${controller.userProfile.value.firstName} ${controller.userProfile.value.lastName}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  UserListImages(candidate: controller.userProfile.value),
                  const SizedBox(height: 20),
                  UserAbout(candidate: controller.userProfile.value),
                  const SizedBox(height: 20),
                  UserBasicInfos(candidate: controller.userProfile.value),
                  const SizedBox(height: 20),
                  UserExtraInfos(candidate: controller.userProfile.value),
                  const SizedBox(height: 20),
                  UserListInterests(candidate: controller.userProfile.value),
                  const SizedBox(height: 20),
                  UserLifestyle(candidate: controller.userProfile.value),
                  const SizedBox(height: 20),
                  UserMusic(candidate: controller.userProfile.value),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
