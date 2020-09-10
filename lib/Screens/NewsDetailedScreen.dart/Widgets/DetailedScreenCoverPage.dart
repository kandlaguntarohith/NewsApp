import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailedScreenCoverPage extends StatelessWidget {
  final String imgUrl;

  const DetailedScreenCoverPage({Key key, this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              fit: BoxFit.fitHeight,
              // fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.amber,
                size: 35,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
