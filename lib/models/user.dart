class User{
  int userId, age, retireAge;
  String fName, lName, birthDate;


  User(this.userId, this.fName, this.lName, this.birthDate, this.age, this.retireAge);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'userId': userId,
      'fName': fName,
      'lName': lName,
      'birthDate': birthDate,
      'age': age,
      'retireAge': retireAge
    };
    return map;
  }

  User.fromMap (Map<String, dynamic> map) {
    userId = map['userId'];
    fName = map['fName'];
    lName = map['lName'];
    birthDate = map['birthDate'];
    age = map['age'];
    retireAge = map['retireAge'];
  }

}