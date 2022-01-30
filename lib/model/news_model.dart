// Package imports:
import 'package:hive/hive.dart';

part 'news_model.g.dart';

class NewsModel {
  String status;
  int totalResults;
  List<Articles> articles;

  NewsModel({this.status, this.totalResults, this.articles});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalCount'];
    if (json['value'] != null) {
      // ignore: deprecated_member_use
      articles = new List<Articles>();
      json['value'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalCount'] = this.totalResults;
    if (this.articles != null) {
      data['value'] = this.articles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//flutter pub run build_runner build
@HiveType(typeId: 101)
class Articles {
  @HiveField(0)
  String sourceName;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String url;
  @HiveField(4)
  String urlToImage;
  @HiveField(5)
  String publishedAt;
  @HiveField(6)
  String content;

  Articles(
      {this.sourceName,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    sourceName = json['provider'] != null
        ? new ProviderS.fromJson(json['provider']).name
        : null;
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage =
        json['image'] != null ? new ImageS.fromJson(json['image']).url : null;
    publishedAt = json['datePublished'];
    content = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sourceName != null) {
      data['provider'] = this.sourceName;
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    data['datePublished'] = this.publishedAt;
    data['body'] = this.content;
    return data;
  }
}

class ProviderS {
  String name;

  ProviderS({this.name});

  ProviderS.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class ImageS {
  String url;

  ImageS({this.url});

  ImageS.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
