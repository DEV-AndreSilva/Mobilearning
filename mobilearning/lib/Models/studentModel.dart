// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, avoid_function_literals_in_foreach_calls



class Student {
  int id;
  String nivel;
  int userId;
  String name;


  Student(
      {
      required this.id,
      required this.userId,
      required this.nivel,
      required this.name
      });

  factory Student.fromJson(dynamic json) {
     print(json['id']);
     print(json['user']);

    return Student(
      id: json['id'],
      nivel: json['nivel'],
      userId:json['userId'],
      name: json['name']
    );
  }

  Map toJson() => {
        'id': id,
        'userId': userId,
        'nivel':nivel,
        'name':name
      };
}
