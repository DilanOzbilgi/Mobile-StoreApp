class Order {
  final String orderId;
  final String orderDate;
  final double totalPrice;

  Order({
    required this.orderId,
    required this.orderDate,
    required this.totalPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      orderDate: json['orderDate'],
      totalPrice: json['totalPrice'].toDouble(),
    );
  }
}