import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/pallets.dart';
import '../models/orders.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItem orderItem;

  const OrderItemTile({Key? key, required this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: CustomDarkTheme.baseColor.withOpacity(0.45),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order #${orderItem.id}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: CustomDarkTheme.accentColor,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'At ${DateFormat('yyyy/MM/dd of kk:mm').format(orderItem.orderedAt)}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: CustomDarkTheme.backgroundColor,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            orderItem.status,
            style: TextStyle(
              fontSize: 14.0,
              color: CustomDarkTheme.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
