class Product {
  final int id;
  final String name;
  final String description;
  final int brandId;
  final String brandName;
  final String brandLogoUrl;
  final int rating;
  final List<ProudctVariation> variations;
  final List<Properties> availableProperties;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.brandId,
    required this.brandName,
    required this.brandLogoUrl,
    required this.rating,
    required this.variations,
    required this.availableProperties,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        brandId = json['brand_id'],
        brandName = json['brandName'],
        brandLogoUrl = json['brandImage'],
        rating = json['product_rating'],
        variations = (json['variations'] as List<dynamic>)
            .map((variationJson) => ProudctVariation.fromJson(variationJson))
            .toList(),
        availableProperties = (json['avaiableProperties'] != null)
            ? (json['avaiableProperties'] as List<dynamic>)
                .map((propertyJson) => Properties.fromJson(propertyJson))
                .toList()
            : List<Properties>.empty();

  List<Map<String, dynamic>> makeAllTestForColor(Product product) {
    List<Map<String, dynamic>> allTest = [];
    if (product.availableProperties.isNotEmpty) {
      for (int i = 0; i < product.availableProperties.length; i++) {
        if (product.availableProperties[i].property == 'Color') {
          Set<dynamic> uniqueColors = {};
          for (int j = 0;
              j < product.availableProperties[i].values!.length;
              j++) {
            String color = product.availableProperties[i].values![j];
            if (!uniqueColors.contains(color)) {
              uniqueColors.add(color);
              Map<String, dynamic> test = {
                'Color': color,
                'Price': [],
                'Image': [],
                'Size': [],
                'Materials': []
              };
              Set<String> uniqueSizes = {};
              Set<String> uniqueMaterials = {};
              Set<int> uniquePrices = {};
              Set<String> uniqueImages = {};
              bool imageTaked = false;
              for (int k = 0; k < product.variations.length; k++) {
                for (int l = 0;
                    l < product.variations[k].productPropertiesValues.length;
                    l++) {
                  if (product.variations[k].productPropertiesValues[l]
                              .property ==
                          'Color' &&
                      product.variations[k].productPropertiesValues[l].value ==
                          color) {
                    uniquePrices.add(product.variations[k].price as int);
                    for (int m = 0;
                        m <
                                product.variations[k].productVariationImages
                                    .length &&
                            !imageTaked;
                        m++) {
                      String imageUrl = product
                          .variations[k].productVariationImages[m].imageUrl!;
                      uniqueImages.add(imageUrl);
                    }
                    imageTaked = true;
                    for (int n = 0;
                        n <
                            product
                                .variations[k].productPropertiesValues.length;
                        n++) {
                      if (product.variations[k].productPropertiesValues[n]
                              .property ==
                          'Size') {
                        uniqueSizes.add(product
                            .variations[k].productPropertiesValues[n].value);
                      }
                      if (product.variations[k].productPropertiesValues[n]
                              .property ==
                          'Materials') {
                        uniqueMaterials.add(product
                            .variations[k].productPropertiesValues[n].value
                            .toLowerCase());
                      }
                    }
                  }
                }
              }
              test['Size'] = uniqueSizes.toList();
              test['Price'] = uniquePrices.toList();
              test['Image'] = uniqueImages.toList();
              test['Materials'] = uniqueMaterials.toList();
              allTest.add(test);
            }
          }
        }
      }
    }

    return allTest;
  }

  List<Map<String, dynamic>> makeAllTestForSize(Product product) {
    List<Map<String, dynamic>> allTest = [];

    if (product.availableProperties.isNotEmpty) {
      for (int i = 0; i < product.availableProperties.length; i++) {
        if (product.availableProperties[i].property == 'Size') {
          Set<String> uniqueSizes = {};
          for (int j = 0;
              j < product.availableProperties[i].values!.length;
              j++) {
            String size = product.availableProperties[i].values![j];
            if (!uniqueSizes.contains(size)) {
              uniqueSizes.add(size);
              Set<int> uniquePrices = {};
              Set<String> uniqueImages = {};
              Set<String> uniqueMaterials = {};

              Map<String, dynamic> test = {
                'Price': [],
                'Image': [],
                'Size': size,
                'Materials': []
              };

              for (int k = 0; k < product.variations.length; k++) {
                for (int l = 0;
                    l < product.variations[k].productPropertiesValues.length;
                    l++) {
                  if (product.variations[k].productPropertiesValues[l]
                              .property ==
                          'Size' &&
                      product.variations[k].productPropertiesValues[l].value ==
                          size) {
                    uniquePrices.add(product.variations[k].price as int);
                    for (int m = 0;
                        m < product.variations[k].productVariationImages.length;
                        m++) {
                      uniqueImages.add(product
                          .variations[k].productVariationImages[m].imageUrl!);
                    }
                    for (int n = 0;
                        n <
                            product
                                .variations[k].productPropertiesValues.length;
                        n++) {
                      if (product.variations[k].productPropertiesValues[n]
                              .property ==
                          'Materials') {
                        uniqueMaterials.add(product
                            .variations[k].productPropertiesValues[n].value);
                      }
                    }
                  }
                }
              }

              test['Price'] = uniquePrices.toList();
              test['Image'] = uniqueImages.toList();
              test['Materials'] = uniqueMaterials.toList();
              allTest.add(test);
            }
          }
        }
      }
    }

    return allTest;
  }

  List<Map<String, dynamic>> makeAllTestForMaterial(Product product) {
    List<Map<String, dynamic>> allTest = [];

    if (product.availableProperties.isNotEmpty) {
      for (int i = 0; i < product.availableProperties.length; i++) {
        if (product.availableProperties[i].property == 'Materials') {
          Set<String> uniqueMaterials = {};
          for (int j = 0;
              j < product.availableProperties[i].values!.length;
              j++) {
            String material = product.availableProperties[i].values![j];
            if (!uniqueMaterials.contains(material)) {
              uniqueMaterials.add(material);
              Set<int> uniquePrices = {};
              Set<String> uniqueImages = {};

              Map<String, dynamic> test = {
                'Price': [],
                'Image': [],
                'Materials': material,
              };

              for (int k = 0; k < product.variations.length; k++) {
                for (int l = 0;
                    l < product.variations[k].productPropertiesValues.length;
                    l++) {
                  if (product.variations[k].productPropertiesValues[l]
                              .property ==
                          'Materials' &&
                      product.variations[k].productPropertiesValues[l].value ==
                          material) {
                    uniquePrices.add(product.variations[k].price as int);
                    for (int m = 0;
                        m < product.variations[k].productVariationImages.length;
                        m++) {
                      uniqueImages.add(product
                          .variations[k].productVariationImages[m].imageUrl!);
                    }
                  }
                }
              }
              test['Price'] = uniquePrices.toList();
              test['Image'] = uniqueImages.toList();
              allTest.add(test);
            }
          }
        }
      }
    }

    return allTest;
  }

  List<Map<String, dynamic>> makeAllTestForNoAvailble(Product product) {
    late List<Map<String, List<dynamic>>> allTest = [];
    Set<dynamic> uniquePrices = {};
    Set<String> uniqueImages = {};
    allTest.add({'Price': [], 'Image': []});
    for (int k = 0; k < product.variations.length; k++) {
      uniquePrices.add(product.variations[k].price as int);
      for (int l = 0;
          l < product.variations[k].productVariationImages.length;
          l++) {
        uniqueImages
            .add(product.variations[k].productVariationImages[l].imageUrl!);
      }
    }
    allTest[0]['Price']?.addAll(uniquePrices.toList());
    allTest[0]['Image']?.addAll(uniqueImages.toList());
    return allTest;
  }

  int addToCart(
      String color, String size, String material, int price, Product product) {
    final List<ProudctVariation> variations = product.variations;
    int idVariation = 0;
    for (final variation in variations) {
      final List<Property> productPropertiesValues =
          variation.productPropertiesValues;
      bool colorMatch = true, sizeMatch = true, materialMatch = true;
      int id = variation.id as int;
      for (final propertyValue in productPropertiesValues) {
        final String property = propertyValue.property as String;
        final String value = propertyValue.value;
        if (property == 'Color' && color.isNotEmpty && value != color) {
          colorMatch = false;
        } else if (property == 'Size' && size.isNotEmpty && value != size) {
          sizeMatch = false;
        } else if (property == 'Materials' &&
            material.isNotEmpty &&
            value != material) {
          materialMatch = false;
        }
      }
      if (colorMatch && sizeMatch && materialMatch) {
        idVariation = id;
        break;
      }
    }
    return idVariation;
  }
}

class ProudctVariation {
  final int? id;
  final int? price;
  final int? quantity;
  final bool? isDefault;
  final List<ProudctVariationImage> productVariationImages;
  final List<Property> productPropertiesValues;
  ProudctVariation({
    required this.id,
    required this.price,
    required this.quantity,
    required this.isDefault,
    required this.productVariationImages,
    required this.productPropertiesValues,
  });
  ProudctVariation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        quantity = json['quantity'],
        isDefault = json['is_default'],
        productVariationImages = (json['ProductVarientImages'] as List<dynamic>)
            .map((imageJson) => ProudctVariationImage.fromJson(imageJson))
            .toList(),
        productPropertiesValues =
            (json['productPropertiesValues'] as List<dynamic>)
                .map((e) => Property.fromJson(e))
                .toList();
}

class ProudctVariationImage {
  final int? id;
  final String? imageUrl;
  final int? productVariationId;
  ProudctVariationImage({
    required this.id,
    required this.imageUrl,
    required this.productVariationId,
  });
  ProudctVariationImage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        imageUrl = json['image_path'],
        productVariationId = json['product_varient_id'];
}

class Properties {
  final String? property;
  final List<String>? values;
  Properties({
    required this.property,
    required this.values,
  });
  Properties.fromJson(Map<String, dynamic> json)
      : property = json['property'],
        values = (json['values'] as List<dynamic>)
            .map((value) => value['value'].toString())
            .toList();
}

class Property {
  final String? property;
  final String value;
  Property({
    required this.property,
    required this.value,
  });
  Property.fromJson(Map<String, dynamic> json)
      : property = json['property'],
        value = json['value'];
}
