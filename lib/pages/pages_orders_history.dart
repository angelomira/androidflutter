import 'package:flutter/material.dart';
import '../models/orders.dart';
import '../services/service_api_orders.dart';
import '../data/pallets.dart';
import '../components/order_item.dart';

class OrdersHistoryPage extends StatefulWidget {
  const OrdersHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrdersHistoryPageState();
}

class _OrdersHistoryPageState extends State<OrdersHistoryPage> {
  final OrdersService _ordersApiService = OrdersService();
  late Future<List<OrderItem>> ordersHistory;

  @override
  void initState() {
    super.initState();
    _loadOrdersHistory();
  }

  void _loadOrdersHistory() {
    setState(() {
      ordersHistory = _ordersApiService.getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders History'),
      ),
      body: FutureBuilder<List<OrderItem>>(
        future: ordersHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final orderItem = orders[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: OrderItemTile(orderItem: orderItem),
              );
            },
          );
        },
      ),
    );
  }
}
