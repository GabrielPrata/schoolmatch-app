import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/home_page_controller.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/userCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();
  HomePageController homePageController = Get.put(HomePageController());
  late final List<Widget> cards;

  @override
  void initState() {
    super.initState();
    // Initialize the cards list after fetching data
    homePageController.createMockedDataForTest().then((_) {
      setState(() {
        cards = homePageController.profiles
            .map((candidate) => UserCard(candidate: candidate))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.88,
                // height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      child: Theme.of(context).brightness == Brightness.dark
                          ? Image.asset("assets/LogoSchoolMatchBranca.png")
                          : Image.asset("assets/LogoSchoolMatch.png"),
                    ),
                    Spacer(), // Empurra o conteúdo restante para a direita
                    IconButton(
                      color: Theme.of(context).colorScheme.onPrimary,
                      icon: Icon(Icons.tune),
                      onPressed: () {
                        // Adicione a ação desejada aqui
                        print("Tune icon pressed");
                      },
                      tooltip:
                          'Configurações', // Tooltip opcional para melhor acessibilidade
                    ),
                    IconButton(
                      color: Theme.of(context).colorScheme.onPrimary,
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        // Adicione a ação desejada aqui
                        print("Notifications icon pressed");
                      },
                      tooltip:
                          'Notificações', // Tooltip opcional para melhor acessibilidade
                    ),
                  ],
                ),
              ),
              if (cards != null && cards.isNotEmpty)
                Flexible(
                  child: CardSwiper(
                    controller: controller,
                    cardsCount: cards.length,
                    onSwipe: _onSwipe,
                    onUndo: _onUndo,
                    numberOfCardsDisplayed: 3,
                    allowedSwipeDirection: const AllowedSwipeDirection.only(
                        left: true, right: true),
                    backCardOffset: const Offset(0, -45),
                    padding: const EdgeInsets.all(24.0),
                    cardBuilder: (context, index, horizontalThresholdPercentage,
                            verticalThresholdPercentage) =>
                        cards[index],
                  ),
                ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //   FloatingActionButton(
              //       backgroundColor: Colors.red.shade600,
              //       onPressed: () => controller.swipe(CardSwiperDirection.left),
              //       child: const Icon(Icons.close)),
              //   SizedBox(
              //     width: 30,
              //   ),
              //   Container(
              //     height: 45,
              //     width: 45,
              //     child: FloatingActionButton(
              //         backgroundColor: Colors.amber.shade600,
              //         onPressed: controller.undo,
              //         child: const Icon(Icons.rotate_left)),
              //   ),
              //   SizedBox(
              //     width: 30,
              //   ),
              //   FloatingActionButton(
              //       backgroundColor: Colors.green.shade600,
              //       onPressed: () =>
              //           controller.swipe(CardSwiperDirection.right),
              //       child: const Icon(Icons.check)),
              // ]),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       FloatingActionButton(
              //           backgroundColor: Colors.amber.shade600,
              //           onPressed: controller.undo,
              //           child: const Icon(Icons.rotate_left)),
              //       FloatingActionButton(
              //           backgroundColor: Colors.red.shade600,
              //           onPressed: () =>
              //               controller.swipe(CardSwiperDirection.left),
              //           child: const Icon(Icons.close)),
              //       FloatingActionButton(
              //           backgroundColor: Colors.green.shade600,
              //           onPressed: () =>
              //               controller.swipe(CardSwiperDirection.right),
              //           child: const Icon(Icons.check)),
              //       // FloatingActionButton(
              //       //     onPressed: () =>
              //       //         controller.swipe(CardSwiperDirection.top),
              //       //     child: const Icon(Icons.keyboard_arrow_up)),
              //       // FloatingActionButton(
              //       //     onPressed: () =>
              //       //         controller.swipe(CardSwiperDirection.bottom),
              //       //     child: const Icon(Icons.keyboard_arrow_down)),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bool _onSwipe(
      int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    debugPrint(
        'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top');
    return true;
  }

  bool _onUndo(
      int? previousIndex, int currentIndex, CardSwiperDirection direction) {
    debugPrint('The card $currentIndex was undod from the ${direction.name}');
    return true;
  }
}
