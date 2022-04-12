import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_sale19022022/common/app_constant.dart';
import 'package:flutter_app_sale19022022/data/remote/request/authentication_request.dart';
import 'package:flutter_app_sale19022022/data/repository/authentication_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/login/bloc/login_bloc.dart';
import 'package:flutter_app_sale19022022/presentation/features/login/bloc/login_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/login/bloc/login_state.dart';
import 'package:flutter_app_sale19022022/presentation/widget/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthenticationRequest()),
        ProxyProvider<AuthenticationRequest, AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
          update: (context, request, repository) {
            repository!.updateAuthenticationRepository(request: request);
            return repository;
          },
        )
      ],
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(repository: context.read<AuthenticationRepository>()),
        child: LoginContainer(),
      ),
    );
  }
}

class LoginContainer extends StatefulWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  var isPassVisible = true;

  late LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login System"),
        ),
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: BlocConsumer<LoginBloc,LoginState>(
              listener: (context , state){
                  if(state.status == LoginStatus.loginSuccess){
                    print("Dag nhap thanh cong");
                  }
                  if(state.status == LoginStatus.loginFail){
                    print(state.message);
                  }
              },
              builder: (context , state){
                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: true,
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Image.asset(AppConstant.BANNER_1)),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildPhoneTextField(),
                                          _buildPasswordTextField(),
                                          _buildButtonSignIn(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(child: _buildTextSignUp()),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    if(state.status == LoginStatus.loading)
                      Center(child: LoadingWidget())
                  ],
                );
              },
            ),
          ),
        ));
  }


  Widget _buildTextSignUp() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account!"),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppConstant.SIGNUP_ROUTE_NAME);
              },
              child: Text("Sign Up",
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.underline)),
            )
          ],
        ));
  }

  Widget _buildPhoneTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "Email",
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          prefixIcon: Icon(Icons.email, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _passController,
        obscureText: isPassVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "PassWord",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          labelStyle: TextStyle(color: Colors.blue),
          prefixIcon: Icon(Icons.lock, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildButtonSignIn() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () {
            String email = _emailController.text.toString();
            String password = _passController.text.toString();

            _bloc.add(LoginEvent(email: email, password: password));
          },
          child: Text("Sign In"),
        ));
  }
}
