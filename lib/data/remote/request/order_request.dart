import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/request/add_cart_request.dart';
import 'package:flutter_app_sale19022022/data/remote/client/dio_client.dart';

class OrderRequest {
  late Dio _dio;

  OrderRequest() {
    _dio = DioClient.instance.dio;
  }

  Future<Response> fetchCart() {
    return _dio.post("order");
  }

  Future<Response> addCart(AddCartRequest addCartRequest) {
    return _dio.post("order/add-to-cart", data: addCartRequest.toJson());
  }
}
