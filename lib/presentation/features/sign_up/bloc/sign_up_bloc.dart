import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/response/user_response.dart';
import 'package:flutter_app_sale19022022/data/remote/response/app_response.dart';
import 'package:flutter_app_sale19022022/data/repository/authentication_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/sign_up/bloc/sign_up_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/sign_up/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEventBase,SignUpStateBase>{
  late AuthenticationRepository _repository;
  SignUpBloc({required AuthenticationRepository repository}) : super(SignUpStateInit()){
    this._repository = repository;

    on<SignUpEvent>((event, emit) async {
      emit(SignUpStateLoading());
      try {
        Response response = await _repository.signUpRepo(event.email,event.password,event.address,event.name,event.phone);
        AppResponse<UserResponse> userResponse = AppResponse.fromJson(response.data, UserResponse.formJson);
        emit(SignUpStateSuccess(userResponse: userResponse.data!));
      } on DioError catch(e){
        if(e.response != null){
          emit(SignUpStateFail(message: e.response!.data['message'].toString()));
        }else{
          emit(SignUpStateFail(message: e.error.toString()));
        }
      }catch (e) {
        emit(SignUpStateFail(message: e.toString()));
      }
    });
  }

}