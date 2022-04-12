import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sale19022022/common/app_constant.dart';
import 'package:flutter_app_sale19022022/data/local/share_pref.dart';
import 'package:flutter_app_sale19022022/presentation/widget/loading_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(seconds: 2),() async{
      try{
        String token = await SharePre.instance.get(AppConstant.TOKEN);
        if(token.isNotEmpty){
          Navigator.pushReplacementNamed(context, AppConstant.PRODUCT_ROUTE_NAME);
        }else{
          Navigator.pushReplacementNamed(context, AppConstant.LOGIN_ROUTE_NAME);
        }
      }catch(e){

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset(
            AppConstant.IMG_SPLASH,
            width: MediaQuery.of(context).size.width / 1.2,
          ),
          Center(
            child: LoadingWidget(),
          ),
          Text("Welcome",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 50, color: Colors.blue))
        ]),
      ));
  }
}
