import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab/models/product.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.solid, color: Colors.pinkAccent),
      ),
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Image.asset(product.image ?? "Default", fit: BoxFit.contain),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_shopping_cart),
                    color: Colors.white,
                    hoverColor: Colors.orange,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.pinkAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text("Name: ${product.name}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Price: "),
              Text(
                "${product.price}\$",
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              Text("${product.price - Random().nextInt(36)}\$"),
            ],
          ),
          Text(product.description ?? "null", textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}