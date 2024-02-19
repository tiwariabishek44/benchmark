class PhysicalItemsResponse {
  final String productId; // Unique identifier for the product
  final String name;
  final String image;
  final double price;

  PhysicalItemsResponse({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
  });

  factory PhysicalItemsResponse.fromJson(Map<String, dynamic> json) {
    return PhysicalItemsResponse(
      productId: json['productId'] ?? "",
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      price: json['price']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      'price': price,
    };
  }
}
