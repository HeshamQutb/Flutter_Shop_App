// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/App/cubit.dart';
import 'package:shop_app/shared/cubit/App/states.dart';
import 'package:shop_app/shared/cubit/Screens/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/theme.dart';

import 'modules/on_boarding/on_boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();


  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if(token != null ) {
    print(token);
  }
  if(onBoarding != null){
    if(token != null){
      widget = const HomeScreen();
    }else{
      widget = const LoginScreen();
    }
  }else{
    widget = const OnBoardingScreen();
  }


  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({super.key, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoryData()
            ..getFavoriteData()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,

            home: startWidget
          );
        },
      ),
    );
  }
}


