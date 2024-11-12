import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pr8/models/cart.dart';

class SlidableWidget extends StatelessWidget {
  final Widget child;
  final CartItem cartItem;
  final Function(int) removeCart;

  const SlidableWidget({super.key, required this.child, required this.removeCart, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),  // Add a unique key for each Slidable widget
      direction: Axis.horizontal,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (BuildContext context) {
              removeCart(cartItem.car.id);
            }
          ),
        ],
      ),
      child: child,
    );
  }
}
