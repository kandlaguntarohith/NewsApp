import 'package:flutter/material.dart';

class DetailedScreenHeadlineText extends StatelessWidget {
  final String headlineText;

  const DetailedScreenHeadlineText({Key key, this.headlineText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: Text(
        headlineText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
