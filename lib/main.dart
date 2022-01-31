import 'package:dontpanic/res/strings.dart';
import 'package:dontpanic/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      darkTheme: Theme.of(context),
      theme: ThemeData(
          primaryColor: Colors.white,
          backgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.greenAccent),
          inputDecorationTheme: InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent)))
          // inputDecorationTheme: const InputDecorationTheme(
          //   focusedBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(color: Colors.greenAccent),
          //   ),
          // ),
          ),
      home: const SignInScreen(),
    );
  }
}
