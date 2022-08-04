import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/adminPages/adminpage.dart';
import 'package:flutter_first/adminPages/productEdit.dart';
import 'package:flutter_first/adminPages/productdetails.dart';
import '../main.dart';

class AdminDrawer extends StatefulWidget {
  final String name, email;

  const AdminDrawer({super.key, required this.name, required this.email});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  String uniquekey = "";
  int uniqueid = 0;
  @override
  void initState() {
    super.initState();
    display();
  }

  display() {
    ref.child("Products").onValue.listen((event) {
      String key = "";
      int key2 = 0;
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      var data2 = data.keys.toList()..sort();
      uniqueid = 0;
      uniquekey = "";
      key = data2.last;
      key2 = int.parse(key.substring(7));
      key2++;
      uniquekey += "Product$key2";
      uniqueid += key2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple,
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                accountName: Text("Name: ${widget.name} "),
                accountEmail: Text("Email: ${widget.email}"),
                currentAccountPicture: const CircleAvatar(
                  maxRadius: 20,
                  child: Icon(Icons.person, size: 50),
                ),
              )),
          ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminPage(
                          email: widget.email,
                          name: widget.name,
                          status: true)),
                );
              },
              leading: const Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: const Text(
                "Home",
                style: TextStyle(color: Colors.white),
              )),
          ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductEdit()));
              },
              leading: const Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
              title: const Text(
                "Products Edit",
                style: TextStyle(color: Colors.white),
              )),
          ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductDetails()));
              },
              leading: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Products Details",
                style: TextStyle(color: Colors.white),
              )),
          ListTile(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                            email: '', name: '', status: false)),
                    ModalRoute.withName("/"));
              },
              leading: const Icon(
                CupertinoIcons.arrow_left_circle,
                color: Colors.white,
              ),
              title: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
