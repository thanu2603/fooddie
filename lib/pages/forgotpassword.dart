// ignore_for_file: avoid_unnecessary_containers, unnecessary_import, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddie/pages/signup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailcontroller = TextEditingController();
  String email = "";
  final _formkey = GlobalKey<FormState>();
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Password reset Email has been sent to your Email",
        style: TextStyle(fontSize: 18),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "No user has found with this Email",
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: const Text(
                "Password Recovery",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Enter your Email",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white70,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          controller: emailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email address';
                            }
                            return null;
                          },
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white70,
                              size: 30,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = emailcontroller.text;
                            });
                            resetPassword();
                          }
                        },
                        child: Container(
                          width: 140,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Send Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an Account? ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: const Text(
                              "Create",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
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
    );
  }
}
