class Cash{
  int cashId, userId;
  double cashVal;
  String cashDesc;

  Cash(this.cashId, this.cashDesc, this.cashVal, this.userId);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'cashId': cashId,
      'cashDesc': cashDesc,
      'cashVal': cashVal,
      'userId': userId
    };
    return map;
  }

  Cash.fromMap (Map<String, dynamic> map) {
    cashId = map['cashId'];
    cashDesc = map['cashDesc'];
    cashVal = map['cashVal'];
    userId = map['userId'];
  }

}