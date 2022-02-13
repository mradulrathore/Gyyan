// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gyaan/common/widgets/news_card/bottom_bar.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gyaan/controller/settings.dart';
import 'package:gyaan/global/global.dart';
import 'package:gyaan/style/colors.dart';
import 'package:gyaan/style/text_style.dart';
import '../../aplication_localization.dart';

class TranslationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(),
      ),
    );
  }
}
