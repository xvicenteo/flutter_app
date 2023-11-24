import 'package:flutter/material.dart';
import 'package:flutterapps/pages/login.dart';
import 'package:flutterapps/pages/home.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

void main() => runApp(MaterialApp(
    initialRoute: '/Login',
    navigatorKey: navKey,
    routes: {
      '/': (BuildContext context) => const Home(),
      '/Login': (BuildContext context) => const Login(),

    }
));

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('fdhusihfiudas');
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



