import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin/theme/pallete.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class AppTheme {
  static ThemeData darkModeAppTheme = ThemeData.dark().copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ),
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Pallete.whiteColor,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Pallete.whiteColor,
    ),
    primaryIconTheme: const IconThemeData(
      color: Pallete.whiteColor,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Pallete.backgroundColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Pallete.backgroundColor,
      selectedItemColor: Pallete.whiteColor,
      unselectedItemColor: Pallete.whiteColor.withOpacity(0.5),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.lightBlueColor,
    ),
  );

  static ThemeData lightModeAppTheme = ThemeData.light().copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme,
    ),
    scaffoldBackgroundColor: Pallete.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Pallete.blackColor,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Pallete.blackColor,
    ),
    primaryIconTheme: const IconThemeData(
      color: Pallete.blackColor,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Pallete.whiteColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.whiteColor,
      selectedItemColor: Colors.black54,
      unselectedItemColor: Colors.black45,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.blueColor,
    ),
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({
    ThemeMode mode = ThemeMode.dark,
    // ThemeMode mode = ThemeMode.light,
  })  : _mode = mode,
        super(
          AppTheme.darkModeAppTheme,
          // AppTheme.lightModeAppTheme,
        ) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = AppTheme.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = AppTheme.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = AppTheme.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = AppTheme.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
