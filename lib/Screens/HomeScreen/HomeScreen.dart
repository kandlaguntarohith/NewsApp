import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/Screens/HomeScreen/Widgets/HeadlineCovers.dart';
import 'package:news/Screens/SearchScreen/SearchScreen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Flash'),
            Shimmer.fromColors(
              child: Text(
                'News',
                style: TextStyle(
                  color: Colors.amber,
                ),
              ),
              baseColor: Colors.amber,
              highlightColor: Colors.red,
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.amber,
          ),
          onPressed: null,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.amber,
            ),
            onPressed: () => Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SearchScreen(),
              opaque: false,
            )),
          )
        ],
      ),
      body: HeadlineCovers(),
    );
  }
}
