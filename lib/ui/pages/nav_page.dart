import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quotes_and_jokes/ui/shared/styles.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:quotes_and_jokes/ui/pages/jokes_page.dart';
import 'package:quotes_and_jokes/ui/pages/quotes_page.dart';
import 'package:quotes_and_jokes/ui/pages/favourites_page.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    JokesPage(),
    QuotesPage(),
    FavouritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(64.0),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.5)),
          ],
        ),
        child: GNav(
          gap: 8,
          iconSize: 20,
          activeColor: Colors.white,
          duration: Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: Icons.tag_faces,
              text: 'Jokes',
              iconColor: Colors.green,
              backgroundColor: Colors.green,
            ),
            GButton(
              icon: Icons.format_quote,
              text: 'Quotes',
              iconColor: Colors.blue,
              backgroundColor: Colors.blue,
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favourites',
              iconColor: Colors.red,
              backgroundColor: Colors.red,
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
