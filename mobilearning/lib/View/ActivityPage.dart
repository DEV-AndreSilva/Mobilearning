// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../Widgets/ActivityList.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<ActivityList> listActivity = [
    ActivityList(
        webQuest: "Past Tense",
        imageURL:
            "https://th.bing.com/th/id/R.595da56c25fb18454359d9bf91c5432c?rik=lggN0IN4O53ECg&riu=http%3a%2f%2fwww.pixelstalk.net%2fwp-content%2fuploads%2f2016%2f04%2fImages-photos-landscape-wallpaper-HD.jpg&ehk=sAIIB517XpgH6aP3FLebJUZMNJJZigG4IhGUky4rld8%3d&risl=&pid=ImgRaw&r=0",
        title: "Past Perfect",
        currentStage: "Introduction",
        startDate: "25/08/2022",
        endDate: "22/09/2022",
        progress: 0.9),
    ActivityList(
        webQuest: "Past Tense",
        imageURL:
            "https://th.bing.com/th/id/R.595da56c25fb18454359d9bf91c5432c?rik=lggN0IN4O53ECg&riu=http%3a%2f%2fwww.pixelstalk.net%2fwp-content%2fuploads%2f2016%2f04%2fImages-photos-landscape-wallpaper-HD.jpg&ehk=sAIIB517XpgH6aP3FLebJUZMNJJZigG4IhGUky4rld8%3d&risl=&pid=ImgRaw&r=0",
        title: "Present Perfect",
        currentStage: "Introduction",
        startDate: "25/08/2022",
        endDate: "22/09/2022",
        progress: 0.9),
    ActivityList(
        webQuest: "Past Tense",
        imageURL:
            "https://th.bing.com/th/id/R.595da56c25fb18454359d9bf91c5432c?rik=lggN0IN4O53ECg&riu=http%3a%2f%2fwww.pixelstalk.net%2fwp-content%2fuploads%2f2016%2f04%2fImages-photos-landscape-wallpaper-HD.jpg&ehk=sAIIB517XpgH6aP3FLebJUZMNJJZigG4IhGUky4rld8%3d&risl=&pid=ImgRaw&r=0",
        title: "Future Sentence",
        currentStage: "Introduction",
        startDate: "25/08/2022",
        endDate: "22/09/2022",
        progress: 0.9),
  ];

  // lista de dados que sera exibida
  List<ActivityList> foundActivity = [];

  // Função que é chamada quando o campo de texto muda
  void runFilter(String enteredKeyword) {
    List<ActivityList> results = [];

    // Se o Campo de texto está em branco ou com apenas espaços exibe todos os registros
    if (enteredKeyword.isEmpty) {
      results = listActivity;
    } else {
      // Preenche a nova lista de resultados apenas com os nomes que possuem o texto procurado
      results = listActivity
          .where((activity) => activity.title
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      foundActivity = results;
    });
  }

  @override
  initState() {
    //No começo todos os dados serão exibidos
    foundActivity = listActivity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //search bar
        Padding(
          padding: EdgeInsets.only(top: 10, left: 25, right: 25),
          child: TextField(
            onChanged: (value) => runFilter(value),
            decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100))),
          ),
        ),

        SizedBox(
          width: 16,
        ),

        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: foundActivity.length,
                itemBuilder: (context, index) => ActivityList(
                    webQuest: foundActivity[index].webQuest,
                    imageURL: foundActivity[index].imageURL,
                    title: foundActivity[index].title,
                    currentStage: foundActivity[index].currentStage,
                    startDate: foundActivity[index].startDate,
                    endDate: foundActivity[index].endDate,
                    progress: foundActivity[index].progress))),
      ],
    );
  }
}
