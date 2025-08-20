import 'package:coffeshop/models/showregister.dart';
import 'package:coffeshop/routes/loading.dart';
import 'package:coffeshop/server/auth.dart';
import 'package:coffeshop/widgets/textinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _auth = Auth();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: ListView(children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Login",
                          style: GoogleFonts.manrope(
                              fontSize: 30,
                              color: const Color(0xffE57734),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 45,
                      ),
                      Textinput(
                        hint_text: "abcd12@gmail.com",
                        label: "Enter your email",
                        selector: "email",
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Textinput(
                        label: "Enter your password",
                        password: true,
                        selector: "password",
                        controller: _passwordController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        InkWell(
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {},
                          child: Text(
                            "forgot password?",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                letterSpacing: 0.5,
                                fontSize: 14),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });

                            dynamic user = await _auth.signInEmailPass(
                              _emailController.text,
                              _passwordController.text,
                            );

                            setState(() {
                              loading = false;
                            });

                            if (user == null) {
                              // 👇 Show error message
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Cannot login. Please check your credentials."),
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(20),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xffE57734),
                              borderRadius: BorderRadius.circular(17)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 14),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Login",
                            style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dont have an acount ? ",
                            style: GoogleFonts.manrope(
                                color: Colors.white.withOpacity(0.5),
                                letterSpacing: 0.5,
                                fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<Showregister>().toggleView();
                            },
                            child: Text(
                              "sign up",
                              style: GoogleFonts.manrope(
                                  color: const Color(0xffE57734),
                                  letterSpacing: 0.5,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "or",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                            color: Colors.white.withOpacity(0.5),
                            letterSpacing: 0.5,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                              color: const Color(0xff313336),
                              borderRadius: BorderRadius.circular(17)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 13),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/google.svg',
                                  width: 28,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Continue with Google",
                                  style: GoogleFonts.manrope(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 15,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                              color: const Color(0xff313336),
                              borderRadius: BorderRadius.circular(17)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.apple,
                                  color: Color(0xffE57734),
                                  size: 34,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Continue with Apple",
                                  style: GoogleFonts.manrope(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 15,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          );
  }
}
