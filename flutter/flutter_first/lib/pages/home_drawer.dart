import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/cart.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.purple,
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                accountName: const Text("Name: Guest "),
                accountEmail: const Text("Email: Guest"),
                currentAccountPicture: Image.asset(
                  'assets/images/signin.png',
                  width: 200,
                  height: 400,
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
                      builder: (context) => const Cart(email: '', name: ''),
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
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              leading: const Icon(
                CupertinoIcons.arrow_right_circle_fill,
                color: Colors.white,
              ),
              title: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              )),
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/Register');
              },
              leading: const Icon(
                CupertinoIcons.person,
                color: Colors.white,
              ),
              title: const Text(
                "Register",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
