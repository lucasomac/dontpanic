import 'package:dontpanic/screens/dashboard_sos.dart';
import 'package:dontpanic/screens/secure_list.dart';
import 'package:dontpanic/screens/user_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Base extends StatefulWidget {
  // final User user;

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
    const SecureList(),
    const DashBoardSos(),
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
      appBar: AppBar(
        title: const Text('DontPanic'),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
