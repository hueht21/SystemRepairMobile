class FixerModel {
  FixerModel({
    required this.age,
    required this.email,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.numberPhone,
    required this.status,
    required this.uid,
    required this.address,
    required this.imgAcc
  });

  int? age;
  String? email;
  double? latitude;
  double? longitude;
  String? name;
  String? numberPhone;
  bool? status;
  String? uid;
  String address;
  String imgAcc;

  factory FixerModel.fromJson(Map<String, dynamic> json){
    return FixerModel(
      age: json["Age"],
      email: json["Email"],
      latitude: json["Latitude"],
      longitude: json["Longitude"],
      name: json["Name"],
      numberPhone: json["NumberPhone"],
      status: json["Status"],
      uid: json["UID"],
      address: json["Address"],
      imgAcc: json["ImgAcc"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Age": age,
      "Email": email,
      "Latitude": latitude,
      "Longitude": longitude,
      "Name": name,
      "NumberPhone": numberPhone,
      "Status": status,
      "UID": uid,
      "Address": address,
      "ImgAcc": imgAcc,
    };
  }

}
