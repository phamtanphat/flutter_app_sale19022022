import 'package:dio/dio.dart';
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
}
