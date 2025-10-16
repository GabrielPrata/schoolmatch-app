import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/controllers/home_page_controller.dart';
import 'package:school_match/domain/models/homePageModels/user_like_model.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/widgets/app_header.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/userCard.dart';
import 'package:school_match/util/alerts.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();
  HomePageController homePageController = Get.put(HomePageController());
  final List<UserProfileModel> items = []; // coloque seus dados aqui
  int _offset = 0; // quantos já foram consumidos
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    // Initialize the cards list after fetching data
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCards());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _loadCards() async {
    homePageController.isLoading.trigger(true);
    try {
      await homePageController.getUsersDefault();
      if (!mounted) return;

      setState(() {
        items
          ..clear()
          ..addAll(homePageController.profiles); // preenche items
        _offset = 0;
      });
    } catch (e) {
      Alerts.showErrorSnackBar(
        e.toString().replaceAll("Exception: ", ""),
        context,
      );
    } finally {
      homePageController.isLoading.trigger(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final remaining = (items.length - _offset).clamp(0, items.length);
    return Scaffold(
      body: Obx(() {
        if (homePageController.isLoading.value) {
          // LOADING
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
                        strokeWidth: 6,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Buscando Usuários..."),
                  ],
                ),
              ),
            ),
          );
        }

        // HEADER + CONTEÚDO
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 5),
                AppHeader(),

                // ESTADO VAZIO
                if (remaining == 0)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Não há perfis para mostrar agora."),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _loadCards,
                            child: Text("Tentar novamente",
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  // SWIPER SEGURO
                  Flexible(
                    child: CardSwiper(
                      key: ValueKey('swiper_$_offset'),
                      controller: controller,
                      cardsCount: remaining,
                      numberOfCardsDisplayed:
                          math.min(remaining, 3), // <= usa remaining
                      allowedSwipeDirection: const AllowedSwipeDirection.only(
                          left: true, right: true),
                      backCardOffset: const Offset(0, -45),
                      padding: const EdgeInsets.all(24.0),
                      cardBuilder: (context, index, px, py) {
                        final realIndex = index + _offset;
                        if (realIndex < 0 || realIndex >= items.length) {
                          return const SizedBox.shrink(); // fallback seguro
                        }
                        final item = items[realIndex];
                        return UserCard(
                          key: ValueKey<int>(item.userId),
                          candidate: item,
                        );
                      },

                      onSwipe: _onSwipe,
                      onUndo: _onUndo,
                      onEnd: () {
                        // (opcional) limpeza depois que acabar a pilha
                        if (_offset > 0) {
                          setState(() {
                            items.removeRange(0, _offset);
                            _offset = 0;
                          });
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  bool _onSwipe(
      int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    final absoluteIndex = previousIndex + _offset;

    try {
      if (direction == CardSwiperDirection.right) {
        final receiverId = items[absoluteIndex].userId;
        final senderId = box.read("userId") as int?;
        if (receiverId != null && senderId != null) {
          homePageController
              .sendUserLike(
                  UserLikeModel(senderId: senderId, recieverId: receiverId),
                  context)
              .catchError((e) => Alerts.showErrorSnackBar(
                  e.toString().replaceAll("Exception: ", ""), context));
        }
      }

      // Atualize o ponteiro DEPOIS do rebuild do frame atual
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (_offset < items.length) {
          setState(() => _offset++);
        }
      });

      return true;
    } catch (e) {
      Alerts.showErrorSnackBar(
          e.toString().replaceAll("Exception: ", ""), context);
      return false;
    }
  }

  bool _onUndo(
      int? previousIndex, int currentIndex, CardSwiperDirection direction) {
    debugPrint('The card $currentIndex was undod from the ${direction.name}');
    return true;
  }
}
