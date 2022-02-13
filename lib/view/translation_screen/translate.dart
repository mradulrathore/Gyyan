// Flutter imports:
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Package imports:

import 'package:gyaan/app/dio/translate_dio.dart';

import 'package:gyaan/model/news_model.dart';
import 'package:gyaan/model/translate_model.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gyaan/controller/settings.dart';

import 'package:gyaan/style/colors.dart';
import 'package:gyaan/style/text_style.dart';
import '../../aplication_localization.dart';

class TranslationScreen extends StatelessWidget {
  final Articles articles;

  TranslationScreen(
    this.articles,
  );

  var languages = {
    'Afrikaans',
    'Albanian',
    'Amharic',
    'Arabic',
    'Armenian',
    'Assamese',
    'Azerbaijani',
    'Bangla',
    'Bashkir',
    'Bosnian(Latin)',
    'Bulgarian',
    'Cantonese(Traditional)',
    'Catala',
    'Chinese(Literary)',
    'Chinese Simplified',
    'Chinese Traditional',
    'Croatian',
    'Czech',
    'Danish',
    'Dari',
    'Divehi',
    'Dutch',
    'English',
    'Estonian',
    'Fijian',
    'Filipino',
    'Finnish',
    'French',
    'French(Canada)',
    'Georgian',
    'German',
    'Greek',
    'Gujarati',
    'Haitian Creole',
    'Hebrew',
    'Hindi',
    'Hmong Daw',
    'Hungarian',
    'Icelandic',
    'Indonesian	',
    'Inuinnaqtun',
    'Kannada',
    'Japanese',
    'Malayalam',
    'Marathi',
    'Nepali',
    'Punjabi',
    'Russian',
    'Telugu',
    'Tamil',
    'Urdu'
  };

  HashMap languageCodeMap;

  _getThingsOnStartup() async {
    languageCodeMap = new HashMap<String, String>();
    languageCodeMap['Afrikaans'] = "";
    languageCodeMap['Albanian'] = "";
    languageCodeMap['Amharic'] = "";
    languageCodeMap['Arabic'] = "";
    languageCodeMap['Armenian'] = "";
    languageCodeMap['Assamese'] = "";
    languageCodeMap['Azerbaijani'] = "";
    languageCodeMap['Bangla'] = "";
    languageCodeMap['Bashkir'] = "";
    languageCodeMap['Bosnian(Latin)'] = "";
    languageCodeMap['Bulgarian'] = "";
    languageCodeMap['Cantonese(Traditional)'] = "";
    languageCodeMap['Catalan'] = "";
    languageCodeMap['Chinese(Literary)'] = "";
    languageCodeMap['Chinese Simplified'] = "";
    languageCodeMap['Chinese Traditional'] = "";
    languageCodeMap['Croatian'] = "";
    languageCodeMap['Czech'] = "";
    languageCodeMap['Danish'] = "";
    languageCodeMap['Dari'] = "";
    languageCodeMap['Divehi'] = "";
    languageCodeMap['Dutch'] = "";
    languageCodeMap['English'] = "";
    languageCodeMap['Estonian'] = "";
    languageCodeMap['Fijian'] = "";
    languageCodeMap['Filipino'] = "";
    languageCodeMap['Finnish'] = "";
    languageCodeMap['French'] = "";
    languageCodeMap['French(Canada)'] = "";
    languageCodeMap['Georgian'] = "";
    languageCodeMap['German'] = "";
    languageCodeMap['Greek'] = "";
    languageCodeMap['Gujarati'] = "";
    languageCodeMap['Haitian Creole'] = "";
    languageCodeMap['Hebrew'] = "";
    languageCodeMap['Hindi'] = "";
    languageCodeMap['Hmong Daw'] = "";
    languageCodeMap['Hungarian'] = "";
    languageCodeMap['Icelandic'] = "";
    languageCodeMap['Indonesian	'] = "";
    languageCodeMap['Inuinnaqtun'] = "";
    languageCodeMap['Kannada'] = "";
    languageCodeMap['Japanese'] = "";
    languageCodeMap['Malayalam'] = "";
    languageCodeMap['Marathi'] = "";
    languageCodeMap['Nepali'] = "";
    languageCodeMap['Punjabi'] = "";
    languageCodeMap['Russian'] = "";
    languageCodeMap['Telugu'] = "";
    languageCodeMap['Tamil'] = "";
    languageCodeMap['Urdu'] = "";
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
        onInit: () {
          _getThingsOnStartup();
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text(
              AppLocalizations.of(context).translate('translate'),
              style: AppTextStyle.appBarTitle.copyWith(
                fontSize: 18,
                color: Provider.of<SettingsProvider>(context, listen: false)
                        .isDarkThemeOn
                    ? AppColor.background
                    : AppColor.onBackground,
              ),
            ),
          ),
          body: SafeArea(
            bottom: false,
            child: Container(
              // child: Text(getTranslation(articles.description, "hi");),
              child: Text(articles.description),
            ),
          ),
        ));
  }

  Future<String> getTranslation(String contentNews, String target) async {
    TranslateData content = TranslateData(target: target, text: contentNews);
    Response response = await GetTranslateDio.getTranslateDio().request("",
        data: content.toJson(),
        options: Options(method: "get", contentType: Headers.jsonContentType));

    print(response.data);

    return "hi";
  }
}

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({@required this.onInit, @required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
