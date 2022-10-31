
class Activity
{
  int id;
  String introduction;
  String task;
  String process;
  List<dynamic> information;
  String avaliation;
  String conclusion;
  List<dynamic> references;
  String  subttitle;
  String  imageURL;
  String title;

  Activity({ 
    required this.id,
    required this.introduction,
    required this.task,
    required this.process,
    required this.information,
    required this.avaliation,
    required this.conclusion,
    required this.references,
    required this.subttitle,
    required this.imageURL,
    required this.title,
  });

   factory Activity.fromJson( dynamic json) {
    // print(json['id']);
    // print(json['UserId']);
    // print(json['PortugueseWord']);
    // print(json['EnglishWord']);
    // print(json['PortugueseDefinition']);
    // print(json['EnglishDefinition']);

    return Activity(
      id:  json['id'],
      introduction: json['introduction'].toString(),
      task: json['task'].toString(),
      process: json['process'].toString(),
      information: json['information'] as List<dynamic>,
      avaliation: json['avaliation'].toString(),
      conclusion: json['conclusion'].toString(),
      references: json['references'] as List<dynamic>,
      subttitle: json['subttitle'].toString(),
      imageURL: json['imageURL'].toString(),
      title: json['title'].toString(),
    );
  }

    Map toJson() => {
        'id': id,
        'introduction':introduction,
        'task':task,
        'process':process,
        'information':information,
        'avaliation':avaliation,
        'conclusion':conclusion,
        'references':references,
        'subttitle':subttitle,
        'imageURL':imageURL,
        'title':title,
      };

}
