import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/get_favorite_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/Screens/cubit.dart';
import 'package:shop_app/shared/cubit/Screens/states.dart';

import '../../shared/styles/colors.dart';

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
              itemBuilder: (context, index) => favItemBuilder(ShopCubit.get(context).getFavoriteModel!.data!.data![index],context),
              separatorBuilder: (context, index) => divider(),
              itemCount: ShopCubit.get(context).getFavoriteModel!.data!.data!.length
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator(),),

        );
      },
    );
  }


  Widget favItemBuilder(GetFavItemData model,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      width: 100,
      height: 100,
      child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.product?.image),
                      fit: BoxFit.cover,
                    ),
                    if (model.product?.discount != 0)
                      Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 8.0, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product?.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10.0, height: 2),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${model.product?.price.round()}',
                            style: const TextStyle(
                                fontSize: 12.0, height: 1.3, color: defaultColor),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (model.product?.discount != 0)
                            Text(
                              '${model.product?.oldPrice.round()}',
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  height: 1.3,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context).changeFavorite(model.product?.id);
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: ShopCubit.get(context).favorites[model.product?.id] == true ? defaultColor: Colors.grey,
                                size: 15,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    ),
  );
}
