import 'package:flutter/material.dart';
import 'constants.dart';

void main() => runApp(FridayApp());

class FridayApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FridayPage(),
    );
  }
}

class FridayPage extends StatefulWidget {
  FridayPage({Key key}) : super(key: key);

  @override
  _FridayPageState createState() => _FridayPageState();
}

class _FridayPageState extends State<FridayPage> {
  int langType = 0;
  int fontType = 0;
  Color bgColor = Colors.white;
  Color bubbleColor = Colors.white;
  Color textColor = Colors.white;
  DateTime today = DateTime.now();


  @override
  void initState() {
    super.initState();
    bgColor = Color(0xFFFFE411);
    bubbleColor = Color(0xFFFFFFFF);
    textColor = Color(0xFF000000);
  }


  @override
  void didUpdateWidget(FridayPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  _buildShowContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
//              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            height: 60,
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              widthFactor: 1.3,
              child: Text(
                Strings.appName,
                style: TextStyle(
                  fontSize: 25,
                  color: textColor,
                ),
              ),
            ),
          ),
          Text(
            '是',
            style: TextStyle(
              fontSize: 90,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "${weekdayToString(today.weekday)} ${today.year}.${today.month}.${today.day}",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  _buildColorController() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("字体颜色"),
        ClipOval(
          child: Container(
            color: FridayColors.jikeWhite,
          ),
        )
      ],
    );
  }

  _buildControlPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1.0,
      child: Container(
        color: Color.fromARGB(30, 0, 0, 0),
        child: Column(
          children: <Widget>[
            _buildColorController(),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildShowContent(),
          _buildControlPanel(),
        ],
      )
    );
  }
}

String weekdayToString(day) {
  switch (day) {
    case 1:
      return "Sunday";
    case 2:
      return "Monday";
    case 3:
      return "Tuesday";
    case 4:
      return "Wednesday";
    case 5:
      return "Thursday";
    case 6:
      return "Friday";
    case 7:
      return "Saturday";
    default:
      return "Friday";
  }
}
