import 'package:coffeshop/models/cart.dart';
import 'package:coffeshop/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeCart extends StatelessWidget {
  final Map coffe;
  const CoffeCart({super.key, required this.coffe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xff212325),
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25), // Shadow color
            spreadRadius: 5, // How much it spreads
            blurRadius: 10, // Blur intensity
            offset: const Offset(0, 0),
            blurStyle: BlurStyle.normal, // Shadow position
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(RouteGenerator.coffepage, arguments: coffe);
            },
           
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(coffe['image']),
                  ),
                ),
              ),
            ),
         
          const SizedBox(height: 10),
          Text(
            coffe['name'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          const Text('best coffee', style: TextStyle(color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${coffe['price']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Consumer<CartProvider>(builder: (context, cart, child) {
                return IconButton(
                  highlightColor: const Color.fromARGB(255, 125, 57, 15),
                  iconSize: 20,
                  onPressed: () {
                    cart.addCoffee(coffe);
                  },
                  constraints: const BoxConstraints(maxHeight: 35),
                  icon: const Icon(Icons.add, color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xffe57734), // Background color
                    ),
                    shape: MaterialStateProperty.all(
                      const CircleBorder(), // Circular button
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
