import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/Screens/cubit.dart';

import '../shared/cubit/Screens/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Al-Zahra Market',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search
                  )
              )
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeNavBar(index);
            },
            items:const [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                  label: 'Category',
                  icon: Icon(
                    Icons.category,
                  )),
              BottomNavigationBarItem(
                  label: 'Favorite',
                  icon: Icon(Icons.favorite)
              ),
              BottomNavigationBarItem(
                  label: 'Settings',
                  icon: Icon(Icons.settings)
              ),
            ],
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}
