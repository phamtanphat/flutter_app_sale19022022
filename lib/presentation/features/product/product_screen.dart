import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sale19022022/common/app_constant.dart';
import 'package:flutter_app_sale19022022/data/model/response/product_reponse.dart';
import 'package:flutter_app_sale19022022/data/remote/request/product_request.dart';
import 'package:flutter_app_sale19022022/data/repository/product_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product_bloc.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product_event.dart';
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
        ProxyProvider<ProductRequest, ProductRepository>(
          create: (context) => ProductRepository(),
          update: (context, request, repository) {
            repository!.updateProductRequest(request: request);
            return repository;
          },
        )
      ],
      child: BlocProvider<ProductBloc>(
        create: (context) =>
            ProductBloc(productRepository: context.read<ProductRepository>()),
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
  late ProductBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<ProductBloc>();
    _bloc.add(FetchListProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 10, top: 10),
              child: Badge(
                badgeContent: Text("5"),
                child: Icon(Icons.shopping_cart_outlined),
              ),
            ),
          )
        ],
      ),
      body: BlocConsumer<ProductBloc,ProductState>(
        listener: (context, state){

        },
        builder: (context ,state){
          return Stack(
            children: [
              if(state.status == ProductStatus.fetchListSuccess)
                ListView.builder(
                    itemCount: state.lstProducts!.length,
                    itemBuilder: (context, index) {
                      return _buildItemFood(state.lstProducts![index]);
                    }),
              if(state.status == ProductStatus.fetchListFail)
                Center(
                  child: Text(state.message.toString()
                  ),
                ),
              if(state.status == ProductStatus.loading)
                Center(child: LoadingWidget())
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
                child: Image.network(AppConstant.BASE_URL+response.img!,
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
                              NumberFormat("#,###", "en_US").format(response.price) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      ElevatedButton(
                        onPressed: () {},
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
