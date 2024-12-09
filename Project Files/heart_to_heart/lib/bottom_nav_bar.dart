import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) onItemSelected;

  const BottomNavBar({Key? key, required this.onItemSelected}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  void navigateNavBar(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index); // If item is selected, it will let parent know
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return BottomNavigationBar(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      items: const <BottomNavigationBarItem>[

        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Requests',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Home',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.handshake_rounded),
          label: 'Listings',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),

      ],

      currentIndex: selectedIndex,

      selectedItemColor: isDarkMode ? Colors.tealAccent : Colors.teal,

      unselectedItemColor: isDarkMode ? Colors.grey[500] : Colors.grey[600],

      showUnselectedLabels: true,

      showSelectedLabels: true,

      onTap: navigateNavBar,

      type: BottomNavigationBarType.fixed,
    );
  }
}
