// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/adminPages/admindrawer.dart';

class AdminPage extends StatefulWidget {
  final String email;
  final String name;
  final bool status;
  const AdminPage({
    Key? key,
    required this.email,
    required this.name,
    required this.status,
  }) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Map<dynamic, dynamic> data = {};
  int sum = 0;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  @override
  void initState() {
    super.initState();
    ref.child("PaymentHistroy").onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        sum += value["Total"] as int;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AdminPage"),
      ),
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            data = (snapshot.data as DatabaseEvent).snapshot.value
                as Map<dynamic, dynamic>;
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Wait!!!");
          }
          return Container(
            padding: const EdgeInsets.all(12.0),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 4.0),
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Products",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "${data["Products"].length}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Total Purchases"),
                            Text(
                              textAlign: TextAlign.center,
                              "\$$sum",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(5),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Total Users"),
                            Text(
                              textAlign: TextAlign.center,
                              "${data["Users"].length}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      drawer: AdminDrawer(name: widget.name, email: widget.email),
    );
  }
}
