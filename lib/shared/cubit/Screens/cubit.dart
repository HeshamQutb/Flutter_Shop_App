// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/products_model.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/setting/settings_screen.dart';
import 'package:shop_app/shared/cubit/Screens/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../modules/category/category_screen.dart';
import '../../../modules/favorite/favorite_screen.dart';
import '../../components/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const SettingsScreen()
  ];

  void changeNavBar(index) {
    currentIndex = index;
    emit(ShopChangeNavBarState());
  }



  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopHomeLoadingState());

    DioHelper.getData(
        url: HOME,
        token: token
    ).then((value)
    {
      homeModel = HomeModel.fromjson(value?.data);
      print(homeModel?.data?.banners[0]);
      print(homeModel?.status);
      emit(ShopHomeSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      ShopHomeErrorState();
    });
  }


  CategoryModel? categoryModel;
  void getCategoryData() {
    emit(ShopHomeLoadingState());

    DioHelper.getData(
        url: CATEGORIES,
        token: token
    ).then((value)
    {
      categoryModel = CategoryModel.fromjson(value?.data);
      print(categoryModel?.data?.data[0]);
      print(categoryModel?.status);
      emit(ShopCategorySuccessState());
    }).catchError((error)
    {
      print(error.toString());
      ShopCategoryErrorState();
    });
  }
}
