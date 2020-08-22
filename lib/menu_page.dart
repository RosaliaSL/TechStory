import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tech_story/bookmarks_page.dart';
import 'package:tech_story/welcome_screen.dart';
import 'startups.dart';
import 'information_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bookmarks_page.dart';
import 'dart:io' show Platform;
import 'package:google_sign_in/google_sign_in.dart';

class MenuPage extends StatefulWidget {
  static String id = 'menu_page';
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _currentIndex = 0;
  List companyImages = [
    'images/zomato1.png',
    'images/curefit4.png',
    'images/nykaa6.jpeg',
  ];

  List<String> companyText = [
    'Zomato',
    'Cure.Fit',
    'Nykaa',
  ];

  List<String> yearEstablished = [
    'Established July 2008',
    'Established July 2016',
    'Established April 2012',
  ];

  List<int> buildIndex() {
    List<int> indices = [];
    for (int i = 0; i < companyText.length; i++) {
      indices.add(i);
    }
    return indices;
  }

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool _isLoggedIn = true;

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser();
    try {
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double space = 30;

    return Scaffold(
//      backgroundColor: Colors.white,
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(
                screenHeight * 0.03078,
              ),
              child: Text(
                'Find your next\nstory',
                style: TextStyle(
                  fontSize: screenHeight * 0.04926,
                  fontWeight: FontWeight.bold,
                  color: Color(0xD9FFFFFF),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01231,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: screenHeight * 0.59113,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(
                  seconds: 3,
                ),
              ),
              items: buildIndex().map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.01333,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.07389),
                          child: Stack(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return InformationPage(
                                      startup: startup[i],
                                    );
                                  }));
                                },
                                child: Image.asset(companyImages[i]),
                              ),
                              Positioned(
                                bottom: screenHeight * 0.06157,
                                left: screenWidth * 0.10666,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      companyText[i],
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.07758,
                                        color: Color(0xBFFFFFFF),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      yearEstablished[i],
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.03694,
                                        color: Color(0xBFFFFFFF),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.02463, right: screenWidth * 0.02463),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.02666,
                    right: screenWidth * 0.02666,
                    bottom: Platform.isIOS ? 0 : screenHeight * 0.039408,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _logout();
                          _auth.signOut();
                          Navigator.pushNamed(context, WelcomeScreen.id);
                        },
                        child: Icon(
//                        Icons.person_outline,
                          Icons.exit_to_app,
//                        color: Colors.grey,
                          color: Colors.grey[700],
                          size: screenHeight * 0.05911,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: screenHeight * 0.00246),
                        child: Icon(
                          FontAwesomeIcons.compass,
                          color: Color(0xD9FFFFFF),
                          size: screenHeight * 0.05049,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: screenHeight * 0.00492),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, BookmarksPage.id);
                          },
                          child: Icon(
                            FontAwesomeIcons.bookmark,
                            color: Colors.grey[700],
                            size: screenHeight * 0.043103,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
