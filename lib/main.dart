import 'package:embutidos_app/controllers/order_controller.dart';
import 'package:embutidos_app/screens/order_list_screen.dart';
import 'package:embutidos_app/screens/order_screen.dart';
import 'package:embutidos_app/screens/production_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final OrderController orderController = OrderController(); // Instancia global de OrderController

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta el banner de debug
      title: 'Sistema de Producción y Pedidos',
      theme: ThemeData(
        primarySwatch: Colors.indigo,  // Color principal
      ),
      home: HomeScreen(orderController: orderController), // Pasar controlador al HomeScreen
    );
  }
}

class HomeScreen extends StatelessWidget {
  final OrderController orderController; // Recibe el controlador

  HomeScreen({required this.orderController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Producción y Pedidos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent.shade100, Colors.indigo.shade900],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido al Sistema',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30), // Espacio entre el título y los botones

            _buildHomeButton(
              context: context,
              label: 'Crear Pedido',
              icon: Icons.add_shopping_cart,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderScreen(orderController: orderController), // Pasar controlador
                  ),
                );
              },
            ),

            _buildHomeButton(
              context: context,
              label: 'Ver Producción',
              icon: Icons.factory_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductionScreen(orderController:orderController), // Pasar controlador
                  ),
                );
              },
            ),

            _buildHomeButton(
              context: context,
              label: 'Ver Pedidos',
              icon: Icons.list_alt,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderListScreen(orderController: orderController), // Pasar controlador
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir botones estilizados
  Widget _buildHomeButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          backgroundColor: Colors.white,
          foregroundColor: Colors.indigo.shade900,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 28, color: Colors.indigo),
        label: Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
