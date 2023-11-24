import 'package:flutter/material.dart';
import 'package:flutterapps/pages/routes/dashboard.dart';
import 'package:flutterapps/pages/routes/bills.dart';
import 'package:flutterapps/pages/login.dart';

import 'package:flutterapps/user_services/storage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final secureStorage = SecureStorageService();
  var currentIndex = 0;
  var screens = [
    const Dashboard(),
    const Bills(),
  ];

  void logout(BuildContext context) async {
    await secureStorage.deleteTokens();
    if(!context.mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey,
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            switch(index) {
              case 0: setState(() => currentIndex = index);
              case 1: setState(() => currentIndex = index);
              case 2: logout(context);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Facturas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Cerrar sessión',
            )
          ],
        ),
    );


  }
}
