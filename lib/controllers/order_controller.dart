import '../models/order.dart';

class OrderController {
  static final OrderController _instance = OrderController._internal();
  
  factory OrderController() {
    return _instance;
  }

  OrderController._internal(); // Constructor privado

  List<Order> orders = [];

  void createOrder(String customer, String address,  int quantity) {
    Order newOrder = Order(
      customer: customer,
      address: address,
      quantity: quantity,
    );
    orders.add(newOrder);
  }

  List<Order> getOrders() {
    return orders;
  }

  double finalPrice() {
    double totalPrice = 0;
    for (Order order in orders) {
      totalPrice += order.quantity * 2100; // 2100 es el precio unitario
    }
    return totalPrice;
  }
}
