import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter_first/pages/products.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_first/pages/Register.dart';
import 'package:flutter_first/pages/app_drawer.dart';

import 'package:flutter_first/pages/home_drawer.dart';
import 'package:flutter_first/pages/login_page.dart';
import 'package:flutter_first/pages/main_productpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First Flutter APP',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          backgroundColor: const Color.fromARGB(255, 221, 213, 213),
          scaffoldBackgroundColor: const Color.fromARGB(255, 225, 229, 231)),
      home: const MyHomePage(
        email: '',
        name: '',
        status: false,
      ),
      routes: {
        '/Register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/Products': (context) => const ProductsPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String email;
  final String name;
  final bool status;
  const MyHomePage({
    Key? key,
    required this.email,
    required this.name,
    required this.status,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: StreamBuilder(
            stream: ref.child("Products").onValue,
            builder: (context, event) {
              final tilesList = <Card>[];
              if (event.hasData) {
                final data = (event.data as DatabaseEvent).snapshot.value
                    as Map<dynamic, dynamic>;

                data.forEach((key, value) {
                  final nextorder = Map<dynamic, dynamic>.from(value);
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
                });
              } else {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: [
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(imgList[1]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(imgList[2]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(imgList[3]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 150,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Products",
                      style: GoogleFonts.davidLibre(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      children: tilesList,
                    ),
                  ],
                ),
              );
            }),
        drawer: (widget.email.isNotEmpty &&
                widget.name.isNotEmpty &&
                widget.status == true)
            ? AppDrawer(name: widget.name, email: widget.email)
            : const HomeDrawer());
  }
}
