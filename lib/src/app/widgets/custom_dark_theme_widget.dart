import 'package:flutter/material.dart';

class CustomDarkThemeWidget extends StatelessWidget {
  final Widget child;
  final ThemeData Function(ThemeData)? modifyTheme;
  const CustomDarkThemeWidget({Key? key, required this.child, this.modifyTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var lastTheme = theme.copyWith(
        textSelectionTheme:
            theme.textSelectionTheme.copyWith(cursorColor: Colors.white),
        iconTheme: theme.iconTheme.copyWith(color: Colors.white),
        textButtonTheme: const TextButtonThemeData(),
        textTheme: theme.textTheme.copyWith(
          displayLarge: const TextStyle(color: Colors.white),
          displayMedium: const TextStyle(color: Colors.white),
          displaySmall: const TextStyle(color: Colors.white),
          headlineMedium: const TextStyle(color: Colors.white),
          headlineSmall: const TextStyle(color: Colors.white),
          titleLarge: const TextStyle(color: Colors.white),
          bodyLarge: const TextStyle(color: Colors.white),
          bodyMedium: const TextStyle(color: Colors.white),
          bodySmall: const TextStyle(color: Colors.white),
          titleMedium: const TextStyle(color: Colors.white),
          titleSmall: const TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(1000))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(1000))),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(1000)))));
    if (modifyTheme != null) {
      lastTheme = modifyTheme!(lastTheme);
    }
    return Theme(data: lastTheme, child: child);
  }
}
