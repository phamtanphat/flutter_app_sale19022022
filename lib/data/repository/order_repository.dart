import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/request/add_cart_request.dart';
import 'package:flutter_app_sale19022022/data/remote/request/order_request.dart';

class OrderRepository {
  late OrderRequest _request;

  OrderRepository();

  void updateOrderRequest({required OrderRequest request}) {
    this._request = request;
  }

  Future<Response> fetchOrder() {
    return _request.fetchOrder();
  }

  Future<Response> addOrder(String id_product) {
    return _request.addOrder(AddOrderRequest(id_product: id_product));
  }
}
