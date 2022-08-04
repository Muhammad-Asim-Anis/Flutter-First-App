import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/adminPages/productupdate.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Product Details"),
      ),
      body: StreamBuilder(
          stream: ref.child("Products").onValue,
          builder: (context, snapshot) {
            final tilesList = <Card>[];
            if (snapshot.hasData) {
              final data = (snapshot.data as DatabaseEvent).snapshot.value
                  as Map<dynamic, dynamic>;
              data.forEach((key, value) {
                final nextorder = Map<dynamic, dynamic>.from(value);

                final ordertile = Card(
                  elevation: 20,
                  margin: const EdgeInsets.all(10),
                  child: ExpansionTile(
                    leading: Image(
                      image: NetworkImage(nextorder['image']),
                      width: 20,
                      height: 20,
                    ),
                    title: Text(nextorder['Name']),
                    subtitle: Text(nextorder['Description']),
                    trailing: Text("\$${nextorder['Price']}"),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductUpdate(
                                              category: nextorder['Category'],
                                              desc: nextorder['Description'],
                                              image: nextorder['image'],
                                              name: nextorder['Name'],
                                              price: nextorder['Price'],
                                              productkey: key,
                                            )));
                              },
                              child: const Text("Update")),
                          ElevatedButton(
                              onPressed: () {
                                ref.child("Products/$key").remove();
                              },
                              child: const Text("Delete"))
                        ],
                      )
                    ],
                  ),
                );
                tilesList.add(ordertile);
              });
            }
            return ListView(
              children: tilesList,
            );
          }),
    );
  }
}
