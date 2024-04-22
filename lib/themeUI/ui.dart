import 'package:flutter/material.dart';

class AppColors{
  static Color primary = const Color(0xFFD8B5FF);
  static Color secondary = const Color(0xFF1EAE98);
}

class Themes{
   static ThemeData defaultTheme = ThemeData(
     brightness: Brightness.light,
     scaffoldBackgroundColor: Colors.white,
     colorScheme: ColorScheme.light(
       primary: AppColors.primary,
       secondary:AppColors.secondary
     )
   );
}

class TextStyles{
   static TextStyle headerBig = TextStyle(
     fontWeight: FontWeight.bold,
     color: Colors.black,
       fontSize: 35,
   );

   static TextStyle headerMedium= TextStyle(
     fontWeight: FontWeight.bold,
     color: Colors.black,
     fontSize: 24,
   );

   static TextStyle headerLow= TextStyle(
     fontWeight: FontWeight.normal,
     color: Colors.black,
     fontSize: 18,
   );
   static TextStyle textBig= TextStyle(
     fontWeight: FontWeight.bold,
     color: Colors.black,
     fontSize: 30,
   );

   static TextStyle textMedium= const TextStyle(
     fontWeight: FontWeight.normal,
     color: Colors.black,
     fontSize: 24,
   );

   static TextStyle textLow= const TextStyle(
     fontWeight: FontWeight.normal,
     color: Colors.black,
     fontSize: 18,
   );
}