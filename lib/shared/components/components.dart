import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubit/Screens/cubit.dart';
import '../styles/colors.dart';

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget)
);


void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false
);


Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  required void Function()? function,
  required String text,
  bool isUpperCase = true,
  double radius = 10.0
}) => Container(
  width: width,
  decoration: BoxDecoration(
      color: background,
    borderRadius: BorderRadius.circular(radius)
  ),
  child: MaterialButton(
    onPressed: function,
    child: Text(
        isUpperCase == true ? text.toUpperCase() : text,
      style: const TextStyle(
        color: Colors.white
      ),
    ),
  ),
);



Widget defaultTextButton({
  required void Function()? onPressed,
  required String text
}) => TextButton(
  onPressed: onPressed,
  child: Text(
      text.toUpperCase()
  ),
);



// Widget defaultTextField({
//   required TextEditingController controller,
//   required TextInputType type,
//   TextCapitalization? capitalization,
//   required String? Function(String?)? validate,
//   void Function(String)? onChanged,
//   void Function(String)? onFieldSubmitted,
//   required String label,
//   required IconData prefixIcon,
//   IconData? suffix,
//   void Function()? onPressedSuffix,
//   bool? isPassword
// }) => TextFormField(
//   controller: controller,
//   obscureText: isPassword == true ? true : false,
//   keyboardType: type,
//   textCapitalization: TextCapitalization.words,
//   validator: validate,
//   onFieldSubmitted: onFieldSubmitted,
//   onChanged: onChanged,
//   decoration: InputDecoration(
//     prefixIcon: Icon(prefixIcon),
//     label: Text(label),
//     border: const OutlineInputBorder(),
//     suffixIcon: IconButton(
//       onPressed: onPressedSuffix,
//       icon: Icon(suffix),
//     ),
//   ),
// );



Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType type,
  TextCapitalization? capitalization,
  required String? Function(String?)? validate,
  void Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  required String label,
  required IconData prefixIcon,
  IconData? suffix,
  void Function()? onPressedSuffix,
  bool? isPassword,
}) => TextFormField(
  controller: controller,
  obscureText: isPassword == true ? true : false,
  keyboardType: type,
  textCapitalization: capitalization ?? TextCapitalization.none,
  validator: validate,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: (value) {
    if (capitalization == TextCapitalization.words) {
      String capitalizedText = value
          .split(' ')
          .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '')
          .join(' ');
      controller.value = controller.value.copyWith(
        text: capitalizedText,
        selection: TextSelection.collapsed(offset: capitalizedText.length),
      );
    }
    if (onChanged != null) {
      onChanged(value);
    }
  },
  decoration: InputDecoration(
    prefixIcon: Icon(prefixIcon),
    label: Text(label),
    border: const OutlineInputBorder(),
    suffixIcon: IconButton(
      onPressed: onPressedSuffix,
      icon: Icon(suffix),
    ),
  ),
);



void showToast({
  required String message,
  required ToastState state,
})=> Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: taostColor(state),
    textColor: Colors.white,
    fontSize: 16.0);


enum ToastState {
  success,error,warning
}

Color? taostColor(ToastState state){
  Color color;
  switch(state){
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.orange;
      break;

  }
  return color;





}


Widget divider() => Padding(
  padding: const EdgeInsets.only(left: 20),
  child:   Container(

    width: 1,

    height: 1,

    color: Colors.grey,

  ),
);


Widget buildListProduct(model,context,{bool oldPrice = false}) => Padding(
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
                image: NetworkImage(model?.image),
                fit: BoxFit.cover,
              ),
              if (model?.discount != 0 && !oldPrice )
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
                model?.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10.0, height: 2),
              ),
              const Spacer(),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      '${model?.price.round()}',
                      style: const TextStyle(
                          fontSize: 12.0, height: 1.3, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (model?.discount != 0 && !oldPrice)
                      Text(
                        '${model?.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 12.0,
                            height: 1.3,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorite(model?.id);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: ShopCubit.get(context).favorites[model?.id] == true ? defaultColor: Colors.grey,
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