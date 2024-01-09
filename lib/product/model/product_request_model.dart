// ignore_for_file: unnecessary_this, prefer_collection_literals

class ProductModel {
  String? service;
  String? productUrl;

  ProductModel({this.service, this.productUrl});

  ProductModel.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    productUrl = json['product_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['service'] = this.service;
    data['product_url'] = this.productUrl;
    return data;
  }
}