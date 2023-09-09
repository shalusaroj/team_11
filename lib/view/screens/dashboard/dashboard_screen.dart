import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../blank.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreen();
}

class _DashBoardScreen extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const BlankScreen(),//const MyMatchScreen(),
    const BlankScreen(),//const WinnerScreen(),
    const BlankScreen(),//const WinnerScreen(),
    const ProfileScreen(),//const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white, // Set background color to white
              title: Text("Exit Confirmation"),
              content: Text("Do you want to exit the app?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Pop the dialog
                    SystemNavigator.pop(); // Exit the app
                  },
                  child: Text("Yes"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Pop the dialog
                  },
                  child: Text("No"),
                ),
              ],
            );
          },
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: _screens.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.stadium_outlined),
              label: 'My Match',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Rewards',
            ),
            BottomNavigationBarItem(
              icon:  Icon(Icons.card_giftcard),
              label: 'Winner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black45,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
