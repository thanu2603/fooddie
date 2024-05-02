// ignore_for_file: unnecessary_import, avoid_function_literals_in_foreach_calls, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddie/admin/home_admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededeb),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 53, 51, 51),
                      Colors.black,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110))),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 20, top: 60),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const Text(
                        "Let's start with \n       Admin",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 5,
                                  bottom: 5,
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 160, 160, 147)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: usernamecontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter UserName';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "UserName",
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 160, 160, 147),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 5,
                                  bottom: 5,
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 160, 160, 147)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: passwordcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Password';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 160, 160, 147),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              GestureDetector(
                                onTap: () {
                                  LoginAdmin();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then(
      (snapshot) {
        snapshot.docs.forEach(
          (result) {
            if (result.data()['id'] != usernamecontroller.text.trim()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.orangeAccent,
                  content: Text(
                    "Your Id is incorrect",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            } else if (result.data()['password'] !=
                passwordcontroller.text.trim()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.orangeAccent,
                  content: Text(
                    "Your password is incorrect",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              );
            } else {
              Route route =
                  MaterialPageRoute(builder: (context) => const HomeAdmin());
              Navigator.pushReplacement(context, route);
            }
          },
        );
      },
    );
  }
}
