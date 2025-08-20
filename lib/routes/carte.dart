import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(child: Consumer<CartProvider>(builder: (context, cart, child) {
          return ListView(
            children: [
              for (var coffe in cart.selectedItems)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.asset(
                        coffe['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      "${coffe['quantity']}x    ${coffe['name']}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.grey),
                      onPressed: () {
                        cart.removeCoffee(coffe);
                      },
                    ),
                  ),
                )
            ],
          );
        })),
        const Divider(
          color: Colors.black,
        ),
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<CartProvider>(builder: (context, cart, child) {
                return Text(
                  '${cart.totalPrice}\$',
                  style: const TextStyle(
                      fontFamily: 'corben', fontSize: 30, color: Colors.white),
                );
              }),
              const SizedBox(
                width: 30,
              ),
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    backgroundColor: Colors.amber[900],
                  ),
                  child: const Text(
                    'BUY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
