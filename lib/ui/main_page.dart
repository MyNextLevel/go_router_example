import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../tab_notifier.dart';

class MainPage extends StatelessWidget {
  final String currentUrl;

  const MainPage({Key? key, required this.currentUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TabNotifier>(
      builder: (context, tabNotifier, child) {
        return Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      tabNotifier.updateCurrentScreen(context, '/');
                    },
                    child: const Text('Home'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      tabNotifier.updateCurrentScreen(context, '/works');
                    },
                    child: const Text('Works'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      tabNotifier.updateCurrentScreen(context, '/blog');
                    },
                    child: const Text('Blog'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      tabNotifier.updateCurrentScreen(context, '/contact');
                    },
                    child: const Text('Contact'),
                  ),
                ],
              ),
              Expanded(
                child: tabNotifier.currentScreen,
              ),
            ],
          ),
        );
      },
    );
  }
}
