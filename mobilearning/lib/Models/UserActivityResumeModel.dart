import 'package:mobilearning/Models/userModel.dart';

class UserActivitResume 
{
  int? idUserActivity;
  int? idUser; 
  String? name;
  User? user;

  UserActivitResume(int idUser, int idUserActivity, String name, User? user)
  {
    this.idUser  = idUser;
    this.idUserActivity = idUserActivity;
    this.name = name;
    this.user = user;
  }

  static UserActivitResume fromJson(dynamic json)
  {
    return UserActivitResume(json['idUser'],  json['idUserActivity'],  json['name'], null);
  }

  static UserActivitResume fromJsonStudent(dynamic json)
  {
    User user = User.fromJson(json['user']);
    return UserActivitResume( json['IdUser'],  0,  user.name, user );
  }
}