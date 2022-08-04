import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/adminPages/adminpage.dart';
import 'package:flutter_first/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Login> {
  var usernameGet = "", passwordGet = "";

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  late SharedPreferences login;
  @override
  Widget build(BuildContext context) {
    database(String email, String pass) {
      DatabaseReference ref = FirebaseDatabase.instance.ref().child("Users");
      ref.onValue.listen((event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) async {
          if (value['Email'] == email && value['Password'] == pass) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          name: value['Name'],
                          email: value['Email'],
                          status: true,
                        )));
          }
        });
      });
    }

    database2(String email, String pass) {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      ref.child("Admin").onValue.listen((event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) async {
          if (value['Email'] == email && value['Password'] == pass) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminPage(
                          name: value['Name'],
                          email: value['Email'],
                          status: true,
                        )));
          }
        });
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 50, left: 0)),
            Text(
              "Sign in",
              textAlign: TextAlign.center,
              style: GoogleFonts.davidLibre(
                textStyle:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            // Image(image: Image.asset("assets/images/signup.png")),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0)),

            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 380.0,
                    child: TextField(
                      controller: username,
                      decoration: const InputDecoration(
                        hintText: "Enter Username",
                        labelText: "Username",
                        fillColor: Colors.purple,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    width: 380.0,
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 1, color: Colors.purple)),
                    onPressed: () {
                      setState(() {
                        usernameGet = username.text;
                        passwordGet = password.text;

                        database(usernameGet, passwordGet);
                        database2(usernameGet, passwordGet);
                        username.clear();
                        password.clear();
                      });
                    },
                    child: const Text("Log in",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        side: const BorderSide(width: 1, color: Colors.purple),
                        backgroundColor: Colors.purple),
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, '/Register');
                        // username.clear();
                        // password.clear();
                      });
                    },
                    child: const Text("Register",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
