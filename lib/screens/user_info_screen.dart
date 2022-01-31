import 'package:dontpanic/res/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../res/pallete.dart';
import '../utils/authentication.dart';
import 'sign_in_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.whiteBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(height: 8.0),
                ],
              ),
              _user.photoURL != null
                  ? ClipOval(
                      child: Material(
                        color: Palette.firebaseGrey.withOpacity(0.3),
                        child: Image.network(
                          _user.photoURL!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        color: Palette.firebaseGrey.withOpacity(0.3),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Palette.firebaseGrey,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 16.0),
              Text(
                _user.displayName!,
                style: const TextStyle(
                  color: Palette.firebaseNavy,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 24.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Esta é sua mensagem de SOS.',
                      style: TextStyle(
                          color: Palette.firebaseNavy.withOpacity(0.8),
                          fontSize: 14,
                          letterSpacing: 0.2),
                    ),
                    Text(
                      'A localização atual será anexada no pedido de socorro.',
                      style: TextStyle(
                          color: Palette.firebaseNavy.withOpacity(0.8),
                          fontSize: 14,
                          letterSpacing: 0.2),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: Card(
                            color: Colors.greenAccent,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                Strings.patternMessage,
                              ),
                            ),
                          ),
                        ),
                        InkWell(child: Icon(Icons.edit))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              _isSigningOut
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.greenAccent,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _isSigningOut = true;
                        });
                        await Authentication.signOut(context: context);
                        setState(() {
                          _isSigningOut = false;
                        });
                        Navigator.of(context)
                            .pushReplacement(_routeToSignInScreen());
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'Sair',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
