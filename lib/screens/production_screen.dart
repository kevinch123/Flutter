import 'package:embutidos_app/models/order.dart';
import 'package:flutter/material.dart';
import '../controllers/order_controller.dart';
import '../models/production.dart';
import '../controllers/production_controller.dart';

class ProductionScreen extends StatefulWidget {
  final OrderController orderController;  // Añadir controlador

  ProductionScreen({required this.orderController});  // Constructor con controlador

  @override
  _ProductionScreenState createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  final ProductionController productionController = ProductionController();

  // Controladores para los campos de entrada de producción
  final _meatController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();
  final _flourController = TextEditingController();
  final _onionController = TextEditingController();
  final _waterController = TextEditingController();

  int? productionCount; // Para almacenar el número de chorizos producidos

  @override
  void dispose() {
    // Limpiar los controladores al salir
    _meatController.dispose();
    _proteinController.dispose();
    _fatController.dispose();
    _flourController.dispose();
    _onionController.dispose();
    _waterController.dispose();
    super.dispose();
  }

  void calculateProduction() {
    final double meat = double.tryParse(_meatController.text) ?? 0.0;
    final double protein = double.tryParse(_proteinController.text) ?? 0.0;
    final double fat = double.tryParse(_fatController.text) ?? 0.0;
    final double flour = double.tryParse(_flourController.text) ?? 0.0;
    final double onion = double.tryParse(_onionController.text) ?? 0.0;
    final double water = double.tryParse(_waterController.text) ?? 0.0;

    // Verificar que todos los ingredientes sean mayores que 0
    if (meat > 0 && protein > 0 && fat > 0 && flour > 0 && onion > 0 && water > 0) {
      Production production = Production(
        meat: meat,
        protein: protein,
        fat: fat,
        flour: flour,
        onion: onion,
        water: water,
      );

      setState(() {
        productionCount = productionController.calculateProduction(production);
      });

      print('Chorizos producidos: $productionCount');
    } else {
      setState(() {
        productionCount = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingresa todos los valores de los ingredientes correctamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Order> orders = widget.orderController.getOrders();
    int totalOrders = orders.fold(0, (sum, order) => sum + order.quantity);

    return Scaffold(
      appBar: AppBar(
        title: Text('Producción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Cantidad de Carne (kg)', _meatController),
              _buildTextField('Cantidad de Proteína (kg)', _proteinController),
              _buildTextField('Cantidad de Grasa (kg)', _fatController),
              _buildTextField('Cantidad de Harina (kg)', _flourController),
              _buildTextField('Cantidad de Cebolla (kg)', _onionController),
              _buildTextField('Cantidad de Agua (kg)', _waterController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateProduction,
                child: Text('Calcular Producción'),
              ),
              SizedBox(height: 20),
              if (productionCount != null) ...[
                Text('Chorizos producidos: $productionCount'),
                SizedBox(height: 10),
                Text('Pedidos del día: $totalOrders'),
                SizedBox(height: 10),
                Text(
                  productionCount == totalOrders
                      ? 'La producción es exacta para los pedidos del día.'
                      : productionCount! > totalOrders
                          ? 'La producción es suficiente para los pedidos.'
                          : 'Falta producción para cubrir los pedidos.',
                  style: TextStyle(
                    color: productionCount! < totalOrders ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Método auxiliar para crear campos de texto
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }
}
