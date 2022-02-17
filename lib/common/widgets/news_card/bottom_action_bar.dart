// Flutter imports:
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:gyaan/app/dio/translate_dio.dart';
import 'package:gyaan/model/translate_model.dart';
import 'package:gyaan/routes/rouut.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gyaan/controller/provider.dart';
import 'package:gyaan/model/news_model.dart';
import 'package:gyaan/services/news/offline_service.dart';
import 'package:gyaan/services/news/share_service.dart';
import 'package:gyaan/style/colors.dart';
import 'package:gyaan/style/text_style.dart';
import '../../../aplication_localization.dart';

class BottomActionBar extends StatelessWidget {
  final containerKey;
  final Articles articles;

  const BottomActionBar({
    Key key,
    this.containerKey,
    this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          actionButton(
            title: AppLocalizations.of(context).translate("share"),
            icon: FeatherIcons.share2,
            onTap: () {
              Provider.of<FeedProvider>(context, listen: false)
                  .setWatermarkVisible(true);

              Future.delayed(Duration(seconds: 2),
                  () => convertWidgetToImageAndShare(context, containerKey));
            },
          ),
          WatchBoxBuilder(
            box: Hive.box<Articles>('bookmarks'),
            builder: (context, snap) => actionButton(
              title: AppLocalizations.of(context).translate("bookmark"),
              icon: snap.containsKey(articles.url)
                  ? Icons.bookmark
                  : FeatherIcons.bookmark,
              onTap: () {
                handleBookmarks(articles, context);
              },
            ),
          ),
          // actionButton(
          //   title: AppLocalizations.of(context).translate("translate"),
          //   icon: FeatherIcons.helpCircle,
          //   onTap: () {
          //     // Todo: Implement
          //     print("Translation");
          //     Rouut.navigator.pushNamed(Rouut.translationScreen,
          //         arguments: TranslateArguments(articals: articles));
          //   },
          // )
        ],
      ),
    );
  }

  Widget actionButton({
    @required String title,
    @required IconData icon,
    @required Function onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: AppColor.accent,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: AppTextStyle.bottomActionbar,
          ),
        ],
      ),
    );
  }
}
