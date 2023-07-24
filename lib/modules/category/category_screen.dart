import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/cubit/Screens/cubit.dart';
import '../../shared/cubit/Screens/states.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => categoriesBuilder(cubit.categoryModel!.data!.data[index]),
              separatorBuilder: (context, index) => divider(),
              itemCount: cubit.categoryModel!.data!.data.length
          );
        });
  }

  Widget categoriesBuilder(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 100,
          height: 100,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          model.name,
          style: const TextStyle(
            fontSize: 18
          ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios)

      ],
    ),
  );
}
