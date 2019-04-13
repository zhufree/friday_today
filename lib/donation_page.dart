import 'package:flutter/material.dart';
import 'i10n/localization_intl.dart';
import 'dart:typed_data';
import 'file_manager.dart';
import 'dart:io';

class DonationPage extends StatefulWidget {
  DonationPage({Key key}) : super(key: key);

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  String donationImgName = "images/wechat_donation.png";

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(FridayLocalizations.of(context).titleDonation),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(FridayLocalizations.of(context).noticeDonation)),
            GestureDetector(
              onLongPress: () => {_saveImgFile()},
              child: Image.asset(
                donationImgName,
                width: 230.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8.0),
                    child: RaisedButton(
                      child: Text(
                        FridayLocalizations.of(context).titleWechat,
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                      shape: StadiumBorder(),
                      onPressed: () => {
                            setState(() {
                              donationImgName = "images/wechat_donation.png";
                            })
                          },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8.0),
                    child: RaisedButton(
                      child: Text(FridayLocalizations.of(context).titleAlipay),
                      shape: StadiumBorder(),
                      onPressed: () => {
                            setState(() {
                              donationImgName = "images/alipay_donation.jpg";
                            })
                          },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveImgFile() async {
    File file = await getLocalFile(donationImgName.substring(7));
    DefaultAssetBundle.of(context)
        .load(donationImgName)
        .then((data) {
      Uint8List pngBytes = data.buffer.asUint8List();
      file.writeAsBytes(pngBytes);
    });
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(
        FridayLocalizations.of(context).noticeSave
    )));
  }
}
