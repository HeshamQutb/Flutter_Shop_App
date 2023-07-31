// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/cubit/login_screen/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../network/end_points.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialStateState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? userModel;


  void userLogin({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:{
          'email':email,
          'password':password
        }
    ).then((value)
    {
      print(value?.data);
      userModel = LoginModel.fromJson(value?.data);
      emit(LoginSuccessState(userModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    isPassword == true ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }


}