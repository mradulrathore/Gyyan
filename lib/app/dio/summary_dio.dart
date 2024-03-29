// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:gyaan/global/global.dart';

class GetSummaryDio {
  bool loggedIn;
  GetSummaryDio._();

  static Dio getSummaryDio() {
    Dio dio = new Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          options.connectTimeout = 90000;
          options.receiveTimeout = 90000;
          options.sendTimeout = 90000;
          options.followRedirects = true;
          options.baseUrl = "https://mew-api.herokuapp.com/summarize";
          return options;
        },
        onResponse: (Response response) async {
          return response;
        },
        onError: (DioError dioError) async {
          if (dioError.type == DioErrorType.DEFAULT) {
            if (dioError.message.contains('SocketException')) {
              print("no internet");
            }
          }

          return dioError.response; //continue
        },
      ),
    );
    return dio;
  }
}
