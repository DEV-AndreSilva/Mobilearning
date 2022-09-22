import 'package:flutter/material.dart';

class Cturma extends StatelessWidget{
  final dropValue = ValueNotifier('');
  final dropOpcoes = ['Basic', 'Intermediate', 'Advanced'];

  Cturma({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold( 
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: dropValue,
          builder: (BuildContext context, String value, _){
            return SizedBox(
            width: 280,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              icon: const Icon(Icons.book_sharp),
              hint: const Text('Escolha o nível da turma'),
              decoration: InputDecoration(
                label: const Text('Nível da turma'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: (value.isEmpty) ? null : value,
              onChanged: (escolha) => dropValue.value = escolha.toString(),
              items: dropOpcoes
                .map((op) => DropdownMenuItem(
                  value: op,
                  child: Text(op),
                  ))
                  .toList()
                  ),                  
            );
          }          
      ),
      )
    );
  }
}