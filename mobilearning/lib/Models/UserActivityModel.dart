
import 'package:mobilearning/Models/activityModel.dart';
import 'package:mobilearning/Models/userModel.dart';

class UserActivity
{
  int id;
  int idUser;
  int idActivity;
  String currentStage;
  String startDate;
  String endDate;
  double progress;
  Activity activity;
  User user;
 
  UserActivity({ 
    required this.id,
    required this.idUser,
    required this.idActivity,
    required this.currentStage,
    required this.startDate,
    required this.endDate,
    required this.progress,
    required this.activity,
    required this.user,

  });

   factory UserActivity.fromJson( dynamic json) {
    //  print(json['id']);
    //  print(json['idUser']);
    //  print(json['idActivity']);
    //  print(json['currentStage']);
    //  print(json['progress']);
    //  print(json['startDate']);
    //  print(json['endDate']);
    //  print(json['activity']);
    //  print(json['user']);

    return UserActivity(
      id:  json['id'],
      idUser: json['idUser'],
      idActivity: json["idActivity"],
      currentStage: json['currentStage'].toString(),
      startDate: json['startDate'].toString(),
      endDate: json['endDate'].toString(),
      progress: double.parse(json['progress'].toString()),
      activity: Activity.fromJson(json['activity']),
      user: User.fromJson(json['user'])

    );
  }

    Map toJson() => {
        'id': id,
        'idUser': idUser,
        'idActivity': idActivity,
        'currentStage':currentStage,
        'startDate':startDate,
        'endDate':endDate,
        'progress':progress,
        'activity': activity,
        'user':user
      };

}
