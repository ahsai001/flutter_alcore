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
