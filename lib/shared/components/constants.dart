import '../../modules/login_screen/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateAndFinish(context, const LoginScreen());
    }
  });
}


void printFullText(String text){
  final pattern = RegExp('1,800');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}


String? token;