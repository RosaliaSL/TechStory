import 'package:flutter/material.dart';

class BookmarkCard extends StatelessWidget {
  BookmarkCard({
    this.screenWidth,
    this.screenHeight,
    this.yearOfEstablishment,
    this.startupName,
    this.imagePath,
    this.id,
  });

  final double screenHeight;
  final double screenWidth;
  final String startupName;
  final int yearOfEstablishment;
  final String imagePath;
  final String id;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        bottom: screenHeight * 0.01231,
        right: screenWidth * 0.07466,
        left: screenWidth * 0.07466,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Material(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(screenHeight * 0.02463),
            elevation: screenHeight * 0.00492,
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.02463,
                right: screenWidth * 0.02463,
                top: screenHeight * 0.03078,
                bottom: screenHeight * 0.03078,
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: screenHeight * 0.17241,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          startupName,
                          style: TextStyle(
                            fontSize: screenHeight * 0.03078,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.00369,
                        ),
                        Text(
                          'Established $yearOfEstablishment',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: screenHeight * 0.01847,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.23399,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(screenHeight * 0.02463),
                child: Image(
                  image: AssetImage(imagePath),
                  height: screenHeight * 0.20935,
                  fit: BoxFit.cover,
                  width: screenWidth * 0.29333,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
