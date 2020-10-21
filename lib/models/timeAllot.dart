class WeekSched {

  int id;
  double work;
  double advoc;
  double rest;

  WeekSched ({this.id,this.work,this.advoc,this.rest});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'work': work,
      'advoc' : advoc,
      'rest' : rest,
    };
  }

}