import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io' show Platform;
import 'startups.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InformationPage extends StatefulWidget {
  final Startup startup;
  InformationPage({
    this.startup,
  });
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  IconData selectedBookmark = kInactiveBookmark;
  final _firestore = Firestore.instance;
  bool isPlaying = false;
  FlutterTts _flutterTts;
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;

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
  void initState() {
    super.initState();
    initializeTts();
    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
    _flutterTts.stop();
  }

  initializeTts() {
    _flutterTts = FlutterTts();

    if (Platform.isAndroid) {
//      _flutterTts.ttsInitHandler(() {
//        setTtsLanguage();
//      });
      setTtsLanguage();
    } else if (Platform.isIOS) {
      setTtsLanguage();
    }

    _flutterTts.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    _flutterTts.setErrorHandler((err) {
      setState(() {
        print("error occurred: " + err);
        isPlaying = false;
      });
    });
  }

  void setTtsLanguage() async {
    await _flutterTts.setLanguage("en-US");
  }

  void speechSettings1() {
    _flutterTts.setVoice("en-us-x-sfg#male_1-local");
    _flutterTts.setPitch(1.5);
    _flutterTts.setSpeechRate(.9);
  }

  void speechSettings2() {
    _flutterTts.setVoice("en-us-x-sfg#male_2-local");
    _flutterTts.setPitch(1);
    _flutterTts.setSpeechRate(0.5);
  }

  Future _speak(String text) async {
    if (text != null && text.isNotEmpty) {
      var result = await _flutterTts.speak(text);
      if (result == 1)
        setState(() {
          isPlaying = true;
        });
    }
  }

  Future _stop() async {
    var result = await _flutterTts.stop();
    if (result == 1)
      setState(() {
        isPlaying = false;
      });
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset(
            widget.startup.photo,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: screenHeight * 0.05541,
            left: screenWidth * 0.05333,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: screenHeight * 0.04310,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.70133,
                ),
                GestureDetector(
                  onTap: () {
//                    _firestore.collection('bookmarks').add({
//                      'Image': widget.startup.bookmarkPhoto,
//                      'startup': widget.startup.startupName,
//                      'year': widget.startup.yearOfEstablishment,
//                    });
                    if (selectedBookmark == kInactiveBookmark) {
                      _firestore
                          .collection('bookmarks')
                          .document(widget.startup.id)
                          .setData({
                        'startup': widget.startup.startupName,
                        'year': widget.startup.yearOfEstablishment,
                        'Image': widget.startup.bookmarkPhoto,
                      });
                    } else {
                      _firestore
                          .collection('bookmarks')
                          .document(widget.startup.id)
                          .delete();
                    }
                    setState(() {
                      selectedBookmark = (selectedBookmark == kInactiveBookmark)
                          ? kActiveBookmark
                          : kInactiveBookmark;
                    });
                  },
                  child: Icon(
//                  Icons.bookmark,
//                  FontAwesomeIcons.bookmark,
                    selectedBookmark,
                    color: Colors.white,
                    size: screenHeight * 0.04926,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.03694,
            left: screenWidth * 0.03733,
            child: Container(
//              width: screenHeight * 0.43103,
              width: screenWidth * 0.93333,
//              height: screenHeight * 0.61576,
              height: screenHeight * 0.55418,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(screenHeight * 0.04310)),
                color: Color(0x33FFFFFF),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.02463,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.06666),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.startup.startupName,
                              style: TextStyle(
                                fontSize: screenHeight * 0.04310,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Established ${widget.startup.yearOfEstablishment}',
                              style: TextStyle(
                                fontSize: screenHeight * 0.01847,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              //speechSettings1();
                              isPlaying
                                  ? _stop()
                                  : _speak(widget.startup.description);
                            });
                          },
                          child: Icon(
                            isPlaying ? kPauseButton : kPlayButton,
                            size: screenHeight * 0.08004,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: ScrollController(
                        initialScrollOffset: screenHeight * 0.03078,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06666),
                          child: Text(
                            widget.startup.description,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.02093,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
