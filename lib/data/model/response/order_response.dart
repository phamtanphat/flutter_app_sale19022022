import 'package:flutter_app_sale19022022/data/model/response/product_reponse.dart';

class OrderResponse{
  String? id;
  List<ProductResponse>? products;
  String? idUser;
  int? price;
  bool? status;

  OrderResponse(
      {this.id,
        this.products,
        this.idUser,
        this.price,
        this.status});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['products'] != null) {
      products = <ProductResponse>[];
      json['products'].forEach((v) {
        products!.add(new ProductResponse.fromJson(v));
      });
    }
    idUser = json['id_user'];
    price = json['price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['id_user'] = this.idUser;
    data['price'] = this.price;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    return 'OrderResponse{id: $id, products: $products, idUser: $idUser, price: $price, status: $status}';
  }

  static OrderResponse formJson(Map<String, dynamic> json) {
    return OrderResponse.fromJson(json);
  }
}