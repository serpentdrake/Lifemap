class Strength{
  int strId, userId;
  String str1, str2, str3, str4, str5;

  Strength(this.strId, this.str1, this.str2, this.str3, this.str4, this.str5, this.userId);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'strId': strId,
      'str1': str1,
      'str2': str2,
      'str3': str3,
      'str4': str4,
      'str5': str5,
      'userId': userId
    };
    return map;
  }

  Strength.fromMap (Map<String, dynamic> map) {
    strId = map['strId'];
    str1 = map['str1'];
    str2 = map['str2'];
    str3 = map['str3'];
    str4 = map['str4'];
    str5 = map['str5'];
    userId = map['userId'];
  }

}