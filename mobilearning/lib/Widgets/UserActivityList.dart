// ignore_for_file: must_be_immutable, prefer_const_constructors, file_names

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/functions.dart';
import '../Models/UserActivityModel.dart';
import 'package:dart_date/dart_date.dart';

class UserActivityList extends StatefulWidget {
  UserActivity userActivity;

  UserActivityList({super.key, required this.userActivity});

  @override
  State<UserActivityList> createState() => _UserActivityListState();
}

class _UserActivityListState extends State<UserActivityList> {
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "WebQuest:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Text(widget.userActivity.activity.title!,
                  style: TextStyle(fontSize: 20))
            ],
          ),
          SizedBox(
            width: larguraTela * 0.9,
            child: ExtendedImage.network(
              widget.userActivity.activity.imageURL!,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
          ),
          ExpansionTile(
            title: Text("More information"),
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: larguraTela * 0.4,
                        margin: EdgeInsets.only(left: larguraTela / 10),
                        child: Text(
                          "Subtitle:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(widget.userActivity.activity.subtitle!,
                          style: TextStyle(fontSize: 20))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: larguraTela * 0.4,
                        margin: EdgeInsets.only(left: larguraTela / 10),
                        child: Text(
                          "Current stage:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(widget.userActivity.currentStage,
                          style: TextStyle(fontSize: 20))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: larguraTela * 0.4,
                        margin: EdgeInsets.only(left: larguraTela / 10),
                        child: Text(
                          "Start date:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                          DateTime.parse(widget.userActivity.startDate)
                              .format('dd/MM/y'),
                          style: TextStyle(fontSize: 20))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: larguraTela * 0.4,
                        margin: EdgeInsets.only(left: larguraTela / 10),
                        child: Text(
                          "End date:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                          widget.userActivity.progress == 100
                              ? DateTime.parse(widget.userActivity.endDate)
                                  .format('dd/MM/y')
                              : "Not finished",
                          style: TextStyle(fontSize: 20))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: larguraTela * 0.4,
                        margin: EdgeInsets.only(left: larguraTela / 10),
                        child: Text(
                          "Progress:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: larguraTela / 10,
                        right: larguraTela / 10,
                        top: 10,
                        bottom: 10),
                    child: Center(
                      child: GFProgressBar(
                        percentage:
                            (widget.userActivity.progress.toDouble()) / 100,
                        lineHeight: 20,
                        progressBarColor: Colors.green,
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(21, 93, 177, 1),
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            widget.userActivity.progress != 100
                                ? "Continue"
                                : "View",
                            style: GoogleFonts.arvo(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          )),
                        ),
                      ),
                      onTap: () {
                        if (widget.userActivity.progress != 100) {
                          String route = getRouteContinue(
                              widget.userActivity.currentStage);
                          setState(() {
                            Navigator.pushNamed(context, route,
                                arguments: widget.userActivity);
                          });
                        } else {
                          setState(() {
                            Navigator.pushNamed(
                                context, "/WebQuestIntroductionView",
                                arguments: widget.userActivity);
                          });
                        }
                      },
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
