import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'ui/ui.dart';

class TabNotifier extends ChangeNotifier {

  Widget _currentScreen = const HomePage();

  Widget get currentScreen => _currentScreen;

  void updateCurrentScreen(BuildContext context,String screen) {
    context.go(screen);
    switch(screen) {
      case '/home':
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