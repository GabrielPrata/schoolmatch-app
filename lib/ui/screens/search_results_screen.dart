
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/controllers/home_page_controller.dart';
import 'package:school_match/domain/models/homePageModels/user_like_model.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/screens/home_screen.dart';
import 'package:school_match/ui/screens/menu_screen.dart';
import 'package:school_match/ui/widgets/app_header.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/userCard.dart';
import 'package:school_match/util/alerts.dart';
import 'dart:math' as math;

class SearchResultsScreen extends StatefulWidget {
  final List<UserProfileModel> searchResults;

  const SearchResultsScreen({super.key, required this.searchResults});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final CardSwiperController controller = CardSwiperController();
  HomePageController homePageController = Get.put(HomePageController());
  final List<UserProfileModel> items = [];
  int _offset = 0;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    items.addAll(widget.searchResults);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = (items.length - _offset).clamp(0, items.length);
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 5),
              AppHeader(),
              if (remaining == 0)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Não há mais perfis para mostrar."),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => Get.offAll(() => const MenuScreen()),
                          child: Text("Voltar para a Home",
                              style: Theme.of(context).textTheme.labelMedium),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Flexible(
                  child: CardSwiper(
                    key: ValueKey('swiper_$_offset'),
                    controller: controller,
                    cardsCount: remaining,
                    numberOfCardsDisplayed: math.min(remaining, 3),
                    allowedSwipeDirection:
                        const AllowedSwipeDirection.only(left: true, right: true),
                    backCardOffset: const Offset(0, -45),
                    padding: const EdgeInsets.all(24.0),
                    cardBuilder: (context, index, px, py) {
                      final realIndex = index + _offset;
                      if (realIndex < 0 || realIndex >= items.length) {
                        return const SizedBox.shrink();
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
      ),
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
