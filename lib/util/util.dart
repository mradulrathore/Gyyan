import 'package:dio/dio.dart';
import 'package:gyaan/app/dio/translate_dio.dart';
import 'package:gyaan/model/news_model.dart';
import 'package:gyaan/model/translate_model.dart';

Future<String> getTranslation(String contentNews, String target) async {
  TranslateData content = TranslateData(target: target, text: contentNews);
  Response response = await GetTranslateDio.getTranslateDio().post(
    "",
    data: content.toJson(),
  );

  TranslateDataResponse td = TranslateDataResponse.fromJson(response.data);

  return td.text;
}

void translateNews(List<Articles> articles, String target) async {
  for (Articles a in articles) {
    a.content = await getTranslation(a.content, target);
    a.description = await getTranslation(a.description, target);
    a.publishedAt = await getTranslation(a.publishedAt, target);
    a.sourceName = await getTranslation(a.sourceName, target);
    a.title = await getTranslation(a.title, target);
  }
}
