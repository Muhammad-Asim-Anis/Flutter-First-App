// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/checkout_form.dart';
import 'package:uuid/uuid.dart';

class CheckoutPage extends StatefulWidget {
  final String email;
  final String name;

  const CheckoutPage({
    Key? key,
    required this.email,
    required this.name,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  int count = 0;
  int sum = 0;
  int tex = 3;
  var random = const Uuid().v1();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController cvcode = TextEditingController();
  TextEditingController expmonth = TextEditingController();
  TextEditingController expyear = TextEditingController();
  Map<dynamic, dynamic> map = {};
  @override
  void initState() {
    super.initState();
    display();
  }

  display() {
    ref.child("Cart").onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;

        sum = 0;
        for (var element in data.values) {
          sum += element['Price'] * element['Quentity'] as int;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Checkout'),
      ),
      body: StreamBuilder(
          stream: ref.child("Cart").onValue,
          builder: (context, event) {
            final tilesList = <Card>[];
            if (event.hasData &&
                ((event.data as DatabaseEvent).snapshot.value) != null) {
              final data = (event.data as DatabaseEvent).snapshot.value
                  as Map<dynamic, dynamic>;
              if (data.isNotEmpty) {
                data.forEach((key, value) {
                  final nextorder = Map<dynamic, dynamic>.from(value);

                  final ordertile = Card(
                    elevation: 20,
                    margin: const EdgeInsets.all(10),
                    child: ExpansionTile(
                      title: Text(nextorder['Product Name']),
                      leading: Image(
                        image: NetworkImage("${nextorder['image']}"),
                        width: 30,
                        height: 30,
                      ),
                      subtitle: Text("\$${nextorder['Price']}"),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  count = nextorder['Quentity'];
                                  count++;
                                  await ref.child("Cart/$key").update({
                                    "Quentity": count,
                                  });
                                },
                                child: const Icon(Icons.add)),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "${nextorder['Quentity']}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  count = nextorder['Quentity'];
                                  (count != 0) ? count-- : count = 0;

                                  await ref.child("Cart/$key").update({
                                    "Quentity": count,
                                  });
                                },
                                child: const Icon(Icons.remove)),
                            ElevatedButton(
                                onPressed: () {
                                  ref.child("Cart/$key").remove();
                                },
                                child: const Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  );
                  tilesList.add(ordertile);
                });
              }
            } else if (event.connectionState == ConnectionState.active) {
              return const Center(
                  child: Text(
                "Cart is Empty",
                style: TextStyle(fontSize: 30),
              ));
            } else if (event.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: tilesList,
                  ),
                  Card(
                    color: Colors.purple,
                    elevation: 20,
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                          width: double.infinity,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "SubTotal:",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "\$$sum",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                          width: double.infinity,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Tex:",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "\$$tex",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 300,
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Total:",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "\$${sum + tex}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.child("Cart").onValue.listen((event) async {
                              if (event.snapshot.value != null) {
                                map = event.snapshot.value
                                    as Map<dynamic, dynamic>;
                              }
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutForm(
                                    email: widget.email,
                                    name: widget.name,
                                    total: (sum + tex),
                                    map: map,
                                  ),
                                ));
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          child: const Text("Payment",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
