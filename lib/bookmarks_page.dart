import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_story/menu_page.dart';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'menu_page.dart';
import 'card.dart';
import 'welcome_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BookmarksPage extends StatefulWidget {
  static String id = 'bookmarks_page';
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final _firestore = Firestore.instance;
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
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
//          Expanded(
//            flex: 6,
//            child: ListView(
//              children: [
//                BookmarkCard(
//                  screenHeight: screenHeight,
//                  screenWidth: screenWidth,
//                  yearOfEstablishment: 2008,
//                  startupName: 'Zomato',
//                  imagePath: 'images/zomato1.png',
//                ),
//                BookmarkCard(
//                  screenHeight: screenHeight,
//                  screenWidth: screenWidth,
//                  yearOfEstablishment: 2008,
//                  startupName: 'cure.fit',
//                  imagePath: 'images/curefit1.png',
//                ),
//                BookmarkCard(
//                  screenHeight: screenHeight,
//                  screenWidth: screenWidth,
//                  yearOfEstablishment: 2012,
//                  startupName: 'Nykaa',
//                  imagePath: 'images/nykaa1.jpeg',
//                ),
//              ],
//            ),
//          ),
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
              List<BookmarkCard> startupWidgets = [];
              for (var bookmark in bookmarks) {
                final name = bookmark.data['startup'];
                final year = bookmark.data['year'];
                final imagePath = bookmark.data['Image'];
                final startupWidget = BookmarkCard(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  yearOfEstablishment: year,
                  startupName: name,
                  imagePath: imagePath,
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
//                onTap: () {
//                  _auth.signOut();
//                  Navigator.pop(context);
//                },
                      child: GestureDetector(
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
                          size: screenHeight * 0.059113,
                        ),
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
//                          color: Colors.grey,
                        color: Color(0xD9FFFFFF),
//                      Icons.bookmark,
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
