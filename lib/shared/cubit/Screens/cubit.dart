// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/get_favorite_model.dart';
import 'package:shop_app/models/login_model.dart';
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

  Map<int?, bool?> favorites = {};
  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopHomeLoadingState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromjson(value?.data);
      print(homeModel?.data?.banners[0]);
      print(homeModel?.status);

      homeModel?.data?.products.forEach((element) {
        favorites.addAll({element.id: element.in_favorites});
      });
      // print(favorites.toString());
      emit(ShopHomeSuccessState());
    }).catchError((error) {
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
      // print(categoryModel?.data?.data[0]);
      // print(categoryModel?.status);
      emit(ShopCategorySuccessState());
    }).catchError((error)
    {
      print(error.toString());
      ShopCategoryErrorState();
    });
  }



  FavoriteModel? favoriteModel;
  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopFavoriteState());
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {
          'product_id': productId
        }
    ).then((value)
    {
      favoriteModel = FavoriteModel.fromjson(value?.data);

      if(!favoriteModel?.status){
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavoriteData();
      }
      emit(ShopFavoriteSuccessState(favoriteModel!));
    }
    ).catchError((error)
    {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ShopFavoriteErrorState());
    });
  }



  GetFavoriteModel? getFavoriteModel;
  void getFavoriteData() {
    emit(ShopGetFavoriteLoadingState());

    DioHelper.getData(
        url: FAVORITES,
        token: token
    ).then((value)
    {
      getFavoriteModel = GetFavoriteModel.fromJson(value?.data);
      // print(value?.data.toString());
      emit(ShopGetFavoriteSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      ShopGetFavoriteErrorState();
    });
  }



  LoginModel? userData;
  void getUserData() {
    emit(ShopGetUserDataLoadingState());

    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value)
    {
      userData = LoginModel.fromJson(value?.data);
      // print(value?.data.toString());
      emit(ShopGetUserDataSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      ShopGetUserDataErrorState();
    });
  }

}
