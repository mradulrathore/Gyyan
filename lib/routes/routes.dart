// Package imports:
import 'package:auto_route/auto_route_annotations.dart';

// Project imports:
import 'package:gyaan/view/app_base/app_base.dart';
import 'package:gyaan/view/bookmarked_screen/bookmark.dart';
import 'package:gyaan/view/discover_screen/discover.dart';
import 'package:gyaan/view/feed_screen/feed.dart';
import 'package:gyaan/view/photo_view/photo_expanded_screen.dart';
import 'package:gyaan/view/search_screen/search.dart';
import 'package:gyaan/view/settings_screen/settings.dart';
import 'package:gyaan/view/translation_screen/translate.dart';
import 'package:gyaan/view/web_screen/web.dart';

@autoRouter
class $Router {
  SearchScreen searchScreen;
  SettingsScreen settingsScreen;
  TranslationScreen translationScreen;
  BookmarkScreen bookmarkScreen;
  WebScreen webScreen;
  DiscoverScreen discoverScreen;
  FeedScreen feedScreen;
  ExpandedImageView expandedView;
  @initial
  AppBase appBase;
}
