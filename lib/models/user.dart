class User{
  int id;
  int retireAge;
  String fName;
  String lName;
  String date;

  User(this.id, this.fName, this.lName, this.date, this.retireAge);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'id': id,
      'fName': fName,
      'lName': lName,
      'date': date,
      'retireAge': retireAge
    };
    return map;
  }

  User.fromMap (Map<String, dynamic> map) {
    id = map['id'];
    fName = map['fname'];
    lName = map['lName'];
    date = map['date'];
    retireAge = map['retireAge'];
  }

}