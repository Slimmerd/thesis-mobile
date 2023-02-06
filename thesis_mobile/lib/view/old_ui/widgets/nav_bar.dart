import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF6200EE),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: (value) {
        // Respond to item press.
      },
      items: [
        BottomNavigationBarItem(
          label: 'Favorites',
          icon: Icon(Icons.favorite),
        ),
        BottomNavigationBarItem(
          label: 'Music',
          icon: Icon(Icons.music_note),
        ),
        BottomNavigationBarItem(
          label: 'Places',
          icon: Icon(Icons.location_on),
        ),
        BottomNavigationBarItem(
          label: 'News',
          icon: Icon(Icons.library_books),
        ),
      ],
    );
  }
}
