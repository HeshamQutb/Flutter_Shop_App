import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/App/states.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);





}
