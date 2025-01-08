import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/ui/screens/forms/user_bio.dart';
import 'package:school_match/ui/screens/forms/user_blocks.dart';
import 'package:school_match/ui/screens/forms/user_spotify_music.dart';
import 'package:school_match/ui/screens/home_screen.dart';
import 'package:school_match/ui/screens/select_theme_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _page);
  }

  setSelectedPage(page) {
    setState(() {
      _page = page;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    UserBio(),
    UserSpotifyMusic(),
    SelectThemeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        buttonBackgroundColor: Theme.of(context).colorScheme.onPrimary,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.favorite, size: 30, color: _page != 0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,),
          Icon(Icons.chat_bubble, size: 30, color: _page != 1 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary),
          Icon(Icons.calendar_today, size: 30, color: _page != 2 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary),
          Icon(Icons.person, size: 30, color: _page != 3 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: Center(
        child: _widgetOptions.elementAt(_page),
      ),
    );
  }
}
