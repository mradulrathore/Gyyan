import 'package:dio/dio.dart';
import 'package:gyaan/app/dio/translate_dio.dart';
import 'package:gyaan/model/translate_model.dart';

Future<String> getTranslation(String contentNews, String target) async {
  print(target);
  TranslateData content = TranslateData(target: target, text: contentNews);
  Response response = await GetTranslateDio.getTranslateDio().post(
    "",
    data: content.toJson(),
  );

  TranslateDataResponse td = TranslateDataResponse.fromJson(response.data);

  return td.text;
}
