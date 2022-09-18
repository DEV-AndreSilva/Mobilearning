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

   factory GlossaryWord.fromJson(Map<String, dynamic> json) {
    return GlossaryWord(
      id:  int.parse(json['userId']),
      userId: int.parse(json['id']),
      englishWord: json['englishWord'].toString(),
      portugueseWord: json['portugueseWord'].toString(),
      englishDefinition: json['englishDefinition'].toString(),
      portugueseDefinition: json['portugueseDefinition'].toString()
    );
  }
}
