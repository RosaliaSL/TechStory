import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tech_story/information_page.dart';
import 'menu_page.dart';
import 'card.dart';
import 'welcome_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'startups.dart';

class BookmarksPage extends StatefulWidget {
  static String id = 'bookmarks_page';
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool _isLoggedIn = true;

  void _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  void bookmarksStream() async {
    await for (var snapshot in _firestore.collection('bookmarks').snapshots()) {
      for (var bookmark in snapshot.documents) {
        print(bookmark.data);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    bookmarksStream();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.06773,
              left: screenWidth * 0.06666,
            ),
            child: Text(
              'Bookmarks',
              style: TextStyle(
                fontSize: screenHeight * 0.04926,
                fontWeight: FontWeight.bold,
                color: Color(0xD9FFFFFF),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('bookmarks').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }
              final bookmarks = snapshot.data.documents;
              List<GestureDetector> startupWidgets = [];
              for (var bookmark in bookmarks) {
                final name = bookmark.data['startup'];
                final year = bookmark.data['year'];
                final imagePath = bookmark.data['Image'];
                Startup startup1;
                for (var startup in startups) {
                  if (startup.startupName == name) {
                    startup1 = startup;
                  }
                }
                final startupWidget = GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return InformationPage(
                        startup: startup1,
                      );
                    }));
                  },
                  child: BookmarkCard(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    yearOfEstablishment: year,
                    startupName: name,
                    imagePath: imagePath,
                  ),
                );
                startupWidgets.add(startupWidget);
              }
              return Expanded(
                flex: 6,
                child: ListView(
                  children: startupWidgets,
                ),
              );
            },
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.08,
                  right: screenWidth * 0.08,
                  bottom: screenHeight * 0.039408,
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
                        Icons.exit_to_app,
                        color: Colors.grey[700],
                        size: screenHeight * 0.059113,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: screenHeight * 0.00246,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, MenuPage.id);
                        },
                        child: Icon(
                          FontAwesomeIcons.compass,
                          color: Colors.grey[700],
                          size: screenHeight * 0.05049,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.00492),
                      child: Icon(
                        FontAwesomeIcons.bookmark,
                        color: Color(0xD9FFFFFF),
                        size: screenHeight * 0.043103,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
