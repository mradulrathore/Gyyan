// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gyaan/aplication_localization.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:gyaan/model/news_model.dart';

final Box<Articles> bookmarksBox = Hive.box('bookmarks');
final Box<Articles> unreadsBox = Hive.box('unreads');

void handleBookmarks(Articles article, BuildContext context) async {
  final bool isPresent = bookmarksBox.containsKey(article.url);

  if (!isPresent) {
    bookmarksBox.put(article.url, article);
    print(bookmarksBox.length);
    Fluttertoast.showToast(
      msg: AppLocalizations.of(context).translate("Added to Bookmarks"),
      backgroundColor: Colors.black,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_SHORT,
    );
  } else {
    bookmarksBox.delete(article.url);
    print(bookmarksBox.length);

    Fluttertoast.showToast(
      msg: AppLocalizations.of(context).translate("Removed from Bookmarks"),
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}

void addArticlesToUnreads(List<Articles> articles) async {
  articles.forEach((element) {
    if (!unreadsBox.containsKey(element.url)) {
      unreadsBox.put(element.url, element);
      print('added' + "${unreadsBox.length}");
    }
  });
}

void removeArticleFromUnreads(Articles articles) {
  if (unreadsBox.containsKey(articles.url)) {
    unreadsBox.delete(articles.url);
    print('removed' + "${unreadsBox.length}");
  }
}
