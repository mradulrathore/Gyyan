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
  String text;
  String to;

  TranslateDataResponse({this.text, this.to});

  TranslateDataResponse.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String;
    to = json['to'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['to'] = this.to;
    return data;
  }
}
