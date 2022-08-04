import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/main_productpage.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  String search = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  search = val;
                });
              },
              decoration: const InputDecoration(
                  hintText: "Search Products",
                  fillColor: Colors.white,
                  icon: Icon(Icons.search),
                  border: InputBorder.none),
            ),
          ),
        ),
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
              if (search.isNotEmpty) {
                if (nextorder['Name'].toString().startsWith(search)) {
                  final ordertile = Card(
                    elevation: 20,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      minLeadingWidth: 20,
                      onTap: () {
                        // ref.child("Products/$key").remove();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainProductPage(
                                      category: nextorder['Category'],
                                      desc: nextorder['Description'],
                                      id: nextorder['id'],
                                      image: nextorder['image'],
                                      name: nextorder['Name'],
                                      price: nextorder['Price'],
                                      productkey: key,
                                      rating: nextorder['Rating'],
                                    )));
                      },
                      leading: Image(
                        image: NetworkImage(nextorder['image']),
                        width: 20,
                        height: 20,
                      ),
                      title: Text(nextorder['Name']),
                      subtitle: Text(nextorder['Description']),
                      trailing: Text("\$${nextorder['Price']}"),
                    ),
                  );
                  tilesList.add(ordertile);
                }
              } else if (search.isEmpty) {
                final ordertile = Card(
                  elevation: 20,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    minLeadingWidth: 20,
                    onTap: () {
                      // ref.child("Products/$key").remove();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainProductPage(
                                    category: nextorder['Category'],
                                    desc: nextorder['Description'],
                                    id: nextorder['id'],
                                    image: nextorder['image'],
                                    name: nextorder['Name'],
                                    price: nextorder['Price'],
                                    productkey: key,
                                    rating: nextorder['Rating'],
                                  )));
                    },
                    leading: Image(
                      image: NetworkImage(nextorder['image']),
                      width: 20,
                      height: 20,
                    ),
                    title: Text(nextorder['Name']),
                    subtitle: Text(nextorder['Description']),
                    trailing: Text("\$${nextorder['Price']}"),
                  ),
                );
                tilesList.add(ordertile);
              }
            });
          }
          return ListView(
            children: tilesList,
          );
        },
      ),
    );
  }
}
