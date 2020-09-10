import 'package:flutter/material.dart';

class DetailedScreenContentText extends StatelessWidget {
  final String contentText;

  const DetailedScreenContentText({Key key, this.contentText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: Text(
        contentText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
