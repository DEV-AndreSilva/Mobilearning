// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, avoid_function_literals_in_foreach_calls

class GlossaryWord{
  int  id;
  int userId;
  String englishWord;
  String portugueseWord;
  String englishDefinition;
  String portugueseDefinition;

  GlossaryWord(
    { required this.id,
      required this.userId,
      required this.englishWord,
      required this.portugueseWord,
      required this.englishDefinition,
      required this.portugueseDefinition,
    });

   factory GlossaryWord.fromJson( dynamic json) {
     print(json['id']);
    // print(json['UserId']);
    // print(json['PortugueseWord']);
    // print(json['EnglishWord']);
    // print(json['PortugueseDefinition']);
    // print(json['EnglishDefinition']);

    return GlossaryWord(
      id:  json['id'],
      userId: json['userId'],
      englishWord: json['englishWord'].toString(),
      portugueseWord: json['portugueseWord'].toString(),
      englishDefinition: json['englishDefinition'].toString(),
      portugueseDefinition: json['portugueseDefinition'].toString()
    );
  }

    Map toJson() => {
        'id': id,
        'userId': userId,
        'englishWord':englishWord,
        'portugueseWord':portugueseWord,
        'englishDefinition':englishDefinition,
        'portugueseDefinition':portugueseDefinition
      };
}
