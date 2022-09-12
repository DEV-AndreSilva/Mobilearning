// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlossaryList extends StatefulWidget {
  int id;
  String englishWord;
  String portugueseWord;
  String englishDefinition;
  String portugueseDefinition;

GlossaryList ({super.key, 
  required this.id,
  required this.englishWord,
  required this.portugueseWord,
  required this.englishDefinition,
  required this.portugueseDefinition
});

  @override
  State<GlossaryList> createState() => _GlossaryListState();
}

class _GlossaryListState extends State<GlossaryList> {
  @override
  Widget build(BuildContext context) {
    return Card(
                key: ValueKey(widget.id),
                color: Color.fromRGBO(129,201,250,1),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ExpansionTile(
                  textColor: Colors.white,
                  title : Text(widget.englishWord,style: GoogleFonts.arvo(fontSize: 17,fontWeight: FontWeight.bold)),
                  subtitle: Text(widget.portugueseWord, style: GoogleFonts.arvo(fontSize: 17)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,bottom: 10),
                      child: Column(
                        children: [

                          Padding(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  child: Column(
                                    children: [
                                      Text("English Definition:",
                                          style: GoogleFonts.arvo(fontSize: 17,fontWeight: FontWeight.bold)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(child: Text(widget.englishDefinition, style: GoogleFonts.arvo(fontSize: 16))),
                                        ],
                                        ),],
                                  ),
                            ),

                            Padding(
                                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                                  child: Column(
                                    children: [
                                      Text("Portuguese Definition:",
                                          style: GoogleFonts.arvo(fontSize: 17,fontWeight: FontWeight.bold)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(child: Text(widget.portugueseDefinition, style: GoogleFonts.arvo(fontSize: 16))),
                                        ],
                                        ),],
                                  ),
                            ),
                          
                       
                        ],
                      ),
                    ),
                    
                  ],
                )
                );

  }
}