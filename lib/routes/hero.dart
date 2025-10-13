import 'package:coffeshop/models/hero.dart';
import 'package:coffeshop/routes/athenticate.dart';
import 'package:coffeshop/widgets/getstartedslider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class herosection extends StatefulWidget {
  const herosection({super.key});

  @override
  State<herosection> createState() => _HerosectionState();
}

class _HerosectionState extends State<herosection> {
  @override
  Widget build(BuildContext context) {
    HeroModel heroModel = Provider.of<HeroModel>(context);

    return heroModel.showLogin
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
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 1000),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Text(
                          'Coffee shop',
                          style: GoogleFonts.pacifico(
                              fontSize: 45 * value, color: Colors.white),
                        ),
                      );
                    },
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
                  GetStartedSlider(model: heroModel)
                ],
              ),
            ),
          );
  }
}
