import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final token;
  const Home({@required this.token, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.grey,
        body: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0,20,0,0),
              child: Text('Home'),
            )
          ],
        )
    );
  }
}
