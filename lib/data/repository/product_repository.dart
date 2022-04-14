import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/remote/request/product_request.dart';

class ProductRepository{
  late ProductRequest _request;

  ProductRepository();

  void updateProductRequest(
      {required ProductRequest request}) {
    this._request = request;
  }

  Future<Response> fetchProducts() {
    return _request.fetchListProduct();
  }

}