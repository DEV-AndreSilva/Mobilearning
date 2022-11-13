import 'package:mobilearning/Models/userModel.dart';

class UserActivitResume 
{
  int? idUserActivity;
  int? idUser; 
  String? name;


  UserActivitResume(int idUser, int idUserActivity, String name)
  {
    this.idUser  = idUser;
    this.idUserActivity = idUserActivity;
    this.name = name;
  }

  static UserActivitResume fromJson(dynamic json)
  {
    return UserActivitResume(json['idUser'],  json['idUserActivity'],  json['name']);
  }

  static UserActivitResume fromJsonStudent(dynamic json)
  {
    if(json['user'] != null)
    {
      User user = User.fromJson(json['user']);
      return UserActivitResume( json['IdUser'],  0,  user.name, );
    }
    else
    {
      return UserActivitResume( json['idUser'],  0,  json['name'], );
    }
    
    
  }

      Map toJson() => {
        'idUserActivity': idUserActivity,
        'idUser': idUser,
        'name':name,
      };
}