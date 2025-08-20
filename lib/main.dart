import 'package:coffeshop/models/cart.dart';
import 'package:coffeshop/models/coffee.dart';
import 'package:coffeshop/models/navigation.dart';
import 'package:coffeshop/models/showregister.dart';
import 'package:coffeshop/models/user.dart';
import 'package:coffeshop/routes.dart';
import 'package:coffeshop/routes/wrapper.dart';
import 'package:coffeshop/server/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<MyUser?>.value(
          value: Auth().user,
          initialData: null,
          catchError: (_, __) => null,
        ),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => Showregister()),
        ChangeNotifierProvider(create: (_) => CartProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff212325),
        ),
        debugShowCheckedModeBanner: false,
        home: const Wrapper(), // Will decide login/register or home
      );
    }

    // Once user is logged in, provide CoffeeProvider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoffeeProvider(user.uid)),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff212325),
        ),
        home: const Wrapper(),
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
