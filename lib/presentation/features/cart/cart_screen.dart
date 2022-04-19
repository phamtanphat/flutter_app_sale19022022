import 'package:flutter/material.dart';
import 'package:flutter_app_sale19022022/common/app_constant.dart';
import 'package:flutter_app_sale19022022/data/model/response/product_reponse.dart';
import 'package:flutter_app_sale19022022/data/remote/request/order_request.dart';
import 'package:flutter_app_sale19022022/data/repository/order_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_app_sale19022022/presentation/features/cart/bloc/cart_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/cart/bloc/cart_state.dart';
import 'package:flutter_app_sale19022022/presentation/widget/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => OrderRequest()),
          ProxyProvider<OrderRequest, OrderRepository>(
            create: (context) => OrderRepository(),
            update: (context, request, repository) {
              repository!.updateOrderRequest(request: request);
              return repository;
            },
          )
        ],
        child: BlocProvider<CartBloc>(
            create: (context) =>
                CartBloc(orderRepository: context.read<OrderRepository>()),
            child: CartContainer()));
  }
}

class CartContainer extends StatefulWidget {
  const CartContainer({Key? key}) : super(key: key);

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  late CartBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<CartBloc>();
    _bloc.add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              if (state.status == CartStatus.fetchCartSuccess)
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.orderResponse!.products!.length,
                            itemBuilder: (lstContext, index) => _buildItem(
                                state.orderResponse!.products![index])),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                              "Tổng tiền : " +
                                  NumberFormat("#,###", "en_US")
                                      .format(state.orderResponse!.price) +
                                  " đ",
                              style: TextStyle(
                                  fontSize: 25, color: Colors.white))),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepOrange)),
                            child: Text("Confirm",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                          )),
                    ],
                  ),
                ),
              if (state.status == CartStatus.loading)
                Center(child: LoadingWidget())
              else if (state.status == CartStatus.fetchCartFail)
                Center(child: Text(state.message.toString()))
            ],
          );
        },
      ),
    );
  }

  Widget _buildItem(ProductResponse productResponse) {
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                      AppConstant.BASE_URL + productResponse.img.toString(),
                      width: 150,
                      height: 120,
                      fit: BoxFit.fill),
                ),
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
                        child: Text(productResponse.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(productResponse.price) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("-"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(productResponse.quantity.toString(),
                                style: TextStyle(fontSize: 16)),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("+"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
