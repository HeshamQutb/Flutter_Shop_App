import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/Screens/cubit.dart';
import 'package:shop_app/shared/cubit/Screens/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopFavoriteSuccessState){
          if(state.model.status == false){
            showToast(message: state.model.message, state: ToastState.error);
          }else{
            showToast(message: state.model.message, state: ToastState.success);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopGetFavoriteLoadingState,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).getFavoriteModel!.data!.data![index].product,context),
              separatorBuilder: (context, index) => divider(),
              itemCount: ShopCubit.get(context).getFavoriteModel!.data!.data!.length
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator(),),

        );
      },
    );
  }



}
