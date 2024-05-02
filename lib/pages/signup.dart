// ignore_for_file: avoid_unnecessary_containers, unnecessary_import, unnecessary_null_comparison, unused_local_variable, use_build_context_synchronously, body_might_complete_normally_nullable

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:fooddie/pages/bottomnav.dart";
import "package:fooddie/pages/login.dart";
import "package:fooddie/widgets/widget_support.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "", confirm = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Registered Succesfully",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNav()));
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.grey,
              content: Text(
                "Password provided is too weak",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.grey,
              content: Text(
                "Account already exists",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 255, 48, 48),
                      Color.fromARGB(255, 63, 234, 243),
                    ]),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: const Text(""),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 60,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "images/logo.png",
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Material(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Sign Up",
                              style: AppWidget.headlineTextFieldStyle(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: namecontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'User Name',
                                hintStyle: AppWidget.lightlineTextFieldStyle(),
                                prefixIcon: const Icon(Icons.person),
                                suffixIcon: const Icon(Icons.clear),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: emailcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your E-mail';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Email Address',
                                hintStyle: AppWidget.lightlineTextFieldStyle(),
                                prefixIcon: const Icon(Icons.email_outlined),
                                suffixIcon: const Icon(Icons.clear),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              controller: passwordcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: AppWidget.lightlineTextFieldStyle(),
                                prefixIcon:
                                    const Icon(Icons.lock_open_outlined),
                                suffixIcon: const Icon(Icons.visibility),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                hintStyle: AppWidget.lightlineTextFieldStyle(),
                                prefixIcon:
                                    const Icon(Icons.lock_open_outlined),
                                suffixIcon: const Icon(Icons.visibility),
                              ),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    email = emailcontroller.text;
                                    name = namecontroller.text;
                                    password = passwordcontroller.text;
                                  });
                                  registration();
                                }
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffff5722),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an Account?",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 16,
                                        fontFamily: 'Brand Bold',
                                        fontWeight: FontWeight.w500),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LogIn()));
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontFamily: 'Brand Bold',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
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
    );
  }
}
