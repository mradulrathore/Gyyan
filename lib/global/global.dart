// Flutter imports:
import 'package:flutter/cupertino.dart';

class Global {
  static final List<String> lang = [
    "English",
    "हिंदी",
    "मराठी",
    "ಕನ್ನಡ",
  ];

  static height(context) => MediaQuery.of(context).size.height;
  static width(context) => MediaQuery.of(context).size.width;
  static String apikey = "564b0c25a4msh9eb9cb365915cb9p151ad1jsnc2036cdad2b0";
  static String host = "contextualwebsearch-websearch-v1.p.rapidapi.com";
}
