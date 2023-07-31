// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/register_screen/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/register_model.dart';
import '../../network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialStateState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;


  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
}){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:{
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,
        }
    ).then((value)
    {
      print(value?.data);
      registerModel = RegisterModel.fromJson(value?.data);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(RegisterErrorState(error));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    isPassword == true ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }


}