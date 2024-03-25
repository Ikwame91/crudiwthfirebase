import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_with_firebase/ui/homepage.dart';
import 'package:crud_with_firebase/widgets/custom_container.dart';
import 'package:crud_with_firebase/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback register;
  const RegisterPage({super.key, required this.register});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final confirmPassswdcontroller = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    ageController.dispose();
    emailController.dispose();
    confirmPassswdcontroller.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (!passwordConfirmed()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
      // Prevent signup process
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const HomePage()));

      addUserDetails(
        firstnameController.text.trim(),
        lastnameController.text.trim(),
        int.parse(ageController.text.trim()),
        emailController.text.trim(),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future addUserDetails(
      String firstname, String lastname, int age, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'firstname': firstname,
        'lastname': lastname,
        'age': age,
        'email': email,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPassswdcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.anchor,
                  size: 135,
                ),
                //Hello Again
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Hello There",
                  style: GoogleFonts.sairaStencilOne(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Register Below With Your Details",
                  style: GoogleFonts.bebasNeue(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                  controller: firstnameController,
                  hintText: "First Name",
                  obscureText: false,
                ),
                MyTextField(
                  controller: lastnameController,
                  hintText: "Last Name",
                  obscureText: false,
                ),
                MyTextField(
                  controller: ageController,
                  hintText: "Age",
                  obscureText: false,
                ),

                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                MyTextField(
                  controller: confirmPassswdcontroller,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                CustomContainer(
                  onTap: signUp,
                  text: "Register",
                ),

                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      ' Already a Memeber??',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: widget.register,
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
