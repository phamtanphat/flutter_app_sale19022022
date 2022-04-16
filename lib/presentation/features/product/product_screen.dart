import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sale19022022/common/app_constant.dart';
import 'package:flutter_app_sale19022022/data/model/response/product_reponse.dart';
import 'package:flutter_app_sale19022022/data/remote/request/order_request.dart';
import 'package:flutter_app_sale19022022/data/remote/request/product_request.dart';
import 'package:flutter_app_sale19022022/data/repository/order_repository.dart';
import 'package:flutter_app_sale19022022/data/repository/product_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product_bloc.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product_order_bloc.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product_state.dart';
import 'package:flutter_app_sale19022022/presentation/widget/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ProductRequest()),
        Provider(create: (context) => OrderRequest()),
        ProxyProvider<ProductRequest, ProductRepository>(
          create: (context) => ProductRepository(),
          update: (context, request, repository) {
            repository!.updateProductRequest(request: request);
            return repository;
          },
        ),
        ProxyProvider<OrderRequest, OrderRepository>(
          create: (context) => OrderRepository(),
          update: (context, request, repository) {
            repository!.updateOrderRequest(request: request);
            return repository;
          },
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ProductOrderBloc(orderRepository: context.read())),
          BlocProvider(
              create: (context) =>
                  ProductBloc(productRepository: context.read())),
        ],
        child: ProductContainer(),
      ),
    );
  }
}

class ProductContainer extends StatefulWidget {
  const ProductContainer({Key? key}) : super(key: key);

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  late ProductBloc _productBloc;
  late ProductOrderBloc _orderBloc;
  StreamController<bool> isLoading = StreamController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productBloc = context.read<ProductBloc>();
    _orderBloc = context.read<ProductOrderBloc>();
    isLoading.sink.add(true);
    _productBloc.add(FetchListProduct());
    _orderBloc.add(FetchCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        actions: [
          BlocConsumer<ProductOrderBloc, ProductStateBase>(
            listener: (context, state) {
              if(state is FetchCartSuccess || state is FetchCartError){
                isLoading.sink.add(false);
              }
            },
            builder: (context, state) {
              if (state is FetchCartSuccess) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 10, top: 10),
                    child: Badge(
                      badgeContent: Text(state.orderResponse.products!
                          .map((element) => element.quantity)
                          .reduce(
                        (value, element) {
                          return value! + element!;
                        },
                      ).toString()),
                      child: Icon(Icons.shopping_cart_outlined),
                    ),
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.only(right: 10, top: 10),
                child: Icon(Icons.shopping_cart_outlined),
              );
            },
          )
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductStateBase>(
        listener: (context, state) {
          if(state is FetchProductsSuccess || state is FetchProductsError){
            isLoading.sink.add(false);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state is FetchProductsSuccess)
                ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      return _buildItemFood(state.list[index]);
                    }),
              if (state is FetchProductsError)
                Center(
                  child: Text(state.message.toString()),
                ),
              StreamBuilder<bool>(
                stream: isLoading.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return LoadingWidget();
                  }
                  return SizedBox();
                },
                initialData: false,
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildItemFood(ProductResponse response) {
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(AppConstant.BASE_URL + response.img!,
                    width: 150, height: 120, fit: BoxFit.fill),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(response.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(response.price) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      ElevatedButton(
                        onPressed: () {
                          isLoading.sink.add(true);
                          _orderBloc
                              .add(AddCart(id_product: response.id.toString()));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromARGB(200, 240, 102, 61);
                              } else {
                                return Color.fromARGB(230, 240, 102, 61);
                              }
                            }),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                        child:
                            Text("Add To Cart", style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
