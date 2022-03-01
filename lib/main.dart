import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tap_payment/app/constants/app_colors.dart';

import 'app/routes/app_pages.dart';

void main() {
  ThemeData _darkTheme = ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.blackSmoke,
        titleTextStyle: TextStyle(
          color: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        actionsIconTheme:IconThemeData(
          color: Colors.white
        ),
      ),
      primaryColor: AppColors.pink,
      backgroundColor: AppColors.blackSmoke,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.white,
        splashColor: AppColors.pink,
        focusColor: AppColors.pink,
        highlightColor: AppColors.pink,
        hoverColor: MaterialStateColor.resolveWith((states) => Colors.red),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
        ),
        color: Colors.black
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: AppColors.pink,
          backgroundColor: Colors.white,
          splashFactory: InkSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: TextStyle(
            color: Colors.black,

          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,

        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.black
      ),
      textTheme: TextTheme(

          titleLarge: TextStyle(
              fontSize: 20,
              color: Colors.white
          ),
          titleMedium: TextStyle(
              fontSize: 19,
              color: AppColors.pink
          ),

          titleSmall: TextStyle(
              fontSize: 15,
              color: Colors.grey
          ),
          labelMedium: TextStyle(
              color: Colors.grey,
              fontSize: 18
          ),
          labelSmall: TextStyle(
              color: Colors.grey,
              fontSize: 18
          ),
          bodyMedium: TextStyle(
              fontSize: 19,
              color: Colors.black
          )
      )
  );

  ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteSmoke,
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      actionsIconTheme:IconThemeData(
        color: Colors.black
      ),
    ),
    primaryColor: AppColors.pink,
    backgroundColor: AppColors.whiteSmoke,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white,
      splashColor: AppColors.pink,
      focusColor: AppColors.pink,
      highlightColor: AppColors.pink,
      hoverColor: MaterialStateColor.resolveWith((states) => Colors.red),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.pink,
        backgroundColor: Colors.white,
        splashFactory: InkSplash.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: Colors.black,

        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,

      ),
    ),
    textTheme: TextTheme(

      titleLarge: TextStyle(
        fontSize: 20,
        color: Colors.black
      ),
      titleMedium: TextStyle(
          fontSize: 19,
          color: AppColors.pink
      ),

      titleSmall: TextStyle(
          fontSize: 15,
          color: Colors.grey
      ),
      labelMedium: TextStyle(
        color: Colors.grey,
        fontSize: 18
      ),
      labelSmall: TextStyle(
        color: Colors.grey,
        fontSize: 18
      ),
      bodyMedium: TextStyle(
        fontSize: 19,
        color: Colors.black
      )
    )
  );

  runApp(
      MaterialApp(
        home: ResponsiveSizer(
            builder: (context, orientation, screenType) {
              return GetMaterialApp(
                theme: _lightTheme,
                darkTheme: _darkTheme,
                themeMode: ThemeMode.system,
                title: "Application",
                initialRoute: AppPages.INITIAL,
                getPages: AppPages.routes,
              );
            }
        ),
      )
  );
}
