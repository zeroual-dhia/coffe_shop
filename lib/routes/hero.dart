import 'package:coffeshop/routes/athenticate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class herosection extends StatefulWidget {
  const herosection({super.key});

  @override
  State<herosection> createState() => _herosectionState();
}

class _herosectionState extends State<herosection> {
  bool showLogin = false;
  @override
  Widget build(BuildContext context) {
    return showLogin
        ? const Authenticate()
        : Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                    opacity: 0.6,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 150,
                  ),
                  Text(
                    'Coffee shop',
                    style:
                        GoogleFonts.pacifico(fontSize: 45, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 470,
                  ),
                  Text(
                    'Felling low ? take sip of coffee',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          showLogin = true;
                        });
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.amber[900],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        'Get Start',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          );
  }
}
