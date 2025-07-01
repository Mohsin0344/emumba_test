import 'package:emumba_test/views/screens/home/home_base_screen.dart';
import 'package:flutter/material.dart';

import '../views/screens/home/events/manage_event_screen.dart';
import 'app_route_model/manage_event_route_model.dart';
import 'route_names.dart';

class AppRoutes {
  static Route? generateRoute(RouteSettings settings) {
    FocusManager.instance.primaryFocus?.unfocus();
    final args = settings.arguments;
    switch (settings.name) {
      case RouteNames.homeBaseScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeBaseScreen(),
        );

      case RouteNames.manageEventScreen:
        ManageEventRouteModel arguments = args as ManageEventRouteModel;
        return MaterialPageRoute(
          builder: (context) => ManageEventScreen(
            event: arguments.event,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const HomeBaseScreen(),
        );
    }
  }
}
