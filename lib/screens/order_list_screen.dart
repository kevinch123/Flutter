import 'package:flutter/material.dart';
import '../controllers/order_controller.dart';

class OrderListScreen extends StatelessWidget {
  final OrderController orderController;

  OrderListScreen({required this.orderController});

  @override
  Widget build(BuildContext context) {
    final orders = orderController.getOrders();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pedidos'),
      ),
      body: orders.isEmpty
          ? Center(child: Text('No hay pedidos disponibles'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Cliente: ${order.customer}'),
                  subtitle: Text(
                      'Dirección: ${order.address}\nCantidad: ${order.quantity}\nTotal a Pagar: ${order.quantity * 2100}'),
                );
              },
            ),
    );
  }
}
