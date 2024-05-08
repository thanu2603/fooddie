// ignore_for_file: avoid_unnecessary_containers, unnecessary_import, sized_box_for_whitespace, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unused_local_variable, unused_import

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddie/pages/wallet.dart';
import 'package:fooddie/service/database.dart';
import 'package:fooddie/service/shared_pref.dart';
import 'package:fooddie/widgets/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id, wallet;
  Stream? foodStream;
  int total = 0, amount = 0;

  void startTimer() {
    Timer(const Duration(seconds: 1), () {
      amount = total;
      setState(() {});
    });
  }

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    foodStream = await DatabaseMethods().getFoodCart(id!);
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Widget FoodCart() {
    return StreamBuilder(
      stream: foodStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  total = total + int.parse(ds["Total"]);
                  return Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 90,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(),
                              ),
                              child: Center(child: Text(ds["Quantity"])),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                ds["Image"],
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ds["Name"],
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                ),
                                Text(
                                  "Rs." + ds["Total"],
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                child: Center(
                  child: Text(
                    "Cart",
                    style: AppWidget.headlineTextFieldStyle(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                child: FoodCart()),
            const Spacer(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Text(
                    "Rs." + total.toString(),
                    style: AppWidget.headlineTextFieldStyle(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Wallet()));
                int price = int.parse(wallet!) - amount;
                await DatabaseMethods().UpdateUserWallet(id!, price.toString());
                await SharedPreferenceHelper().saveUserWallet(price.toString());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: const Center(
                  child: Text(
                    "CheckOut",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
