import 'package:coffeshop/models/showregister.dart';
import 'package:coffeshop/routes/login.dart';
import 'package:coffeshop/routes/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    final toggle = Provider.of<Showregister>(context);

    return toggle.showregister ? const Login() : const Register();
  }
}
