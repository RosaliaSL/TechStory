import 'package:flutter/material.dart';
import 'package:tech_story/constants.dart';
import 'package:tech_story/menu_page.dart';
import 'button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      setState(() {
        showSpinner = true;
      });
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        Navigator.pushNamed(context, MenuPage.id);
        setState(() {
          _isLoggedIn = true;
          showSpinner = false;
        });
      } else {
        setState(() {
          showSpinner = false;
        });
        Alert(
          context: context,
          title: 'Wrong Email/Password',
          desc:
              'Your email or password is incorrect. Please recheck them and try again',
        ).show();
      }
    } catch (err) {
      setState(() {
        showSpinner = false;
      });
      print(err);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF202020),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: screenHeight * 0.12315,
                  ),
                  Positioned(
                    top: screenHeight * 0.06157,
                    left: screenWidth * 0.06666,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: screenHeight * 0.03325,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  height: screenHeight * 0.27709,
                  child: Image.asset('images/register_image.png'),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04926,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05333,
                ),
                child: Text(
                  'Create Account,',
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.0431,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.05333),
                child: Text(
                  'Sign up to get started!',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: screenHeight * 0.02832,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04926,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06666,
                ),
                child: TextField(
                  style: TextStyle(
                    color: Colors.grey[200],
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Enter your email',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01231,
                      horizontal: screenWidth * 0.05333,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 0.01231)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: screenWidth * 0.002666),
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 0.01231)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: screenWidth * 0.005333),
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 0.01231)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01847,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06666,
                ),
                child: TextField(
                  style: TextStyle(
                    color: Colors.grey[200],
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Enter your password',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01231,
                      horizontal: screenWidth * 0.05333,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 0.01231)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: screenWidth * 0.002666),
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 0.01231)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: screenWidth * 0.005333),
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenHeight * 0.01231)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02463,
              ),
              Center(
                child: Button(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, MenuPage.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        showSpinner = false;
                      });
                      Alert(
                        context: context,
                        title: 'Wrong Email/Password',
                        desc:
                            'Your email or password is incorrect. Please recheck them and try again',
                      ).show();
                    }
                  },
                  buttonTitle: 'Register',
                  color: Color(0x33FFFFFF),
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01847,
              ),
              Center(
                child: Text(
                  'or sign in with',
                  style: TextStyle(color: Colors.grey[300]),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01231,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _login();
                  },
                  child: Image.asset(
                    'images/google.png',
                    width: screenWidth * 0.08,
                    height: screenHeight * 0.03694,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
