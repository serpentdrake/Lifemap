class User{
  int userId, age, retireAge;
  String fName, lName;
  double monthIn;
  bool isEmployed;


  User(this.userId, this.fName, this.lName, this.age, this.retireAge, this.monthIn, this.isEmployed);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'userId': userId,
      'fName': fName,
      'lName': lName,
      'age': age,
      'retireAge': retireAge,
      'monthIn': monthIn,
      'isEmployed': isEmployed
    };
    return map;
  }

  User.fromMap (Map<String, dynamic> map) {
    userId = map['userId'];
    fName = map['fName'];
    lName = map['lName'];
    age = map['age'];
    retireAge = map['retireAge'];
    monthIn = map['monthIn'];
    isEmployed = map['isEmployed'];
  }

}