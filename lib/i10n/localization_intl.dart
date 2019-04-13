import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart'; //1

class FridayLocalizations {
  static Future<FridayLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    //2
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new FridayLocalizations();
    });
  }

  static FridayLocalizations of(BuildContext context) {
    return Localizations.of<FridayLocalizations>(context, FridayLocalizations);
  }

  String get appName {
    return Intl.message(
      'Is Today Friday?',
      name: 'appName',
      desc: 'Title for the Friday application',
    );
  }

  String get copyright {
    return Intl.message(
      'Copyright',
      name: 'copyright',
      desc: '',
    );
  }

  String get appIdea {
    return Intl.message(
      'The app come from an app named Jike APP in China,whichhas a group '
          '[Is today Friday?](You can visit it from the button at bottom-left.)',
      name: 'appIdea',
      desc: '',
    );
  }

  String get logoIdea {
    return Intl.message(
      'The logo of this app come from a text style of Jike APP, and the picture '
          'is generated from a website created by a Jiker.',
      name: 'logoIdea',
      desc: '',
    );
  }

  String get titleColors {
    return Intl.message(
      'Color',
      name: 'titleColors',
      desc: '',
    );
  }

  String get mainColorInfo {
    return Intl.message(
      'Main color: white(#F8F8F8)/blue(#01A9F4)/yellow(#FFE411)/black(#404040) was get from Jike website.',
      name: 'mainColorInfo',
      desc: '',
    );
  }

  String get moreColorInfo {
    return Intl.message(
      '526 kinds of color in [more color] were got from awebsite named [中国色]'
          '(The colors of China),you can visit it below.The color values at this website comes from a paper：《色谱》中科院科技情报编委会名词室.科学出版社,1957.',
      name: 'moreColorInfo',
      desc: '',
    );
  }

  String get titleFonts {
    return Intl.message(
      'Fonts',
      name: 'titleFonts',
      desc: '',
    );
  }

  String get chineseFontsInfo {
    return Intl.message(
      'Chinese fonts：ShuSong、FangSong、KaiTi、HeiTi，are free fonts by FangZheng font library.',
      name: 'chineseFontsInfo',
      desc: '',
    );
  }

  String get englishFontsInfo {
    return Intl.message(
      'English fonts: AmaticSC/Courgette/IndieFlower/Kalam/Laila/Molle/NovaFlat/PermanentMarker/PlayfairDisplay/Teko/YanoneKaffeesatz(by order), are all free fonts by google fonts website.',
      name: 'englishFontsInfo',
      desc: '',
    );
  }

  String get textColor {
    return Intl.message(
      'Text Color',
      name: 'textColor',
      desc: '',
    );
  }

  String get bgColor {
    return Intl.message(
      'Bg Color',
      name: 'bgColor',
      desc: '',
    );
  }

  String get bubbleColor {
    return Intl.message(
      'Bubble Color',
      name: 'bubbleColor',
      desc: '',
    );
  }

  String get square {
    return Intl.message(
      'Square',
      name: 'square',
      desc: '',
    );
  }

  String get full {
    return Intl.message(
      'Full',
      name: 'full',
      desc: '',
    );
  }

  String get titleCn {
    return Intl.message(
      'CN',
      name: 'titleCn',
      desc: '',
    );
  }

  String get titleEn {
    return Intl.message(
      'EN',
      name: 'titleEn',
      desc: '',
    );
  }

  String get wallpaper {
    return Intl.message(
      'Set As Wallpaper',
      name: 'wallpaper',
      desc: '',
    );
  }

  String get titleShare {
    return Intl.message(
      'Share To',
      name: 'titleShare',
      desc: '',
    );
  }

  String get group {
    return Intl.message(
      'Group Friday',
      name: 'group',
      desc: '',
    );
  }

  String get titleSave {
    return Intl.message(
      'Save Picture',
      name: 'titleSave',
      desc: '',
    );
  }

  String get title {
    return Intl.message(
      'Is today Friday?',
      name: 'title',
      desc: '',
    );
  }

  String get titleYes {
    return Intl.message(
      'YES!',
      name: 'titleYes',
      desc: '',
    );
  }

  String get titleNo {
    return Intl.message(
      'NO',
      name: 'titleNo',
      desc: '',
    );
  }

  String get moreColor {
    return Intl.message(
      'More',
      name: 'moreColor',
      desc: '',
    );
  }

  String get customColor {
    return Intl.message(
      'Custom',
      name: 'customColor',
      desc: '',
    );
  }

  String get titleBubble {
    return Intl.message(
      'Bubble',
      name: 'titleBubble',
      desc: '',
    );
  }

  String get titleBg {
    return Intl.message(
      'Background',
      name: 'titleBg',
      desc: '',
    );
  }

  String get titleText {
    return Intl.message(
      'Text',
      name: 'titleText',
      desc: '',
    );
  }

  String titleMoreColor(title) => Intl.message(
        'More $title Color',
        name: 'titleMoreColor',
        desc: '',
        args: [title],
      );

  String titleCustomColor(title) => Intl.message(
        'Custom $title Color',
        name: 'titleCustomColor',
        desc: '',
        args: [title],
      );

  String get hintInputColor {
    return Intl.message(
      'Enter a six-bit or eight-bit color value start with #',
      name: 'hintInputColor',
      desc: '',
    );
  }

  String get noticeWrongInput {
    return Intl.message(
      'Please enter valid color value.',
      name: 'noticeWrongInput',
      desc: '',
    );
  }

  String get noticeSave {
    return Intl.message(
      'The QRcode has been saved to album.',
      name: 'noticeSave',
      desc: '',
    );
  }

  String noticeDonationError(appName) => Intl.message(
      'You don\'t have $appName installed on your phone so you can\'t donate,'
      ' thanks for your support.',
      name: 'noticeDonationError',
      desc: '',
      args: [appName]);

  String get titleWechat {
    return Intl.message(
      'Donate By Wechat',
      name: 'titleWechat',
      desc: '',
    );
  }

  String get titleAlipay {
    return Intl.message(
      'Donate By Alipay',
      name: 'titleAlipay',
      desc: '',
    );
  }

  String get noticeDonation {
    return Intl.message(
      'Long click qrcode to save in album.',
      name: 'noticeDonation',
      desc: '',
    );
  }

  String get titleDonation {
    return Intl.message(
      'Donate developer.',
      name: 'titleDonation',
      desc: '',
    );
  }

  String saveFailNotice(reason) => Intl.message(
      'Save failed : $reason',
      name: 'saveFailNotice',
      desc: '',
      args: [reason]);
}

//Locale代理类
class FridayLocalizationsDelegate
    extends LocalizationsDelegate<FridayLocalizations> {
  const FridayLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<FridayLocalizations> load(Locale locale) {
    //3
    return FridayLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(FridayLocalizationsDelegate old) => false;
}
