// lib/models/cart.dart
class CartItem {
  final String id;
  final String title;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      title: title,
      image: image,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}
