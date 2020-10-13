class Time{
  int timeId, prodHour, prodYear, userId;

  Time(this.timeId, this.prodHour, this.prodYear);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'timeId':  timeId,
      'prodHour':  prodHour,
      'prodYear': prodYear,
      // 'userId': userId
    };
    return map;
  }

  Time.fromMap (Map<String, dynamic> map) {
    timeId = map['timeId'];
    prodHour = map['prodHour'];
    prodYear = map['prodYear'];
    // userId = map['userId'];
  }

}