class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  // Factory constructor to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
    );
  }
}

// ignore: camel_case_types
class cartProducts {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  cartProducts(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image});

  static void add(Product clickedProduct) {}
}

class WishListProducts {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  WishListProducts(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image});
}
