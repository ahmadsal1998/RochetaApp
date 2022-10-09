class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? wrool;
  String? phone;
  String? address;
  String? about;
  String? imageurl;
  String? name;
  String? specialization;
  String? date;
  String? bold;









  UserModel({this.uid, this.email, this.firstName, this.secondName,this.wrool,this.phone,this.address,this.imageurl,this.about,this.name,this.specialization,this.date,this.bold});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      wrool: map['wrool'],
      phone: map['phone'],
      address: map['address'],
      about: map['about'],
      imageurl: map['imageurl'],
      name: map['name'],
      specialization: map['Specialization'],
            date: map['date'],
                        bold: map['bold'],









    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'wrool': wrool,
      'phone': phone,
      'address': address,
      'about': about,
      'imageurl':imageurl,
            'name':name,
                        'bold':bold,







    };
  }
}
