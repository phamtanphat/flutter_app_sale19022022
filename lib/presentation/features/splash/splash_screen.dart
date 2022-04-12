import 'package:flutter/material.dart';
import 'package:flutter_app_sale19022022/common/app_constant.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.blueGrey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Lottie.asset(
                  AppConstant.ANIMATION_SPLASH,
                  animate: true,
                  repeat: true,

                  onLoaded: (complete){
                    // Future.delayed(Duration(seconds: 2),() async{
                    //   String? token = await
                    //   if(token != null && token.isNotEmpty){
                    //     Navigator.pushReplacementNamed(context, "/home");
                    //   }else{
                    //     Navigator.pushReplacementNamed(context, "/sign-in");
                    //   }
                    // });
                  }
              ),
              Text("Welcome",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.white))
            ],
          )),
    );
  }
}
