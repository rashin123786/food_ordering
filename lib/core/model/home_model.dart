class Order {
  final int? id;
  final Product? items;
  final String? status;
  final String? date;
  final AddressModel? addressModel;

  Order({
    this.id,
    this.items,
    this.status,
    this.date,
    this.addressModel,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        items: Product.fromJson(json['items']),
        status: json['status'],
        date: json['date'],
        addressModel: AddressModel.fromJson(json['address']));
  }
}

class Product {
  final int? id;
  final ProductDetail? product;
  final int? qty;
  final String? unitPrice;
  final String? totalPrice;
  final String? refundStatus;

  Product({
    this.id,
    this.product,
    this.qty,
    this.unitPrice,
    this.totalPrice,
    this.refundStatus,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      product: ProductDetail.fromJson(json['product']),
      qty: json['qty'],
      unitPrice: json['unit_price'],
      totalPrice: json['total_price'],
      refundStatus: json['refund_status'],
    );
  }
}

class ProductDetail {
  final int? id;
  final String? name;
  final String? slug;
  final String? brand;
  final String? unit;
  final String? thumbnailImage;
  final String? price;
  final bool? isDiscounted;
  final int? discount;
  final int? rewardPoints;

  List<Category>? categories;
  List<Variation>? variations;

  ProductDetail({
    this.id,
    this.name,
    this.slug,
    this.brand,
    this.unit,
    this.thumbnailImage,
    this.price,
    this.isDiscounted,
    this.discount,
    this.rewardPoints,
    this.categories,
    this.variations,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      brand: json['brand'],
      unit: json['unit'],
      thumbnailImage: json['thumbnail_image'],
      price: json['price'],
      isDiscounted: json['is_discounted'],
      discount: json['discount'],
      rewardPoints: json['reward_points'],
      categories: (json['categories'] as List)
          .map((category) => Category.fromJson(category))
          .toList(),
      variations: (json['variations'] as List)
          .map((variation) => Variation.fromJson(variation))
          .toList(),
    );
  }
}

class Category {
  final int? id;
  final String? name;
  final int? products;
  final String? thumbnailImage;

  Category({
    this.id,
    this.name,
    this.products,
    this.thumbnailImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      products: json['products'],
      thumbnailImage: json['thumbnail_image'],
    );
  }
}

class Variation {
  final int? id;
  final int? productId;
  final String? productName;
  final String? productImg;
  final int? stock;
  final String? variationKey;
  final String? sku;
  final String? code;
  final String? price;

  Variation({
    this.id,
    this.productId,
    this.productName,
    this.productImg,
    this.stock,
    this.variationKey,
    this.sku,
    this.code,
    this.price,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productImg: json['product_img'],
      stock: json['stock'],
      variationKey: json['variation_key'],
      sku: json['sku'],
      code: json['code'],
      price: json['price'],
    );
  }
}

class AddressModel {
  int? id;
  int? userId;
  int? countryId;
  String? countryName;
  int? stateId;
  String? stateName;
  int? cityId;
  String? cityName;
  String? address;
  String? dropoffLatitude;
  String? dropoffLongitude;
  int? isDefault;

  AddressModel({
    this.id,
    this.userId,
    this.countryId,
    this.countryName,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.address,
    this.dropoffLatitude,
    this.dropoffLongitude,
    this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      userId: json['user_id'],
      countryId: json['country_id'],
      countryName: json['country_name'],
      stateId: json['state_id'],
      stateName: json['state_name'],
      cityId: json['city_id'],
      cityName: json['city_name'],
      address: json['address'],
      dropoffLatitude: json['dropoff_latitude'],
      dropoffLongitude: json['dropoff_longitude'],
      isDefault: json['is_default'],
    );
  }
}
