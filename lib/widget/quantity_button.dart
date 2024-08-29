import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  final int quantity;
  final Function(int) onPressed;

  QuantityButton({required this.quantity, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            if (quantity > 0) {
              onPressed(quantity - 1);
            }
          },
        ),
        Text(quantity.toString()),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            onPressed(quantity + 1);
          },
        ),
      ],
    );
  }
}
