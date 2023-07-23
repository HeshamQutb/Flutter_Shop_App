import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/products_model.dart';
import 'package:shop_app/shared/cubit/Screens/cubit.dart';

import '../../shared/cubit/Screens/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null,
            builder: (context) => productBuilder(cubit.homeModel!),
            fallback: (context) => const Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}

Widget productBuilder(HomeDataModel model) => Column(
  children: [
    CarouselSlider(
      items: model.data?.banners.map<Widget>((e) => Image(
        image: NetworkImage('${e.image}'),
        width: double.infinity,
        fit: BoxFit.cover,
      )).toList(),
      options: CarouselOptions(
        height: 150,
        initialPage: 0,
        enableInfiniteScroll: true,
        viewportFraction: 1,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    )
  ],
);
