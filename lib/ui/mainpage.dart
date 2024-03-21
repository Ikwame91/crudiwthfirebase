import 'package:crud_with_firebase/ui/homepage.dart';
import 'package:crud_with_firebase/ui/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return HomePage();
                    } else {
                      return LoginPage();
                    }
                  }));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
