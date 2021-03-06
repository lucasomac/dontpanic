import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../res/strings.dart';
import 'home.dart';
import 'secure_list.dart';
import 'user_info_screen.dart';

final appKey = GlobalKey();

class Base extends StatefulWidget {
  const Base({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  static late User loggedUser;
  int _selectedIndex = 1;
  static final List<Widget> _widgetOptions = <Widget>[
    SecureList(loggedUser.email!),
    Home(loggedUser),
    loggedUser.photoURL != null
        ? UserInfoScreen(user: loggedUser)
        : const Text('Nao Logado')
  ];

  @override
  void initState() {
    loggedUser = widget._user;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: appKey,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const Text(
          Strings.appName,
          style: TextStyle(color: Colors.black54),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.black87,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_agenda,
            ),
            label: Strings.menuAgenda,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Strings.menuHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: Strings.menuProfile,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
