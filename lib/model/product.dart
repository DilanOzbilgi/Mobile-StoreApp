class Product {
  final String id;
  final String productName;
  final String productCode;
  final double weight;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.weight,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      productCode: json['productCode'],
      weight: json['weight'].toDouble(),
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}



