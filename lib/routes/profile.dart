import 'package:coffeshop/models/user.dart';
import 'package:coffeshop/routes/loading.dart';
import 'package:coffeshop/server/auth.dart';
import 'package:coffeshop/server/database.dart';
import 'package:coffeshop/widgets/profileInput.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool check = true;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    final _formKey = GlobalKey<FormState>();
    final _auth = Auth();
    if (user == null) {
      return const Loading();
    }
    return StreamBuilder(
        stream: Database(uid: user.uid).users,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            UserData? userdata = asyncSnapshot.data;
            if (nameController.text.isEmpty && userdata != null) {
              nameController.text = userdata.name;
              emailController.text = userdata.email;
              phoneController.text = userdata.phonenumber;
              locationController.text = userdata.location;
            }
            return Scaffold(
                appBar: AppBar(
                  actionsPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  backgroundColor: const Color(0xff212325),
                  title: Text("Profile",
                      style: GoogleFonts.manrope(
                          fontSize: 25,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold)),
                  centerTitle: true,
                  actions: [
                    InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              check = !check;
                            });
                            Database(uid: user.uid).updateUser(
                                name: nameController.text,
                                email: emailController.text,
                                phonenumber: phoneController.text,
                                location: locationController.text);
                          }
                        },
                        child: Icon(check ? Icons.edit : Icons.check,
                            color: Colors.grey)),
                  ],
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.grey),
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                  child: Form(
                    key: _formKey,
                    child: ListView(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/dhia.jpeg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Profileinput(
                            icon: Icon(Icons.email),
                            label: "your email : ",
                            readOnly: true,
                            controller: emailController,
                            selector: "email",
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Profileinput(
                            icon: const Icon(Icons.account_circle),
                            label: "your name :",
                            readOnly: check,
                            controller: nameController,
                            selector: "name",
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Profileinput(
                            icon: Icon(Icons.phone),
                            label: "your phone number : ",
                            readOnly: check,
                            controller: phoneController,
                            selector: "phone",
                          ),
                          const SizedBox(height: 25),
                          Profileinput(
                            icon: Icon(Icons.location_on),
                            label: "your location : ",
                            readOnly: check,
                            controller: locationController,
                            selector: "location",
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          TextButton.icon(
                              onPressed: () async {
                                await _auth.signout();
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.amber[900],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "logout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ]),
                  ),
                ));
          } else {
            return const Loading();
          }
        });
  }
}
/*onPressed: () async {
            await _auth.signout();
            if (context.mounted) {
              Navigator.pop(context);
            }
          },*/
