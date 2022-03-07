import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'ui/ui.dart';
import 'tab_notifier.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TabNotifier(),
      child: MaterialApp.router(
        title: 'Go router example',
        debugShowCheckedModeBanner: false,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }

  final _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        path: '/:url',
        builder: (context, GoRouterState state) {
          debugPrint('========> state location: ${state.location}');
          debugPrint('========> state params: ${state.params}');
          return MainPage(
            key: state.pageKey,
            currentUrl: state.params['url'] ?? '',
          );
        },
        // routes: [
        //   GoRoute(
        //     path: '/home',
        //     builder: (context, GoRouterState state) {
        //       debugPrint('========> state location ${state.location}');
        //       return const HomePage();
        //     },
        //   ),
        //   GoRoute(
        //     path: '/works',
        //     builder: (context, GoRouterState state) {
        //       debugPrint('========> state location ${state.location}');
        //       return const WorksPage();
        //     },
        //   ),
        //   GoRoute(
        //     path: '/blog',
        //     builder: (context, GoRouterState state) {
        //       debugPrint('========> state location ${state.location}');
        //       return const BlogPage();
        //     },
        //   ),
        //   GoRoute(
        //     path: '/contact',
        //     builder: (context, GoRouterState state) {
        //       debugPrint('========> state location ${state.location}');
        //       return const ContactPage();
        //     },
        //   ),
        // ],
      ),
    ],
  );
}
