import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'ui/ui.dart';

enum Screen { home, works, blog, contact }

class TabNotifier extends ChangeNotifier {
  Screen _screen = Screen.home;

  Screen get screen => _screen;

  Widget _currentScreen = const SizedBox();

  Widget get currentScreen => _currentScreen;

  void changeScreen(BuildContext context, Screen value) {
    _screen = value;
    switch (value) {
      case Screen.home:
        context.go('/');
        break;
      case Screen.works:
        context.go('/works');
        break;
      case Screen.blog:
        context.go('/blog');
        break;
      case Screen.contact:
        context.go('/contact');
        break;
      default:
        context.go('/');
        break;
    }
    notifyListeners();
  }

  void updateCurrentScreen(BuildContext context,String screen) {
    context.go(screen);
    switch(screen) {
      case '/':
        _currentScreen= const HomePage();
        break;
      case '/works':
        _currentScreen= const WorksPage();
        break;
      case '/blog':
        _currentScreen= const BlogPage();
        break;
      case '/contact':
        _currentScreen= const ContactPage();
        break;
      default:
        _currentScreen= const HomePage();
        break;
    }
    notifyListeners();
  }
}