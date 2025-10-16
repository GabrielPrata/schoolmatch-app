import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/controllers/matches_controller.dart';
import 'package:school_match/domain/models/homePageModels/user_like_model.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/widgets/app_header.dart';
import 'package:school_match/ui/widgets/matchesScreen/user_match_card.dart';
import 'package:school_match/util/alerts.dart';
import 'dart:math' as math;

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  MatchesController matchesController = Get.put(MatchesController());
  final List<UserProfileModel> items = []; // coloque seus dados aqui
  int _offset = 0; // quantos já foram consumidos
  final box = GetStorage();

  Future<void> _loadCards() async {
    matchesController.isLoading.trigger(true);
    try {
      await matchesController.getUserMatches();
      if (!mounted) return;

      setState(() {
        items
          ..clear()
          ..addAll(matchesController.profiles);
        _offset = 0;
      });
    } catch (e) {
      Alerts.showErrorSnackBar(
        e.toString().replaceAll("Exception: ", ""),
        context,
      );
    } finally {
      matchesController.isLoading.trigger(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCards(); // carrega perfis ao abrir a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (matchesController.isLoading.value) {
          return Container(
            color: Theme.of(context).colorScheme.primary,
            child: const SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                          strokeWidth: 6, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Text("Buscando seus Matchs..."),
                  ],
                ),
              ),
            ),
          );
        }

        final profiles = matchesController.profiles;

        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 5),
                AppHeader(),
                if (profiles.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Você ainda não possui nenhum Match! :(",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 16, bottom: 12),
                            child: Center(
                              child: Text("Seus Matches:",
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              itemCount: profiles.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 cards por linha
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 150 / 230,
                              ),
                              itemBuilder: (_, i) {
                                final p = profiles[i];

                                // primeira imagem base64 válida
                                String imageB64 = '';
                                if (p.images.isNotEmpty) {
                                  final first = p.images.firstWhere(
                                    (e) => (e ?? '').trim().isNotEmpty,
                                    orElse: () => null,
                                  );
                                  imageB64 = (first ?? '').trim();
                                }

                                final name = [
                                  p.firstName?.trim() ?? '',
                                  p.lastName?.trim() ?? '',
                                ].where((x) => x.isNotEmpty).join(' ').trim();
                                final displayName =
                                    name.isEmpty ? 'Usuário' : name;

                                return UserMatchCard(user: p);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
