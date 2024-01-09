// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class ProductResponseModel {
  int? wpId;
  int? backgroundTask;
  String? status;
  String? error;
  int? productId;
  Data? data;

  ProductResponseModel(
      {this.wpId,
      this.backgroundTask,
      this.status,
      this.error,
      this.productId,
      this.data});

  ProductResponseModel.fromJson(Map<String, dynamic> json) {
    wpId = json['wp_id'];
    backgroundTask = json['background_task'];
    status = json['status'];
    error = json['error'];
    productId = json['product_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wp_id'] = this.wpId;
    data['background_task'] = this.backgroundTask;
    data['status'] = this.status;
    data['error'] = this.error;
    data['product_id'] = this.productId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? website;
  String? brandLogo;
  String? productUrl;
  String? productName;
  List<ProductColors>? productColors;
  List<ProductSizes>? productSizes;
  List<String>? productCategory;

  Data(
      {this.website,
      this.brandLogo,
      this.productUrl,
      this.productName,
      this.productColors,
      this.productSizes,
      this.productCategory});

  Data.fromJson(Map<String, dynamic> json) {
    website = json['website'];
    brandLogo = json['brandLogo'];
    productUrl = json['productUrl'];
    productName = json['productName'];
    if (json['productColors'] != null) {
      productColors = <ProductColors>[];
      json['productColors'].forEach((v) {
        productColors!.add(new ProductColors.fromJson(v));
      });
    }
    if (json['productSizes'] != null) {
      productSizes = <ProductSizes>[];
      json['productSizes'].forEach((v) {
        productSizes!.add(new ProductSizes.fromJson(v));
      });
    }
    productCategory = json['productCategory'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['website'] = this.website;
    data['brandLogo'] = this.brandLogo;
    data['productUrl'] = this.productUrl;
    data['productName'] = this.productName;
    if (this.productColors != null) {
      data['productColors'] =
          this.productColors!.map((v) => v.toJson()).toList();
    }
    if (this.productSizes != null) {
      data['productSizes'] = this.productSizes!.map((v) => v.toJson()).toList();
    }
    data['productCategory'] = this.productCategory;
    return data;
  }
}

class ProductColors {
  String? color;
  String? originalImage;
  String? available;
  bool? active;
  String? url;
  String? image;

  ProductColors(
      {this.color,
      this.originalImage,
      this.available,
      this.active,
      this.url,
      this.image});

  ProductColors.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    originalImage = json['original_image'];
    available = json['available'];
    active = json['active'];
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['original_image'] = this.originalImage;
    data['available'] = this.available;
    data['active'] = this.active;
    data['url'] = this.url;
    data['image'] = this.image;
    return data;
  }
}

class ProductSizes {
  String? size;
  double? price;
  String? available;

  ProductSizes({this.size, this.price, this.available});

  ProductSizes.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    price = json['price'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['price'] = this.price;
    data['available'] = this.available;
    return data;
  }
}