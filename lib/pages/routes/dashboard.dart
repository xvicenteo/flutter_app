import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapps/user_services/api.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Map<String, dynamic> bills = HashMap();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMonthlyBills();
  }

  Future<void> getMonthlyBills() async {
    API api = API();
    await api.getMonthlyBills(context);

    setState(() {
      bills = api.monthlyBills;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView.builder(
        itemCount: bills.length,
        itemBuilder: (context, int index) {
          String key = bills.keys.elementAt(index);
          return Card(
            child: ListTile(
              onTap: () {},
              title: Text(key),
            ),
          );
        }
      ),
    );
  }
}
