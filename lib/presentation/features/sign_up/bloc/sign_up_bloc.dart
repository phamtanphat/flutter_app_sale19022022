import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/response/user_response.dart';
import 'package:flutter_app_sale19022022/data/remote/response/app_response.dart';
import 'package:flutter_app_sale19022022/data/repository/authentication_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/sign_up/bloc/sign_up_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/sign_up/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEventBase,SignUpState>{
  late AuthenticationRepository _repository;

  SignUpBloc({required AuthenticationRepository repository}) : super(SignUpState.initial()){
    this._repository = repository;

    on<SignUpEvent>((event, emit) async {
      emit(SignUpState.loading());
      try {
        Response response = await _repository.signUpRepo(event.email,event.password,event.address,event.name,event.phone);
        AppResponse<UserResponse> userResponse = AppResponse.fromJson(response.data, UserResponse.formJson);
        emit(SignUpState.success(userResponse: userResponse.data));
      } on DioError catch(e){
        if(e.response != null){
          emit(SignUpState.fail(message: e.response!.data['message'].toString()));
        }else{
          emit(SignUpState.fail(message: e.error.toString()));
        }
      }catch (e) {
        emit(SignUpState.fail(message: e.toString()));
      }
    });
  }

}