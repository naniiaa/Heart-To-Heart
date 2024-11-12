import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget
{
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
{
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>
  [
    Text(
      'Index 0: Message',
      style: optionStyle,
    ),
    Text(
      'Index 1: Home',
      style: optionStyle,
    ),
    Text(
      'Index 2: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {

    setState(()
    {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
     body: Center(
       child: _widgetOptions.elementAt(_selectedIndex),
     ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>
          [
            BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Messages'
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Home'
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings'
            )
          ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}
