import 'dart:convert';

List<r> userFromJson(String str) =>
    List<r>.from(json.decode(str).map((x) => r.fromJson(x)));

String userToJson(List<> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class r {
  int id, treasureId;
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
