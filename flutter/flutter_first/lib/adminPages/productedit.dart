import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProductEdit extends StatefulWidget {
  const ProductEdit({Key? key}) : super(key: key);

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  String uniquekey = "";
  int uniqueid = 0;
  TextEditingController productname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController productkey = TextEditingController();
  TextEditingController rating = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Add"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: ref.child("Products").onValue,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 380.0,
                      child: TextFormField(
                        controller: productname,
                        decoration: const InputDecoration(
                          hintText: "Enter Product Name",
                          labelText: "Name",
                          fillColor: Colors.purple,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 380.0,
                      child: TextFormField(
                        controller: price,
                        decoration: const InputDecoration(
                          hintText: "Enter Product Price",
                          labelText: "Price",
                          fillColor: Colors.purple,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 380.0,
                      child: TextFormField(
                        controller: category,
                        decoration: const InputDecoration(
                          hintText: "Enter Category",
                          labelText: "Category",
                          fillColor: Colors.purple,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 380.0,
                      child: TextFormField(
                        controller: image,
                        decoration: const InputDecoration(
                          hintText: "Enter Image Url",
                          labelText: "Image",
                          fillColor: Colors.purple,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 380.0,
                      child: TextFormField(
                        controller: rating,
                        decoration: const InputDecoration(
                          hintText: "Enter Product Rating",
                          labelText: "Rating",
                          fillColor: Colors.purple,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 380.0,
                      child: TextFormField(
                        controller: desc,
                        decoration: const InputDecoration(
                          hintText: "Enter Description",
                          labelText: "Description",
                          fillColor: Colors.purple,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await ref.child("Products/$uniquekey").set({
                            "Name": productname.text,
                            "Price": int.parse(price.text),
                            "Category": category.text,
                            "image": image.text,
                            "Description": desc.text,
                            "id": uniqueid,
                            "Rating": int.parse(rating.text),
                          });
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('successfull'),
                                  content: const Text('Product Detail Added'),
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
                        },
                        child: const Text("Add Product"))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
