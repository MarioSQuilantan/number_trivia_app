import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'ui/home/home.page.dart';

class Routes {
  Routes._();
  static GoRouter get call => GoRouter(
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => const HomePage(),
          ),
        ],
      );

  static void navigateTo(BuildContext context, String route) => context.go(route);
}
