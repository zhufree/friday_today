import 'package:flutter/material.dart';
import 'i10n/localization_intl.dart';

class CopyRightPage extends StatelessWidget {
  CopyRightPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FridayLocalizations.of(context).copyright),
      ),
      body: ListView(
        children: <Widget>[
          _buildTitle(FridayLocalizations.of(context).copyright),
          _buildDesc(FridayLocalizations.of(context).appIdea),
          _buildDesc(FridayLocalizations.of(context).logoIdea),
          _buildTitle(FridayLocalizations.of(context).titleColors),
          _buildDesc(FridayLocalizations.of(context).mainColorInfo),
          _buildDesc(FridayLocalizations.of(context).moreColorInfo),
          _buildTitle(FridayLocalizations.of(context).titleFonts),
          _buildDesc(FridayLocalizations.of(context).chineseFontsInfo),
          _buildDesc(FridayLocalizations.of(context).englishFontsInfo),
        ],
      ),
    );
  }

  _buildTitle(title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  _buildDesc(title) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
