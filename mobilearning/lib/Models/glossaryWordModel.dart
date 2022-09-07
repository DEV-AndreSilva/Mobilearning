import 'package:flutter/cupertino.dart';

class GlossaryWord{
  int id;
  String englishWord;
  String portugueseWord;
  String englishDefinition;
  String portugueseDefinition;

  GlossaryWord(
    { required this.id,
      required this.englishWord,
      required this.portugueseWord,
      required this.englishDefinition,
      required this.portugueseDefinition,
    }
      );
}
