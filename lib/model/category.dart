class Category {
  final String name;
  final List<String> products;
  final String image;

  Category({
    required this.name,
    required this.products,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var productListFromJson = json['products'] as List;
    List<String> productImagesList = productListFromJson.cast<String>();

    return Category(
      name: json['name'],
      products: productImagesList,
      image: json['image'],
    );
  }
}
