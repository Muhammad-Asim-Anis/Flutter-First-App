import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_first/pages/cart.dart';

import '../main.dart';

class AppDrawer extends StatefulWidget {
  final String name, email;

  const AppDrawer({super.key, required this.name, required this.email});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
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
          const ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              )),
          ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Cart(email: widget.email, name: widget.name),
                    ));
              },
              leading: const Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ),
              title: const Text(
                "Cart",
                style: TextStyle(color: Colors.white),
              )),
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/Products');
              },
              leading: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Products",
                style: TextStyle(color: Colors.white),
              )),
          const ListTile(
              leading: Icon(
                Icons.change_circle_outlined,
                color: Colors.white,
              ),
              title: Text(
                "Change Password",
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
