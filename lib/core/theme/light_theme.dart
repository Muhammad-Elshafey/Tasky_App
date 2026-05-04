import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xffFFFFFF),
    secondary: Color(0xff3A4640),
    onSecondary: Color(0xffF6F7F9),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF6F7F9),
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20.0, color: Color(0xff161F1B)),
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xff9E9E9E);
      ;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xff9E9E9E);
      ;
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0.0;
      }
      return 2.0;
      ;
    }),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xffF6F7F9),
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Color(0xff3A4640),
    elevation: 0.0,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
    unselectedLabelStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
    enableFeedback: false,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xff15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xffFFFCFC)),

      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.black),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: StadiumBorder(),
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xffFFFFFF),

    elevation: 0,
    highlightElevation: 0,
    hoverElevation: 0,
    extendedTextStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
  ),

  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),

    displayMedium: TextStyle(
      fontSize: 28.0,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),

    displaySmall: TextStyle(
      fontSize: 24.0,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),

    //-----------------------------------------------
    titleLarge: TextStyle(
      color: Color(0xff6A6A6A),
      fontSize: 16.0,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454F),
      fontWeight: FontWeight.w400,
    ),

    titleMedium: TextStyle(
      fontSize: 16.0,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0,
      color: Color(0xff3A4640),
      fontWeight: FontWeight.w400,
    ),

    //------------------------------------------------------------
    labelLarge: TextStyle(
      fontSize: 20.0,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),

    labelMedium: TextStyle(
      fontSize: 16.0,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),

    labelSmall: TextStyle(
      fontSize: 14.0,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xffFFFFFF),
    hintStyle: TextStyle(color: Color(0xff6D6D6D)),
    focusColor: Color(0xffD1DAD6),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Colors.red.withAlpha(255), width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xffD1DAD6), width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4.0),
    ),
  ),

  iconTheme: IconThemeData(color: Color(0xff3A4640)),

  dividerTheme: DividerThemeData(
    color: Color(0xffD1DAD6),
    thickness: 1.0,
    space: 0.0,
  ),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Color(0xff15B86C),
    selectionHandleColor: Color(0xff15B86C),
  ),

  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xffF6F7F9),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 2,
  ),

);
