class Strength{
  int strId, userId;
  String strDesc;

  Strength(this.strId, this.strDesc, this.userId);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'strId': strId,
      'strDesc': strDesc,
      'userId': userId
    };
    return map;
  }

  Strength.fromMap (Map<String, dynamic> map) {
    strId = map['strId'];
    strDesc = map['strDesc'];
    userId = map['userId'];
  }

}