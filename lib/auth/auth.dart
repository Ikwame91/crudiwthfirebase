import 'package:crud_with_firebase/ui/login.dart';
import 'package:crud_with_firebase/ui/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(login: toggleScreens);
    } else {
      return RegisterPage(
        register: toggleScreens,
      );
    }
  }
}
