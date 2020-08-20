import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_story/bookmarks_page.dart';
import 'package:tech_story/information_page.dart';
import 'package:tech_story/information_page.dart';
import 'package:tech_story/registration_screen.dart';
import 'package:tech_story/welcome_screen.dart';
import 'menu_page.dart';
import 'login_screen.dart';

void main() {
  runApp(TechStory());
}

class TechStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MenuPage.id: (context) => MenuPage(),
        BookmarksPage.id: (context) => BookmarksPage(),
      },
    );
  }
}
