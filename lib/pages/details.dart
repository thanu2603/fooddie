// ignore_for_file: avoid_unnecessary_containers, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddie/widgets/widget_support.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          top: 50,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            Image.asset(
              "images/salad2.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Veggie ",
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                    Text(
                      "Taco Hash",
                      style: AppWidget.boldTextFieldStyle(),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                    }
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  a.toString(),
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    ++a;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Veggie taco hash is a delicious and nutritious dish that combines the flavors of the Southwest with the convenience of a one-pot meal.",
              maxLines: 4,
              style: AppWidget.lightlineTextFieldStyle(),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text("Delivery Time",
                    style: AppWidget.semiBoldTextFieldStyle()),
                const SizedBox(
                  width: 25,
                ),
                const Icon(
                  Icons.alarm,
                  color: Colors.black54,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "30 mins",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),
                      Text(
                        "\$25",
                        style: AppWidget.headlineTextFieldStyle(),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Add to cart",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Poppins'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Icon(Icons.shopping_cart_outlined),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
