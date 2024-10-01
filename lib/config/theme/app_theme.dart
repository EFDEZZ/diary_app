import 'package:flutter/material.dart';


class AppTheme {

  ThemeData getTheme(){
    const seedColor = Color.fromARGB(255, 45, 209, 16);
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seedColor,
      listTileTheme: const ListTileThemeData(
        iconColor: seedColor,
      )

    );
  }
}