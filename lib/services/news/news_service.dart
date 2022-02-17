import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:gyaan/controller/settings.dart';
import 'package:gyaan/util/util.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gyaan/app/dio/dio.dart';
import 'package:gyaan/controller/provider.dart';
import 'package:gyaan/model/news_model.dart';
import 'package:gyaan/services/news/offline_service.dart';

abstract class NewsFeedRepository {
  Future<List<Articles>> getNewsByTopic(String topic);

  Future<List<Articles>> getNewsByCategory(String category);

  Future<List<Articles>> getNewsBySearchQuery(String query);

  Future<List<Articles>> getNewsFromLocalStorage(String box);
}

class NewsFeedRepositoryImpl implements NewsFeedRepository {
  final BuildContext context;
  NewsFeedRepositoryImpl(this.context);

  @override
  Future<List<Articles>> getNewsByTopic(String topic) async {
    final String url =
        "search/NewsSearchAPI?q=$topic&pageNumber=1&pageSize=5&autoCorrect=true";
    final provider = Provider.of<FeedProvider>(context, listen: false);
    final settings = Provider.of<SettingsProvider>(context, listen: false);

    provider.setDataLoaded(false);
    provider.setLastGetRequest("getNewsByTopic", topic);
    print("getNewsByTopic" + " " + topic);

    Response response = await GetDio.getDio().get(url);
    if (response.statusCode == 200) {
      List<Articles> articles = NewsModel.fromJson(response.data).articles;
      articles = await translateNews(articles, settings.getActiveLanguageCode())
          .then((value) {
        provider.setDataLoaded(true);
        addArticlesToUnreads(articles);
        return value;
      });

      return articles;
    } else {
      provider.setDataLoaded(true);
      throw Exception();
    }
  }

  @override
  Future<List<Articles>> getNewsByCategory(String category) async {
    final String url =
        "search/NewsSearchAPI?q=$category&pageNumber=1&pageSize=5&autoCorrect=true";
    final provider = Provider.of<FeedProvider>(context, listen: false);

    provider.setDataLoaded(false);
    provider.setLastGetRequest("getNewsByTopic", category);
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    Response response = await GetDio.getDio().get(url);
    if (response.statusCode == 200) {
      List<Articles> articles = NewsModel.fromJson(response.data).articles;
      articles = await translateNews(articles, settings.getActiveLanguageCode())
          .then((value) {
        provider.setDataLoaded(true);
        addArticlesToUnreads(articles);
        return value;
      });

      return articles;
    } else {
      provider.setDataLoaded(true);
      throw Exception();
    }
  }

  @override
  Future<List<Articles>> getNewsBySearchQuery(String query) async {
    final provider = Provider.of<FeedProvider>(context, listen: false);

    provider.setDataLoaded(false);

    final String url =
        "search/NewsSearchAPI?q=$query&pageNumber=1&pageSize=5&autoCorrect=true";
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    Response response = await GetDio.getDio().get(url);
    if (response.statusCode == 200) {
      List<Articles> articles = NewsModel.fromJson(response.data).articles;
      articles = await translateNews(articles, settings.getActiveLanguageCode())
          .then((value) {
        provider.setDataLoaded(true);
        addArticlesToUnreads(articles);
        return value;
      });
      return articles;
    } else {
      provider.setDataLoaded(true);
      throw Exception();
    }
  }

  @override
  Future<List<Articles>> getNewsFromLocalStorage(String fromBox) async {
    List<Articles> articles = [];
    final Box<Articles> hiveBox = Hive.box<Articles>(fromBox);
    final provider = Provider.of<FeedProvider>(context, listen: false);

    provider.setLastGetRequest("getNewsFromLocalStorage", fromBox);
    final settings = Provider.of<SettingsProvider>(context, listen: false);

    print(fromBox);

    if (hiveBox.length > 0) {
      for (int i = 0; i < hiveBox.length; i++) {
        Articles article = hiveBox.getAt(i);
        articles.add(article);
      }
      articles = await translateNews(articles, settings.getActiveLanguageCode())
          .then((value) {
        provider.setDataLoaded(true);
        return value;
      });

      return articles;
    } else {
      provider.setDataLoaded(true);
      List<Articles> articles = [];
      return articles;
    }
  }
}
