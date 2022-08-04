// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/adminPages/productdetails.dart';

class ProductUpdate extends StatefulWidget {
  final String name;
  final String image;
  final int price;
  final String productkey;
  final String category;
  final String desc;
  const ProductUpdate({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.productkey,
    required this.category,
    required this.desc,
  }) : super(key: key);

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  TextEditingController productname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController desc = TextEditingController();
  @override
  void initState() {
    super.initState();
    productname.text = widget.name;
    price.text = "${widget.price}";
    category.text = widget.category;
    image.text = widget.image;
    desc.text = widget.desc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Update"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 380.0,
                child: TextFormField(
                  initialValue: widget.name,
                  onChanged: (val) {
                    productname.text = val;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Product Name",
                    labelText: "Name",
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
                child: TextFormField(
                  onChanged: (val) {
                    price.text = val;
                  },
                  initialValue: "${widget.price}",
                  decoration: const InputDecoration(
                    hintText: "Enter Product Price",
                    labelText: "Price",
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
                child: TextFormField(
                  initialValue: widget.category,
                  onChanged: (val) {
                    category.text = val;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Category",
                    labelText: "Category",
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
                child: TextFormField(
                  initialValue: widget.image,
                  onChanged: (val) {
                    image.text = val;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Image Url",
                    labelText: "Image",
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
                child: TextFormField(
                  initialValue: widget.desc,
                  onChanged: (val) {
                    desc.text = val;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter Description",
                    labelText: "Description",
                    fillColor: Colors.purple,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await ref.child("Products/${widget.productkey}").update({
                      "Name": productname.text,
                      "Price": int.parse(price.text),
                      "Category": category.text,
                      "image": image.text,
                      "Description": desc.text,
                    });
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('successfull'),
                            content: const Text('Product Detail Updated'),
                            actions: [
                              ElevatedButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductDetails()));
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: const Text("Update Product"))
            ],
          ),
        ),
      ),
    );
  }
}
