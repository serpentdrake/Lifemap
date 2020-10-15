class Employment{
  int empId, userId;

  Employment(this.empId, this.userId);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'empId': empId,
      'userId': userId
    };
    return map;
  }

  Employment.fromMap (Map<String, dynamic> map) {
    empId = map['empId'];
    userId = map['userId'];
  }


}