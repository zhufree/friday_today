import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'i10n/localization_intl.dart';

void main() => runApp(FridayApp());

class FridayApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
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
  String fontName = "kaiTi";
  Color bgColor = Colors.yellow;
  Color bubbleColor = Colors.white;
  Color textColor = Colors.black54;
  DateTime today = DateTime.now();

  int screenType = 0;

  GlobalKey screenKey = GlobalKey();
  GlobalKey scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    bgColor = Color(0xFFFFE411);
    bubbleColor = Color(0xFFFFFFFF);
    textColor = Color(0xFF000000);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Center(
              child: RepaintBoundary(
                key: screenKey,
                child: screenType == 1
                    ? AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Container(
                          color: bgColor,
                          child: _buildShowContent(),
                        ),
                      )
                    : Container(
                        color: bgColor,
                        child: _buildShowContent(),
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildControlPanel(),
            )
          ],
        ));
  }

  /// 绘制中间显示的部分
  _buildShowContent() {
    print(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
//              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            height: 60.0,
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              widthFactor: 1.3,
              child: Text(
                Strings.appName,
                style: TextStyle(
                    fontSize: 25, color: textColor, fontFamily: fontName),
              ),
            ),
          ),
          Text(
            '是',
            style:
                TextStyle(fontSize: 90, color: textColor, fontFamily: fontName),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              "${weekdayToString(today.weekday)} ${today.year}.${today.month}.${today.day}",
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor, fontFamily: fontName),
            ),
          ),
        ],
      ),
    );
  }

  /// 绘制整个控制面板
  _buildControlPanel() {
    return Container(
      padding: EdgeInsets.all(12.0),
      color: Color.fromARGB(30, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildColorController(0),
          _buildColorController(1),
          _buildColorController(2),
          Container(
            height: 30.0,
            margin: EdgeInsets.only(bottom: 8.0),
            child: new ListView(
              padding: EdgeInsets.all(0.0),
              scrollDirection: Axis.horizontal,
              children: _buildFontRow(langType),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildCommonButton(
                    Text(
                      "正方形",
                      style: TextStyle(color: FridayColors.jikeWhite),
                    ),
                    25.0,
                    () => setState(() {
                          screenType = 1;
                        })),
                _buildCommonButton(
                    Text(
                      "全屏幕",
                      style: TextStyle(color: FridayColors.jikeWhite),
                    ),
                    25.0,
                    () => setState(() {
                          screenType = 0;
                        })),
                _buildCommonButton(
                    Text(
                      "中文",
                      style: TextStyle(color: FridayColors.jikeWhite),
                    ),
                    25.0,
                    () => setState(() {
                          langType = 0;
                        })),
                _buildCommonButton(
                    Text(
                      "英文",
                      style: TextStyle(color: FridayColors.jikeWhite),
                    ),
                    25.0,
                    () => setState(() {
                          langType = 1;
                        })),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                _buildCommonButton(
                    Text(
                      "设为壁纸",
                      style: TextStyle(
                          color: FridayColors.jikeWhite, fontSize: 14.0),
                    ),
                    40.0,
                    () => {_capturePng(1)}),
                _buildCommonButton(
                    Text(
                      "分享到",
                      style: TextStyle(
                        color: FridayColors.jikeWhite,
                        fontSize: 14.0,
                      ),
                    ),
                    40.0,
                    () => {_capturePng(2)}),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                _buildCommonButton(
                    Text(
                      "周五圈子",
                      style: TextStyle(
                          color: FridayColors.jikeWhite, fontSize: 14.0),
                    ),
                    40.0,
                    _toJike),
                _buildCommonButton(
                    Text(
                      "保存图片",
                      style: TextStyle(
                        color: FridayColors.jikeWhite,
                        fontSize: 14.0,
                      ),
                    ),
                    40.0,
                    () => {_capturePng(0)}),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<File> _getLocalFile() async {
    // 获取应用目录
    Directory dir =
        new Directory((await getExternalStorageDirectory()).path + "/Friday");
    print(dir);
    if (!await dir.exists()) {
      dir.createSync();
    }
    return new File('${dir.absolute.path}/screenshot_${DateTime.now()}.png');
  }

  Future<File> _getCacheFile() async {
    // 获取应用目录
    Directory dir =
        new Directory((await getTemporaryDirectory()).path + "/Friday");
    print(dir);
    if (!await dir.exists()) {
      dir.createSync();
    }
    return new File('${dir.absolute.path}/screenshot_${DateTime.now()}.png');
  }

  static const platform =
      const MethodChannel('info.zhufree.friday_today/wallpaper');

  Future<bool> _capturePng(int type) async {
    RenderRepaintBoundary boundary =
        screenKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    try {
      File file = await (type == 0 ? _getLocalFile() : _getCacheFile());
      print(file.path);
      await file.writeAsBytes(pngBytes);
      if (type == 1) {
        await platform.invokeMethod('setWallpaper', file.path);
      } else if (type == 2) {
        await Share.file(
            'Friday', 'friday.png', pngBytes, 'image/png');
      }
      (scaffoldKey.currentState as ScaffoldState).showSnackBar(new SnackBar(
        content: new Text("Ojbk!"),
      ));
      return true;
    } catch (e) {
      (scaffoldKey.currentState as ScaffoldState).showSnackBar(new SnackBar(
        content: new Text("保存失败，${e.toString()}"),
      ));
      print(e.toString());
      return false;
    }
  }


  static const jikeUrl = "jike://page.jk/topic/565ac9dd4b715411006b5ecd";
  static const downJikeLink =
      "http://a.app.qq.com/o/simple.jsp?pkgname=com.ruguoapp.jike&ckey=CK1411402428437";

  _toJike() async {
    if (await canLaunch(jikeUrl)) {
      await launch(jikeUrl);
    } else {
      await launch(downJikeLink);
    }
  }

  _buildCommonButton(Widget text, double maxHeight, var onClick) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 8.0),
        child: Container(
          constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: 70.0),
          child: RaisedButton(
            padding: EdgeInsets.all(0.0),
            onPressed: () {
              onClick();
            },
//          onPressed: _changeColor(type, color), // 这样写颜色出不来
            child: text,
            color: FridayColors.jikeBlue.withAlpha(0xdd),
            shape: StadiumBorder(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFontRow(int langType) {
    List<Widget> fontRows = [];
    if (langType == 0) {
      fontRows.add(_buildFontChangeDot(0));
      fontRows.add(_buildFontChangeDot(-1));
      fontRows.add(_buildFontChangeDot(-2));
      fontRows.add(_buildFontChangeDot(-3));
    } else {
      for (var i = 1; i < 12; i++) {
        fontRows.add(_buildFontChangeDot(i));
      }
    }
    return fontRows;
  }

  /// 切换字体的按钮
  _buildFontChangeDot(int fontType) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      child: Container(
        width: 25.0,
        height: 25.0,
        child: RaisedButton(
//          onPressed: _changeColor(type, color), // 这样写颜色出不来
          padding: EdgeInsets.all(0.0),
          child: Text(
            getFontTitleByType(fontType),
            style: TextStyle(color: FridayColors.jikeWhite),
          ),
          onPressed: () {
            _changeFontType(fontType);
          },
          color: FridayColors.jikeBlue,
          shape: CircleBorder(
              side: BorderSide(
            color: Colors.transparent,
            width: 0,
          )),
        ),
      ),
    );
  }

  /// 绘制切换颜色的三行 [type]背景/气泡/字体
  _buildColorController(int type) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "${getTitleByType(type)}颜色",
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          _buildColorClickDot(type, FridayColors.jikeWhite),
          _buildColorClickDot(type, FridayColors.jikeYellow),
          _buildColorClickDot(type, FridayColors.jikeBlue),
          _buildColorClickDot(type, FridayColors.jikeBlack),
          Container(
            height: 30.0,
            padding: EdgeInsets.all(2.0),
            margin: EdgeInsets.only(left: 8.0),
            child: RaisedButton(
              child: Text(
                "更多颜色",
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              ),
              onPressed: () => {_showPickColorDialog(type)},
              color: Colors.black26,
              shape: StadiumBorder(),
            ),
          ),
          Container(
            height: 30.0,
            width: 70.0,
            padding: EdgeInsets.all(2.0),
            margin: EdgeInsets.only(left: 8.0),
            child: RaisedButton(
              child: Text(
                "自定义",
                style: TextStyle(fontSize: 12.0, color: Colors.white),
              ),
              onPressed: () => {_showCustomColorDialog(type)},
              color: Colors.black26,
              shape: StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }

  /// 绘制点击切换颜色的小圆点
  _buildColorClickDot(int type, Color color) {
    return Container(
      margin: EdgeInsets.only(left: 8.0),
      child: Container(
        width: 20.0,
        height: 20.0,
        child: RaisedButton(
//          onPressed: _changeColor(type, color), // 这样写颜色出不来
          onPressed: () => {_changeColor(type, color)},
          color: color,
          shape: CircleBorder(
              side: BorderSide(
            color: Colors.transparent,
            width: 0,
          )),
        ),
      ),
    );
  }

  /// 改变颜色的方法
  _changeColor(int type, Color color) {
    switch (type) {
      case bgType:
        setState(() {
          bgColor = color;
        });
        break;
      case bubbleType:
        setState(() {
          bubbleColor = color;
        });
        break;
      case textType:
        setState(() {
          textColor = color;
        });
        break;
    }
  }

  /// 显示更多颜色的dialog
  Future<void> _showPickColorDialog(int type) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          title: Text('${getTitleByType(type)}颜色'),
          content: SingleChildScrollView(
            child: Center(
              child: Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: getColorRows(type),
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// 更多颜色的颜色方块
  _buildColorPickDot(int type, Color color) {
    return GestureDetector(
      onTap: () => {_changeColor(type, color)},
      child: Container(
        child: Container(
          width: 25.0,
          height: 25.0,
          color: color,
        ),
      ),
    );
  }

  /// 获取更多颜色widget列表
  List<Widget> getColorRows(int type) {
    List<Widget> colorRows = [];
    for (var colorInt in FridayColors.colorList) {
      colorRows.add(_buildColorPickDot(type, Color(colorInt)));
    }
    return colorRows;
  }

  final TextEditingController _inputController = new TextEditingController();

  void _handleSubmitted(int type, String text) {
    _inputController.clear();
    print(int.parse("0x$text"));
    _changeColor(
        type, Color(int.parse(text.length == 8 ? "0x$text" : "0xFF$text")));
  }

  /// 显示自定义颜色的dialog
  Future<void> _showCustomColorDialog(int type) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          title: Text('自定义${getTitleByType(type)}颜色'),
          content: TextField(
            controller: _inputController,
            decoration: InputDecoration(
                hintText: "输入不带#号的六位或八位颜色值",
                hintStyle: TextStyle(fontSize: 12.0)),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                _handleSubmitted(type, _inputController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _changeFontType(int fontType) {
    setState(() {
      fontName = getFontNameByType(fontType);
    });
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

const int bgType = 0;
const int bubbleType = 1;
const int textType = 2;

String getTitleByType(type) {
  switch (type) {
    case bgType:
      return "背景";
    case bubbleType:
      return "气泡";
    case textType:
      return "文字";
    default:
      return "背景";
  }
}

const int shuType = 0;
const int fangType = -1;
const int kaiType = -2;
const int heiType = -3;
const int AmaticSC = 1;
const int Courgette = 2;
const int IndieFlower = 3;
const int Kalam = 4;
const int Laila = 5;
const int Molle = 6;
const int NovaFlat = 7;
const int PermanentMarker = 8;
const int PlayfairDisplay = 9;
const int Teko = 10;
const int YanoneKaffeesatz = 11;

String getFontTitleByType(type) {
  if (type > 0) {
    return type.toString();
  }
  switch (type) {
    case shuType:
      return "书";
    case fangType:
      return "仿";
    case kaiType:
      return "楷";
    case heiType:
      return "黑";
    default:
      return "楷";
  }
}

String getFontNameByType(type) {
  switch (type) {
    case shuType:
      return "shuSong";
    case fangType:
      return "fangSong";
    case kaiType:
      return "kaiTi";
    case heiType:
      return "heiTi";
    case AmaticSC:
      return "AmaticSC";
    case Courgette:
      return "Courgette";
    case IndieFlower:
      return "IndieFlower";
    case Kalam:
      return "Kalam";
    case Laila:
      return "Laila";
    case Molle:
      return "Molle";
    case NovaFlat:
      return "NovaFlat";
    case PermanentMarker:
      return "PermanentMarker";
    case PlayfairDisplay:
      return "PlayfairDisplay";
    case Teko:
      return "Teko";
    case YanoneKaffeesatz:
      return "YanoneKaffeesatz";
    default:
      return "kaiTi";
  }
}
