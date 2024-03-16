class AllProudcts {
  final int id;
  final String name;
  final String image;
  final String brand;
  final int price;
  final String logo;
  AllProudcts({
    required this.name,
    required this.image,
    required this.price,
    required this.id,
    required this.brand,
    required this.logo,
  });

  factory AllProudcts.fromJson(Map<String, dynamic> json) {
    return AllProudcts(
      logo: json['Brands']['brand_logo_image_path'],
      brand: json['Brands']['brand_name'],
      name: json['name'],
      image: json['ProductVariations'][0]['ProductVarientImages'][0]
          ['image_path'],
      price: json['ProductVariations'][0]['price'],
      id: json['id'],
    );
  }
}
