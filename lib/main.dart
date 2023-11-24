import 'package:flutter/material.dart';
import 'package:flutterapps/pages/login.dart';
import 'package:flutterapps/pages/home.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/Login',
    routes: {
      '/': (context) => const Home(),
      '/Login': (context) => const Login(),
    }
));

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Omkiner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Login()
    );
  }
}

