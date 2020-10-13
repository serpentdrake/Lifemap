class Weakness{
  int weakId, userId;
  String weakDesc;

  Weakness(this.weakId, this.weakDesc, this.userId);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'weakId': weakId,
      'weakDesc': weakDesc,
      'userId': userId
    };
    return map;
  }

  Weakness.fromMap (Map<String, dynamic> map) {
    weakId = map['weakId'];
    weakDesc = map['weakDesc'];
    userId = map['userId'];
  }

}