import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/response/user_response.dart';
import 'package:flutter_app_sale19022022/data/remote/response/app_response.dart';
import 'package:flutter_app_sale19022022/data/repository/authentication_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/login/bloc/login_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LogInEventBase, LoginState> {
  late AuthenticationRepository _repository;

  LoginBloc({required AuthenticationRepository repository}) : super(LoginState.initial()) {
    this._repository = repository;
    on<LoginEvent>((event, emit) async {
      emit(LoginState.loading());
      try {
        Response response = await _repository.loginRepo(event.email, event.password);
        AppResponse<UserResponse> userResponse = AppResponse.fromJson(response.data, UserResponse.formJson);
        emit(LoginState.loginSuccess(userResponse: userResponse.data));
      } on DioError catch(e){
        emit(LoginState.loginFail(message: e.response!.data['message'].toString()));
      }catch (e) {
        emit(LoginState.loginFail(message: e.toString()));
      }
    });
  }

}
