// ignore_for_file: avoid_unnecessary_containers, unnecessary_import, unused_import, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddie/service/shared_pref.dart';
import 'package:fooddie/widgets/widget_support.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet, id;
  int? add;
  TextEditingController amountcontroller = TextEditingController();

  getthesharedpref() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    getthesharedpref();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.only(top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Text(
                          "Wallet",
                          style: AppWidget.headlineTextFieldStyle(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xfff2f2f2),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/wallet.png",
                          height: 60,
                          width: 60,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Column(
                          children: [
                            Text(
                              "Your Wallet",
                              style: AppWidget.lightlineTextFieldStyle(),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Rs." + wallet!,
                              style: AppWidget.boldTextFieldStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Add money",
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE9E2E2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Rs." + "100",
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE9E2E2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Rs." + "500",
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE9E2E2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Rs." + "1000",
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE9E2E2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Rs." + "2000",
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xff008080),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Add Money",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
