import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sale19022022/common/app_constant.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductContainer();
  }
}

class ProductContainer extends StatefulWidget {
  const ProductContainer({Key? key}) : super(key: key);

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        actions: [
          InkWell(
            onTap: () {
            },
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
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context , index){
            return _buildItemFood();
          }
      ),
    );
  }

  Widget _buildItemFood() {
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
                child: Image.asset(AppConstant.IMG_SPLASH,
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
                        child: Text("Mon an 1",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(300000) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      ElevatedButton(
                        onPressed: () {
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
