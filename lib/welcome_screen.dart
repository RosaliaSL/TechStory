import 'package:flutter/material.dart';
import 'button.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF202020),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.07389,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenHeight * 0.0862,
                child: Image.asset('images/biglogo.png'),
              ),
              SizedBox(
                width: screenHeight * 0.01231,
              ),
              Text(
                'TechStory',
                style: TextStyle(
                  color: Colors.grey[200],
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.04556,
                ),
              )
            ],
          ),
          SizedBox(
            height: screenHeight * 0.03078,
          ),
          Center(
            child: Container(
              height: screenHeight * 0.46182,
              child: Image.asset('images/welcome_image.png'),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03078,
          ),
          Button(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            buttonTitle: 'Login',
            color: Color(0xB38FB8F7),
            textColor: Colors.white,
          ),
          Button(
            onPressed: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
            buttonTitle: 'Register',
            color: Color(0x33FFFFFF),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
