// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_first/main.dart';

class CheckoutForm extends StatefulWidget {
  final String email;
  final String name;
  final int total;
  final Map<dynamic, dynamic> map;
  const CheckoutForm({
    Key? key,
    required this.email,
    required this.name,
    required this.total,
    required this.map,
  }) : super(key: key);

  @override
  State<CheckoutForm> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  var random = const Uuid().v1();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController cvcode = TextEditingController();
  TextEditingController expmonth = TextEditingController();
  TextEditingController expyear = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout Form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              (widget.email.isEmpty && widget.name.isEmpty)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 380.0,
                          child: TextField(
                            controller: email,
                            decoration: const InputDecoration(
                              hintText: "Enter Email",
                              labelText: "Email",
                              fillColor: Colors.purple,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 380.0,
                          child: TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              hintText: "Enter Name",
                              labelText: "Username",
                              fillColor: Colors.purple,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(),
              SizedBox(
                width: 380.0,
                child: TextField(
                  controller: accountnumber,
                  decoration: const InputDecoration(
                    hintText: "Enter Account Number",
                    labelText: "Account Number",
                    fillColor: Colors.purple,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 380.0,
                child: TextField(
                  controller: cvcode,
                  decoration: const InputDecoration(
                    hintText: "Enter Cv Code",
                    labelText: "Cv Code",
                    fillColor: Colors.purple,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 380.0,
                child: TextField(
                  controller: expmonth,
                  decoration: const InputDecoration(
                    hintText: "Enter Expiry Month",
                    labelText: "Expiry Month",
                    fillColor: Colors.purple,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 380.0,
                child: TextField(
                  controller: expyear,
                  decoration: const InputDecoration(
                    hintText: "Enter Expiry Year",
                    labelText: "Expiry Year",
                    fillColor: Colors.purple,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () async {
                      if (email.text.isEmpty && name.text.isEmpty) {
                        await ref.child("PaymentHistroy/$random").set({
                          "Email": widget.email,
                          "Name": widget.name,
                          "Total": (widget.total),
                          "Date": DateTime.now().toString(),
                          "OrderID": random,
                        });
                        widget.map.forEach(
                          (key, value) async {
                            var random2 = const Uuid().v1();
                            await ref.child("PurchaseItems/$random2").set({
                              "Orderid": random,
                              "ProductName": value["Product Name"],
                              "ProductId": key,
                              "ProductQuentity": value['Quentity'],
                            });
                          },
                        );
                        await ref.child("Cart").remove();
                      } else if (email.text.isNotEmpty &&
                          name.text.isNotEmpty) {
                        await ref.child("PaymentHistroy/$random").set({
                          "Email": email.text,
                          "Name": name.text,
                          "Total": (widget.total),
                          "Date": DateTime.now().toString(),
                          "OrderID": random,
                        });

                        widget.map.forEach(
                          (key, value) async {
                            var random2 = const Uuid().v1();
                            await ref.child("PurchaseItems/$random2").set({
                              "Orderid": random,
                              "ProductName": value["Product Name"],
                              "ProductId": key,
                              "ProductQuentity": value['Quentity'],
                            });
                          },
                        );
                        await ref.child("Cart").remove();

                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('successfull'),
                                content: const Text('Payment Has Been Success'),
                                actions: [
                                  ElevatedButton(
                                    child: const Text("Ok"),
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyHomePage(
                                                      email: '',
                                                      name: '',
                                                      status: false)),
                                          ModalRoute.withName("/"));
                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                    ),
                    child: const Text("Pay",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
