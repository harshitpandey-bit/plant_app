class Plant {
  final String id;
  final String title;
  final String image;
  final double price;

  Plant({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'].toString() ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      price: double.parse(json['price'])?? 0.0);
  }
}
