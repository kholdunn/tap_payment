import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app/routes/app_pages.dart';

void main() {
  ThemeData _darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.amber,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.amber,
        disabledColor: Colors.grey,
      ));

  ThemeData _lightTheme = ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white70,
        titleTextStyle: TextStyle(
          color: Colors.black,

        )
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blue,
        disabledColor: Colors.grey,
      ));

  runApp(
      MaterialApp(
        home: ResponsiveSizer(
            builder: (context, orientation, screenType) {
              return GetMaterialApp(
                theme: _lightTheme,
                darkTheme: _darkTheme,
                themeMode: ThemeMode.light,
                title: "Application",
                initialRoute: AppPages.INITIAL,
                getPages: AppPages.routes,
              );
            }
        ),
      )
  );
}
