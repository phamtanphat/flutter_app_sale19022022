import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/common/app_constant.dart';
import 'package:flutter_app_sale19022022/data/local/share_pref.dart';
import 'package:flutter_app_sale19022022/data/model/response/user_response.dart';
import 'package:flutter_app_sale19022022/data/remote/response/app_response.dart';
import 'package:flutter_app_sale19022022/data/repository/authentication_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/login/bloc/login_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LogInEventBase, LoginState> {
  late AuthenticationRepository _repository;
  late SharePre _sharePre;

  LoginBloc({required AuthenticationRepository repository}) : super(LoginState.initial()) {
    this._repository = repository;
    _sharePre = SharePre.instance;

    on<LoginEvent>((event, emit) async {
      emit(LoginState.loading());
      try {

        Response response = await _repository.loginRepo(event.email, event.password);
        AppResponse<UserResponse> userResponse = AppResponse.fromJson(response.data, UserResponse.formJson);
        _sharePre.set(AppConstant.TOKEN, userResponse.data!.token!);
        emit(LoginState.loginSuccess(userResponse: userResponse.data));
      } on DioError catch(e){
        if(e.response != null){
          emit(LoginState.loginFail(message: e.response!.data['message'].toString()));
        }else{
          emit(LoginState.loginFail(message: e.toString()));
        }
      }catch (e) {
        emit(LoginState.loginFail(message: e.toString()));
      }
    });
  }

}
