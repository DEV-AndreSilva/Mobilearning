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
    // print(json['ID']);
    // print(json['UserId']);
    // print(json['PortugueseWord']);
    // print(json['EnglishWord']);
    // print(json['PortugueseDefinition']);
    // print(json['EnglishDefinition']);

    return GlossaryWord(
      id:  1,
      userId: 2,
      englishWord: json['EnglishWord'].toString(),
      portugueseWord: json['PortugueseWord'].toString(),
      englishDefinition: json['EnglishDefinition'].toString(),
      portugueseDefinition: json['PortugueseDefinition'].toString()
    );
  }
}
