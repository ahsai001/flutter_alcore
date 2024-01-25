import 'package:flutter/material.dart';

class CustomLightThemeWidget extends StatelessWidget {
  final Widget child;
  final ThemeData Function(ThemeData)? modifyTheme;
  const CustomLightThemeWidget(
      {Key? key, required this.child, this.modifyTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var lastTheme = theme.copyWith(
        textSelectionTheme:
            theme.textSelectionTheme.copyWith(cursorColor: Colors.black),
        iconTheme: theme.iconTheme.copyWith(color: Colors.black),
        textButtonTheme: const TextButtonThemeData(),
        textTheme: theme.textTheme.copyWith(
          displayLarge: const TextStyle(color: Colors.black),
          displayMedium: const TextStyle(color: Colors.black),
          displaySmall: const TextStyle(color: Colors.black),
          headlineMedium: const TextStyle(color: Colors.black),
          headlineSmall: const TextStyle(color: Colors.black),
          titleLarge: const TextStyle(color: Colors.black),
          bodyLarge: const TextStyle(color: Colors.black),
          bodyMedium: const TextStyle(color: Colors.black),
          bodySmall: const TextStyle(color: Colors.black),
          titleMedium: const TextStyle(color: Colors.black),
          titleSmall: const TextStyle(color: Colors.black),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10)))));
    if (modifyTheme != null) {
      lastTheme = modifyTheme!(lastTheme);
    }
    return Theme(data: lastTheme, child: child);
  }
}
