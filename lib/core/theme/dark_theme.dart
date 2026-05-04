import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xff181818),
  colorScheme: ColorScheme.dark(primaryContainer: Color(0xff282828),
    secondary: Color(0xffC6C6C6),
    onSecondary: Color(0xff181818),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff181818),
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20.0, color: Color(0xffFFFCFC)),
    iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
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
    backgroundColor: Color(0xff181818),
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Color(0xffC6C6C6),
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
      foregroundColor: WidgetStateProperty.all(Color(0xffFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
      ),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: StadiumBorder(),
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xffFFFFFF),
    extendedTextStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
  ),

  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24.0,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),

    displayMedium: TextStyle(
      fontSize: 28.0,
      color: Color(0xffFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32.0,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),

    //-----------------------------------------------
    titleLarge: TextStyle(
      color: Color(0xffA0A0A0),
      fontSize: 16.0,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454F),
      fontWeight: FontWeight.w400,
    ),

    titleMedium: TextStyle(
      fontSize: 16.0,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0,
      color: Color(0xffC6C6C6),
      fontWeight: FontWeight.w400,
    ),

    //------------------------------------------------------------
    labelLarge: TextStyle(
      fontSize: 20.0,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),

    labelMedium: TextStyle(
      fontSize: 16.0,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),

    labelSmall: TextStyle(
      fontSize: 14.0,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xff282828),
    hintStyle: TextStyle(color: Color(0xff6D6D6D)),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(color: Colors.red.withAlpha(255), width: 0.5),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide.none,
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xff6E6E6E), width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4.0),
    ),
  ),

  iconTheme: IconThemeData(color: Color(0xffA0A0A0)),

  dividerTheme: DividerThemeData(
    color: Color(0xff6E6E6E),
    thickness: 1.0,
    space: 0.0,
  ),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Color(0xff15B86C),
    selectionHandleColor: Color(0xff15B86C),
  ),

  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xff181818),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
          fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 2,
  ),
);
