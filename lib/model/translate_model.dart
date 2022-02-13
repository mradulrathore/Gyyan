class TranslateData {
  TranslateData({this.target, this.text});

  String text;
  String target;

  Map<String, dynamic> toJson() => {
        "target": target,
        "text": text,
      };
}

class TranslateDataResponse {
  TranslateDataResponse({this.target, this.text});

  String text;
  String target;

  factory TranslateDataResponse.fromJson(Map<String, dynamic> json) =>
      TranslateDataResponse(
        target: json['translations'].target,
        text: json["translations"].text,
      );
}
