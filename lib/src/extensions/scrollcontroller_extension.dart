import 'package:flutter/material.dart';

extension CustomScrollController on ScrollController {
  bool get isSliverAppBarExpanded {
    return hasClients && offset > (200 - kToolbarHeight);
  }
}
