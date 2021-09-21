// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gyaan/bloc/feed/news_feed_bloc.dart';
import 'package:gyaan/bloc/serach_feed/search_feed_bloc.dart';
import 'package:gyaan/controller/settings.dart';
import 'package:gyaan/routes/rouut.dart';
import 'package:gyaan/services/news/news_service.dart';
import 'package:gyaan/style/theme.dart';
import '../aplication_localization.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //

    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsFeedBloc>(
          create: (context) =>
              NewsFeedBloc(repository: NewsFeedRepositoryImpl(context)),
        ),
        BlocProvider<SearchFeedBloc>(
          create: (context) =>
              SearchFeedBloc(repository: NewsFeedRepositoryImpl(context)),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Gyaan",
          theme: kLightThemeData,
          darkTheme: kDarkThemeData,
          themeMode:
              Provider.of<SettingsProvider>(context, listen: true).isDarkThemeOn
                  ? ThemeMode.dark
                  : ThemeMode.light,
          onGenerateRoute: Rouut.onGenerateRoute,
          navigatorKey: Rouut.navigatorKey,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('hi', 'IN'),
            Locale('mr', 'IN'),
            Locale('kn', 'IN'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }

            return supportedLocales.first;
          },
          locale: Locale(
              Provider.of<SettingsProvider>(context, listen: true)
                  .getActiveLanguageCode(),
              "IN")),
    );

    //
  }
}
