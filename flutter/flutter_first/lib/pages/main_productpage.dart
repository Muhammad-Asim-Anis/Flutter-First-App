// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainProductPage extends StatefulWidget {
  final String name;
  final String image;
  final int price;
  final int rating;
  final int id;
  final String productkey;
  final String category;
  final String desc;

  const MainProductPage({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.id,
    required this.productkey,
    required this.category,
    required this.desc,
  }) : super(key: key);

  @override
  State<MainProductPage> createState() => _MainProductPageState();
}

class _MainProductPageState extends State<MainProductPage> {
  int count = 0;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("Products");
  DatabaseReference ref2 = FirebaseDatabase.instance.ref().child("Cart");
  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.name,
          style: const TextStyle(fontSize: 30),
        ),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.purple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Align(
            //   alignment: Alignment.center,
            //   child: Text(
            //     widget.name,
            //     style: GoogleFonts.davidLibre(
            //       fontSize: 30,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              color: const Color.fromARGB(255, 124, 6, 114),
              child: Image(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(widget.image),
                  width: 200,
                  height: 200,
                  alignment: Alignment.center),
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.justify,
                    widget.desc,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Price \$ ${widget.price}",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.davidLibre(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 200,
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () => setState(() {
                                  count++;
                                }),
                            child: const Icon(Icons.add)),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "$count",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () => setState(() {
                                  (count != 0) ? count-- : count = 0;
                                }),
                            child: const Icon(Icons.minimize))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: widget.rating.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) async {
                          await ref.child(widget.productkey).update({
                            "Rating": rating,
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 100,
                        child: Text(
                          "Total: \$${count * widget.price}",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (count != 0) {
                              await ref2.child(widget.productkey).set({
                                "Product Name": widget.name,
                                "Price": widget.price,
                                "Quentity": count,
                                "image": widget.image,
                              });

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('successfull'),
                                      content: const Text('Item Add to Cart'),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text("Ok"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('UnsuccessFull'),
                                      content: const Text(
                                          'Please Select The Quentity!'),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text("Ok"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                          },
                          child: const Text("Add to Cart")),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
