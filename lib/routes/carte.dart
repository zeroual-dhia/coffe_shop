import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
                CartItem(coffe: coffe, cart: cart)
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

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.coffe,
    required this.cart,
  });
  final CartProvider cart;
  final Map<String, dynamic> coffe;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool isremoving = false;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: ValueKey(widget.coffe['id']),
      duration: const Duration(milliseconds: 400),
      tween: isremoving
          ? Tween<double>(begin: 1, end: 0)
          : Tween<double>(begin: 1, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      onEnd: () {
        if (isremoving) {
          widget.cart.removeCoffee(widget.coffe);
        }
        isremoving = false;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
        child: ListTile(
          leading: ClipOval(
            child: Image.asset(
              widget.coffe['image'],
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            "${widget.coffe['quantity']}x    ${widget.coffe['name']}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.grey),
            onPressed: () {
              if (widget.coffe['quantity'] <= 1) {
                setState(() {
                  isremoving = true;
                });
              } else {
                widget.cart.removeCoffee(widget.coffe);
              }
            },
          ),
        ),
      ),
    );
  }
}
