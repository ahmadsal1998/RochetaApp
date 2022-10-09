

class BookingModel {
  String? uidd;
  String? uidp;
  String? dname;
  String? pname;
  String? time;
  String? id;
 
  BookingModel({this.uidd, this.uidp, this.dname, this.pname,this.time,this.id});

  // receiving data from server
  factory BookingModel.fromMap(map) {
    return BookingModel(
      uidd: map['uidd'],
      uidp: map['uidp'],
      dname: map['dname'],
      pname: map['pname'],
      time: map['time'],
      id: map['id'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uidd': uidd,
      'uidp': uidp,
      'dname': dname,
      'pname': pname,
      'time': time,
      'id': id,

    };
  }

  get(String s) {}
}
