
class Activity
{
  int? id;
  int? idTeacher;
  String? introduction;
  String? task;
  String? process;
  List<dynamic>? information;
  String? evaluation;
  String? conclusion;
  List<dynamic>? references;
  String?  subtitle;
  String?  imageURL;
  String? title;

  Activity({ 
     this.id,
     this.idTeacher,
     this.introduction,
     this.task,
     this.process,
     this.information,
     this.evaluation,
     this.conclusion,
     this.references,
     this.subtitle,
     this.imageURL,
     this.title,
  });

   factory Activity.fromJson( dynamic json) {
     print(json['id']);
    // print(json['UserId']);
    // print(json['PortugueseWord']);
    // print(json['EnglishWord']);
    // print(json['PortugueseDefinition']);
    // print(json['EnglishDefinition']);

    return Activity(
      id:  json['id'],
      idTeacher:  json['idTeacher'],
      introduction: json['introduction'].toString(),
      task: json['task'].toString(),
      process: json['process'].toString(),
      information: json['information'] as List<dynamic>,
      evaluation: json['evaluation'].toString(),
      conclusion: json['conclusion'].toString(),
      references: json['references'] as List<dynamic>,
      subtitle: json['subtitle'].toString(),
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
        'evaluation':evaluation,
        'conclusion':conclusion,
        'references':references,
        'subtitle':subtitle,
        'imageURL':imageURL,
        'title':title,
      };

}
