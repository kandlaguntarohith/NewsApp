import 'package:flutter/material.dart';
import 'package:news/Models/News.dart';
import 'package:url_launcher/url_launcher.dart';

class CoverTile extends StatelessWidget {
  final News news;
  const CoverTile({Key key, this.news}) : super(key: key);
  launchURL(String url, context) async {
    try {
      if (await canLaunch(url))
        await launch(
          url,
          forceWebView: true,
          enableJavaScript: true,
        );
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Url Broken !',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black.withOpacity(0.9),
        ),
      );
      throw 'Url Broken !';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchURL(news.url, context),
      child: Stack(
        children: <Widget>[
          news.urlToImage != null
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder:
                        AssetImage('assets/images/placeholderImage.png'),
                    image: NetworkImage(news.urlToImage),
                  ),
                )
              : Container(),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.95),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.1,
                  0.95,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 15,
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width - 50,
              child: Text(
                news.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
