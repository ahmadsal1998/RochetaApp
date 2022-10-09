// ignore_for_file: non_constant_identifier_names

class BookingtModel {
  String? uidd;
  String? uidp;
  String? dname;
  String? pname;
  String? time;
  String? id;
  String? Diagnosis;
  String? Medicine;
  String? Notes;
  String? X_ray_name;
  double? price;

  BookingtModel(
      {this.uidd,
      this.uidp,
      this.dname,
      this.pname,
      this.time,
      this.id,
      this.Diagnosis,
      this.Medicine,
      this.Notes,
      this.X_ray_name,
      this.price});

  // receiving data from server
  factory BookingtModel.fromMap(map) {
    return BookingtModel(
      uidd: map['uidd'],
      uidp: map['uidp'],
      dname: map['dname'],
      pname: map['pname'],
      time: map['time'],
      id: map['id'],
      Diagnosis: map['Diagnosis'],
      Medicine: map['Medicine'],
      Notes: map['Notes'],
      X_ray_name: map['X-ray_name'],
      price: map['price'],
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
      'Diagnosis': Diagnosis,
      'Medicine': Medicine,
      'Notes': Notes,
      'X-ray_name': X_ray_name,
      'price': price,
    };
  }

  get(String s) {}
}
