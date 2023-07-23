import 'package:flutter/material.dart';

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



Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  void Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  required String label,
  required IconData prefixIcon,
  IconData? suffix,
  void Function()? onPressedSuffix,
  bool? isPassword
}) => TextFormField(
  controller: controller,
  obscureText: isPassword == true ? true : false,
  keyboardType: type,
  validator: validate,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: onChanged,
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