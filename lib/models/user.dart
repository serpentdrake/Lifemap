import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int id, age, retireAge;
  double monthIn;
  bool isEmployed;
  String fName, lName;

  User({this.id, this.fName, this.lName, this.age, this.retireAge, this.monthIn});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fName: json["fName"],
        lName: json["lName"],
        age: json["age"],
        retireAge: json["retireAge"],
        monthIn: json["monthIn"],
        // isEmployed: json["isEmployed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fName": fName,
        "lName": lName,
        "age": age,
        "retireAge": retireAge,
        "monthIn": monthIn,
        // "isEmployed": isEmployed,
      };
}
