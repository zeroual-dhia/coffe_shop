import 'package:coffeshop/models/user.dart';
import 'package:coffeshop/routes/hero.dart';
import 'package:coffeshop/routes/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return const herosection();
    } else {
      print(user.uid);
      return const Home();
    }
  }
}
