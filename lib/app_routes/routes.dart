
import 'package:emumba_test/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'route_names.dart';

class AppRoutes {
  static Route? generateRoute(RouteSettings settings) {

    FocusManager.instance.primaryFocus?.unfocus();
    final args = settings.arguments;
    switch (settings.name) {
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen() ,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen() ,
        );
    }
  }
}
