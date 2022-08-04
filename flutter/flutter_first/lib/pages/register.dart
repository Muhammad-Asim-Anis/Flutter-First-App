import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController confirmpassword = TextEditingController();
    TextEditingController phone = TextEditingController();

    database(
      String name,
      String pass,
      String email,
      String phone,
    ) {
      var random = const Uuid().v1();

      DatabaseReference ref = FirebaseDatabase.instance.ref().child("Users");

      ref.onValue.listen((event) async {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          if (value['Email'] == email && value['Password'] == pass) {
            setState(() {
              count++;
            });
          }
        });

        if (count == 0) {
          await ref.child(random).set({
            "id": random,
            "Name": name,
            "Phone": phone,
            "Email": email,
            "Password": pass
          });
          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('successfull'),
                  content: const Text('Register Success'),
                  actions: [
                    ElevatedButton(
                      child: const Text("Ok"),
                      onPressed: () {
                        Navigator.pushNamed(context, "/");
                      },
                    ),
                  ],
                );
              });
        } else {
          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Unsuccessfull'),
                  content: const Text('Already Register'),
                  actions: [
                    ElevatedButton(
                      child: const Text("Yes"),
                      onPressed: () {
                        Navigator.pushNamed(context, "/Register");
                      },
                    ),
                    ElevatedButton(
                      child: const Text("No"),
                      onPressed: () {
                        Navigator.pushNamed(context, "/");
                      },
                    ),
                  ],
                );
              });
        }
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top: 50, left: 0)),
              Text(
                "Register",
                textAlign: TextAlign.center,
                style: GoogleFonts.davidLibre(
                  textStyle: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0)),
              SizedBox(
                width: 380.0,
                child: TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    hintText: "Enter Email",
                    labelText: "Email",
                    fillColor: Colors.purple,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 380.0,
                child: TextField(
                  controller: username,
                  decoration: const InputDecoration(
                    hintText: "Enter Username",
                    labelText: "Username",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 380.0,
                child: TextField(
                  controller: phone,
                  decoration: const InputDecoration(
                    hintText: "Enter Phone Number",
                    labelText: "Phone Number",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 380.0,
                child: TextField(
                  controller: confirmpassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Enter Confirm Password",
                    labelText: "Confirm Password",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.purple)),
                  onPressed: () {
                    if (password.text == confirmpassword.text ||
                        username.text.isNotEmpty &&
                            password.text.isNotEmpty &&
                            phone.text.isNotEmpty &&
                            email.text.isNotEmpty &&
                            confirmpassword.text.isNotEmpty) {
                      database(
                          username.text, password.text, email.text, phone.text);
                      username.clear();
                      password.clear();
                      email.clear();
                      phone.clear();
                      confirmpassword.clear();
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text('Unsuccessfull'),
                              content: Text(
                                  'Password didnt match with confirm password'),
                            );
                          });
                    }
                  },
                  child: const Text("Register",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
