import 'package:shop_app/models/favorite_model.dart';

abstract class ShopStates {}


class ShopInitState extends ShopStates{}

class ShopChangeNavBarState extends ShopStates{}

class ShopHomeLoadingState extends ShopStates{}

class ShopHomeSuccessState extends ShopStates{}

class ShopHomeErrorState extends ShopStates{}

class ShopCategorySuccessState extends ShopStates{}

class ShopCategoryErrorState extends ShopStates{}

class ShopFavoriteState extends ShopStates{}

class ShopFavoriteSuccessState extends ShopStates{
  final FavoriteModel model;

  ShopFavoriteSuccessState(this.model);
}

class ShopFavoriteErrorState extends ShopStates{}

class ShopGetFavoriteLoadingState extends ShopStates{}

class ShopGetFavoriteSuccessState extends ShopStates{}

class ShopGetFavoriteErrorState extends ShopStates{}

class ShopGetUserDataLoadingState extends ShopStates{}

class ShopGetUserDataSuccessState extends ShopStates{}

class ShopGetUserDataErrorState extends ShopStates{}

