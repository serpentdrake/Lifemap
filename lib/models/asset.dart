class Asset{
  int assetId, userId;
  double assetVal;
  String assetDesc;

  Asset(this.assetId, this.assetDesc, this.assetVal, this.userId);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'assetId': assetId,
      'assetDesc': assetDesc,
      'assetVal': assetVal,
      'userId': userId
    };
    return map;
  }

  Asset.fromMap (Map<String, dynamic> map) {
    assetId = map['assetId'];
    assetDesc = map['assetDesc'];
    assetVal = map['assetVal'];
    userId = map['userId'];
  }

}