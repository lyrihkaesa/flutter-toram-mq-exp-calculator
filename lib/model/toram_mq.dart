class ToramMQModel {
  int chapter;
  String chapterid;
  String chapteren;
  int episode;
  String episodeid;
  String episodeen;
  int exp;

  ToramMQModel({
    required this.chapter,
    required this.chapterid,
    required this.chapteren,
    required this.episode,
    required this.episodeid,
    required this.episodeen,
    required this.exp,
  });

  factory ToramMQModel.fromJson(Map<String, dynamic> json) {
    return ToramMQModel(
      chapter: json['chapter'] as int,
      chapterid: json['chapterid'] as String,
      chapteren: json['chapteren'] as String,
      episode: json['episode'] as int,
      episodeid: json['episodeid'] as String,
      episodeen: json['episodeen'] as String,
      exp: json['exp'] as int,
    );
  }
}

// void main(List<String> args) {
//   var toramMqListJson = jsonDecode('/assets/list-mq.json')['listMQ'] as List;
//   List<ToramMQModel> toramMqList =
//       toramMqListJson.map((json) => ToramMQModel.fromJson(json)).toList();
//   print(toramMqList);
// }
