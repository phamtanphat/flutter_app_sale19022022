import 'package:equatable/equatable.dart';
import 'package:flutter_app_sale19022022/data/model/response/product_reponse.dart';

enum ProductStatus { initial, loading, fetchListSuccess, fetchListFail }

class ProductState extends Equatable {
  ProductStatus? status;
  List<ProductResponse>? lstProducts;
  String? message = null;

  ProductState._({this.status, this.lstProducts, this.message});

  ProductState copyWith(
      {ProductStatus? status,
      List<ProductResponse>? response,
      String? message}) {
    return ProductState._(
      status: status ?? this.status,
      lstProducts: response ?? this.lstProducts,
      message: message ?? this.message,
    );
  }

  ProductState.initial() : this._(status: ProductStatus.initial);

  ProductState.loading() : this._(status: ProductStatus.loading);

  ProductState.fetchProductSuccess(
      {required List<ProductResponse>? listProduct})
      : this._(
            status: ProductStatus.fetchListSuccess, lstProducts: listProduct);

  ProductState.fetchProductFail({required String? message})
      : this._(status: ProductStatus.fetchListFail, message: message);

  @override
  List<Object?> get props => [status, lstProducts, message];
}
