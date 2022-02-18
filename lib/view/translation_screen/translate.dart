// Flutter imports:
import 'dart:collection';
import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Package imports:

import 'package:gyaan/app/dio/translate_dio.dart';
import 'package:gyaan/global/global.dart';

import 'package:gyaan/model/news_model.dart';
import 'package:gyaan/model/translate_model.dart';
import 'package:gyaan/services/news/offline_service.dart';
import 'package:gyaan/util/util.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gyaan/controller/settings.dart';

import 'package:gyaan/style/colors.dart';
import 'package:gyaan/style/text_style.dart';
import '../../aplication_localization.dart';

class TranslationScreen extends StatelessWidget {
  final Articles article;

  TranslationScreen(
    this.article,
  );

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
          child: Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) => Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                        constraints: BoxConstraints(
                          minHeight: Global.height(context),
                          minWidth: double.maxFinite,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 0.3),
                        ),
                        child: RepaintBoundary(
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child:
                                Stack(fit: StackFit.expand, children: <Widget>[
                              FractionallySizedBox(
                                alignment: Alignment.topCenter,
                                heightFactor: 0.4,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    article.urlToImage != null
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.surface,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  article.urlToImage,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            color: AppColor.surface,
                                          ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      height: double.maxFinite,
                                      width: double.maxFinite,
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10),
                                        child: Container(
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                    article.urlToImage != null
                                        ? GestureDetector(
                                            // onTap: () => Router.navigator.pushNamed(
                                            //   Router.expandedImageView,
                                            //   arguments: ExpandedImageViewArguments(
                                            //     image: article.urlToImage,
                                            //   ),
                                            // ),
                                            child: Center(
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                alignment: Alignment.topCenter,
                                                imageUrl: article.urlToImage,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              FractionallySizedBox(
                                alignment: Alignment.bottomCenter,
                                heightFactor: 0.6,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 25, 16, 16),
                                        child: WatchBoxBuilder(
                                          box: Hive.box<Articles>('bookmarks'),
                                          builder: (context, box) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () => handleBookmarks(
                                                    article, context),
                                                child: Text(
                                                  article.title,
                                                  style: box.containsKey(
                                                          article.url)
                                                      ? AppTextStyle.newsTitle
                                                          .copyWith(
                                                              color: AppColor
                                                                  .accent)
                                                      : AppTextStyle.newsTitle,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Text(
                                                  article.content != null
                                                      ? article.content
                                                      : "",
                                                  textAlign: TextAlign.justify,
                                                  style:
                                                      AppTextStyle.newsSubtitle,
                                                  overflow: TextOverflow.fade,
                                                  //  maxLines: 255,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        )))),
          ),
        ));
  }
}
