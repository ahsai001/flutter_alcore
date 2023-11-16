import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get primaryColor => colorScheme.primary;
  Color get onPrimaryColor => colorScheme.onPrimary;
  Color get secondaryColor => colorScheme.secondary;
  Color get onSecondaryColor => colorScheme.onSecondary;

  ModalRoute? get modalRoute => ModalRoute.of(this);
  RouteSettings? get routeSettings => modalRoute?.settings;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get mqSize => mediaQuery.size;

  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  void popFromRootNav<T extends Object?>([T? result]) {
    Navigator.of(this, rootNavigator: true).pop(result);
  }
}

extension TextThemeExtension on TextTheme {
  TextStyle? get titleLargeWithPrimaryColor =>
      titleLarge?.apply(color: Colors.amber);
}

extension ColorManipulation on Color {
  /// Darken a color by [percent] amount (100 = black)
// ........................................................
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(
        alpha, (red * f).round(), (green * f).round(), (blue * f).round());
  }

  /// Lighten a color by [percent] amount (100 = white)
// ........................................................
  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(alpha, red + ((255 - red) * p).round(),
        green + ((255 - green) * p).round(), blue + ((255 - blue) * p).round());
  }
}
