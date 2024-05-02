// ignore_for_file: avoid_unnecessary_containers, unnecessary_import, sized_box_for_whitespace, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddie/pages/details.dart';
import 'package:fooddie/service/database.dart';
import 'package:fooddie/widgets/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;
  Stream? fooditemStream;

  ontheload() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Details()));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  ds["Image"],
                                  height: 130,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  ds["Name"],
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                ),
                                Text(
                                  "Fresh & Healthy",
                                  style: AppWidget.lightlineTextFieldStyle(),
                                ),
                                Text(
                                  ds["Price"],
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : const CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 50,
            left: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hola, Thanuja",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Container(
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.only(
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Delicious Food",
                textAlign: TextAlign.start,
                style: AppWidget.headlineTextFieldStyle(),
              ),
              Text(
                "Discover and get Tasty Food..",
                textAlign: TextAlign.start,
                style: AppWidget.lightlineTextFieldStyle(),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  margin: const EdgeInsets.only(right: 20), child: showItem()),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 6,
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/salad3.png",
                                height: 130,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "Veggie Chopped Salad",
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                              Text(
                                "Spicy with oninon",
                                style: AppWidget.lightlineTextFieldStyle(),
                              ),
                              Text(
                                "\$40",
                                style: AppWidget.semiBoldTextFieldStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/salad4.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "Roasted Veggie Potato Salad",
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "Honey goot cheese",
                                      style:
                                          AppWidget.lightlineTextFieldStyle(),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "\$28",
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 20), // Add some space between the containers
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/salad_2.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "Mixed Veg Salad",
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "Fresh Veggie Delight",
                                      style:
                                          AppWidget.lightlineTextFieldStyle(),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "\$28",
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: icecream ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Image.asset(
                "images/ice-cream.png",
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: pizza ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Image.asset(
                "images/pizza.png",
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: salad ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Image.asset(
                "images/salad.png",
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            setState(() {});
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: burger ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Image.asset(
                "images/burger.png",
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
