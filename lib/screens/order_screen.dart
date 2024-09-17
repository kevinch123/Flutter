import 'package:flutter/material.dart';
import '../controllers/order_controller.dart';

class OrderScreen extends StatefulWidget {
  final OrderController orderController;  // Recibe el controlador
  
  OrderScreen({required this.orderController}); // Constructor

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _customerController = TextEditingController();
  final _addressController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _customerController,
              decoration: InputDecoration(labelText: 'Cliente'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final customer = _customerController.text;
                final address = _addressController.text;
                final quantity = int.tryParse(_quantityController.text) ?? 0;

                widget.orderController.createOrder(customer, address,quantity);  // Llamada al controlador compartido

                // Clear fields
                _customerController.clear();
                _addressController.clear();
                _quantityController.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pedido creado exitosamente')),
                );
              },
              child: Text('Crear Pedido'),
            )
          ],
        ),
      ),
    );
  }
}
