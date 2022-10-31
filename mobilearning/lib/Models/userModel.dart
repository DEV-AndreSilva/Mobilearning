// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, avoid_function_literals_in_foreach_calls

class User{
  int  Id;
  String Name;
  String Email;


  User(
    { required this.Id,
      required this.Name,
      required this.Email
    });

   factory User.fromJson( dynamic json) {

    // print(json['Id']);
    // print(json['Email']);
    // print(json['Name']);

    return User(
      Id:  json['Id'],
      Email: json['Email'].toString(),
      Name: json['Name'].toString(),
    );
  }

    Map toJson() => {
        'Id': Id,
        'Email': Email,
        'Name':Name,
      };
}
