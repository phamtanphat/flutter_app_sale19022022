
import 'package:flutter/material.dart';
import 'package:flutter_app_sale19022022/common/app_constant.dart';
import 'package:flutter_app_sale19022022/data/remote/request/authentication_request.dart';
import 'package:flutter_app_sale19022022/data/repository/authentication_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/sign_up/bloc/sign_up_bloc.dart';
import 'package:flutter_app_sale19022022/presentation/features/sign_up/bloc/sign_up_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/sign_up/bloc/sign_up_state.dart';
import 'package:flutter_app_sale19022022/presentation/widget/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
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
      child: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(repository: context.read<AuthenticationRepository>()),
        child: SignUpContainer(),
      ),
    );
  }
}

class SignUpContainer extends StatefulWidget {
  const SignUpContainer({Key? key}) : super(key: key);

  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {

  final _displayController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  late SignUpBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<SignUpBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: BlocConsumer<SignUpBloc,SignUpState>(
        listener: (context , state){
          if(state.status == SignUpStatus.success){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Dang ky thanh cong")));
            Navigator.pop(context);
          }
          if (state.status == SignUpStatus.fail){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message.toString())));
          }
        },
        builder: (context , state){
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Image.asset(AppConstant.BANNER_1)),
                      Expanded(
                          flex: 4,
                          child: LayoutBuilder(
                            builder: (context, constraint) {
                              return SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minHeight: constraint.maxHeight),
                                  child: IntrinsicHeight(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildDisplayTextField(),
                                        SizedBox(height: 10),
                                        _buildAddressTextField(),
                                        SizedBox(height: 10),
                                        _buildEmailTextField(),
                                        SizedBox(height: 10),
                                        _buildPhoneTextField(),
                                        SizedBox(height: 10),
                                        _buildPasswordTextField(),
                                        SizedBox(height: 10),
                                        _buildButtonSignUp()
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                  if(state.status == SignUpStatus.loading)
                    Center(child: LoadingWidget())
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDisplayTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _displayController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "Example : Mr. John",
          fillColor: Colors.black12,
          filled: true,
          prefixIcon: Icon(Icons.person, color: Colors.blue),
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
        ),
      ),
    );
  }

  Widget _buildAddressTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _addressController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "Example : district 1",
          fillColor: Colors.black12,
          filled: true,
          prefixIcon: Icon(Icons.map, color: Colors.blue),
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
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _emailController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "Email : abc@gmail.com",
          fillColor: Colors.black12,
          filled: true,
          prefixIcon: Icon(Icons.email, color: Colors.blue),
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
        ),
      ),
    );
  }

  Widget _buildPhoneTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "Phone ((+84) 123 456 789)",
          fillColor: Colors.black12,
          filled: true,
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
          prefixIcon: Icon(Icons.phone, color: Colors.blue),
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
        obscureText: true,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: "Pass word",
          fillColor: Colors.black12,
          filled: true,
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
          prefixIcon: Icon(Icons.lock, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildButtonSignUp() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Center(
          child: ElevatedButton(
            onPressed: () {
              String email = _emailController.text.toString();
              String password = _passController.text.toString();
              String phone = _phoneController.text.toString();
              String address = _addressController.text.toString();
              String name = _displayController.text.toString();

              _bloc.add(SignUpEvent(email: email, name: name, password: password, phone: phone, address: address));
            },
            child: Text("Sign Up"),
          )),
    );
  }
}

