import 'package:flutter/material.dart';
import 'package:gg_hanoi/model/rod.dart';
import 'package:gg_hanoi/view/game_view.dart';
import 'package:go_router/go_router.dart';
import 'package:gg_hanoi/view/configuration_view.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  // setUrlStrategy(PathUrlStrategy());
  runApp(const GGHanoiGame());
}

class GGHanoiGame extends StatelessWidget {
  const GGHanoiGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'GG Hanoi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ConfigurationView(
          title: 'GG Hanoi',
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/game',
          builder: (BuildContext context, GoRouterState state) {
            return GameView(
              title: 'GG Hanoi',
              rods: (state.extra as List<Rod>?) ??
                  basicRods(
                    portrait: false,
                  ),
            );
          },
        ),
      ],
    ),
  ],
);
