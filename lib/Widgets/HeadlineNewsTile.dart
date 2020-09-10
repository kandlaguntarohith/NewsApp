import 'package:flutter/material.dart';
import 'package:news/Models/News.dart';
import 'package:intl/intl.dart';

class NewsHeadLineTile extends StatefulWidget {
  final News news;
  final Curve curve;
  const NewsHeadLineTile({Key key, this.news, this.curve}) : super(key: key);

  @override
  _NewsHeadLineTileState createState() => _NewsHeadLineTileState();
}

class _NewsHeadLineTileState extends State<NewsHeadLineTile>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController;
  AnimationController _animationController;

  Animation<double> _opacity;
  Animation<Offset> _position;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _position = Tween<Offset>(
      begin: Offset(-3, -1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve
        // curve: Curves.elasticOut,
        // curve: Curves.fastLinearToSlowEaseIn,
        // curve: Curves.fastOutSlowIn,
        // curve: Curves.linearToEaseOut
        // curve: Curves.slowMiddle,
      ),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateDayMonth = widget.news.publishedAt != null
        ? DateFormat.jm()
            .add_MMMd()
            .format(DateTime.parse(widget.news.publishedAt))
        : null;
    return SlideTransition(
      position: _position,
      child: FadeTransition(
        opacity: _opacity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Colors.grey.withOpacity(0.5),
              color: Colors.grey[850],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Row(
              children: <Widget>[
                widget.news.urlToImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        child: Container(
                          height: double.infinity,
                          width: 120,
                          child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: AssetImage(
                                  'assets/images/placeholderImage.png'),
                              image: NetworkImage(widget.news.urlToImage)),
                        ),
                      )
                    : Container(
                        height: double.infinity,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'NO\nIMAGE\nAVAILABLE',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                SizedBox(
                  width: 10,
                  height: double.infinity,
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      width: 205,
                      // color: Colors.white,
                      child: Text(
                        widget.news.title,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10, right: 10),
                        alignment: Alignment.bottomRight,
                        height: 40,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            // SizedBox(width: double.infinity),
                            if (widget.news.author != null)
                              if (!widget.news.author.contains('.com'))
                                Text(
                                  widget.news.author.length < 42
                                      ? widget.news.author
                                      : (widget.news.author.substring(0, 42) +
                                          '...'),
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.fade,
                                ),
                            SizedBox(height: 5),
                            if (dateDayMonth != null)
                              Text(
                                dateDayMonth,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
