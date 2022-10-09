// ignore_for_file: non_constant_identifier_names

class TimeModel {
  String? id;
  String? value;
    String? iddel;

  
 


  TimeModel({
    this.id,

    this.value,
    this.iddel

  
    
    });

  // receiving data from server
  factory TimeModel.fromMap(map) {
    return TimeModel(
      id: map['id'],

      value: map['value'],

            iddel: map['iddel'],



    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'value': value,

            'iddel': iddel,




    };
  }
}
