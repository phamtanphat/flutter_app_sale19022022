import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/request/add_cart_request.dart';
import 'package:flutter_app_sale19022022/data/remote/request/order_request.dart';

class OrderRepository {
  late OrderRequest _request;

  OrderRepository();

  void updateOrderRequest({required OrderRequest request}) {
    this._request = request;
  }

  Future<Response> fetchCart() {
    return _request.fetchCart();
  }

  Future<Response> addCart(String id_product) {
    return _request.addCart(AddCartRequest(id_product: id_product));
  }
}
