// ignore_for_file: must_be_immutable, prefer_const_constructors, file_names

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/activityModel.dart';

class ActivityList extends StatefulWidget {
  Activity activity;

  ActivityList({super.key, required this.activity});

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  @override
  Widget build(BuildContext context) {
    var larguraTela = MediaQuery.of(context).size.width;

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: larguraTela*0.45,
                child: Text(
                  "WebQuest:",
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: larguraTela*0.45,
                child: Text(widget.activity.title, style: TextStyle(fontSize: 20)))
            ],
          ),
          SizedBox(
            width: larguraTela * 0.9,
            child: ExtendedImage.network(
              widget.activity.imageURL,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
          ),
          ExpansionTile(
            title: Text("More information"),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.only(left: 5,right: 5),
                    child: GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange[700],
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.white,),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                          "Edit",
                          style: GoogleFonts.arvo(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                        ),
                                ),
                              ],
                            )),
                      ),
                      onTap: () => {
                        setState(() {
                          Navigator.pushNamed(
                              context, "/WebQuestBasicInfoManage",
                              arguments: widget.activity);
                        })
                      },
                    ),
                  ),

                   Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.only(left: 5,right: 5),
                    child: GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:Colors.red[700],
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.white),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Text(
                          "Delete",
                          style: GoogleFonts.arvo(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                        ),
                                ),
                              ],
                            )),
                      ),
                      onTap: () => {
                        setState(() {
                          Navigator.pushNamed(
                              context, "/WebQuestBasicInfoManage",
                              arguments: widget.activity);
                        })
                      },
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
