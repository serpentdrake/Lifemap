class Strength{
  int strId, userId;
  String coreStr, strDesc;

  Strength(this.strId,  this.strDesc, this.userId);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'strId': strId,
      // 'coreStr': coreStr,
      'strDesc': strDesc,
      'userId': userId
    };
    return map;
  }

  Strength.fromMap (Map<String, dynamic> map) {
    strId = map['strId'];
    // coreStr = map['coreStr'];
    strDesc = map['strDesc'];
    userId = map['userId'];
  }

}