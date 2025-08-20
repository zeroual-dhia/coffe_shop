import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff212325),
      body: Center(child: SpinKitFadingFour(color: Colors.white, size: 50.0)),
    );
  }
}
