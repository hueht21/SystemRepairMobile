class AccountModel {
  AccountModel({
    required this.auth,
    required this.latitude,
    required this.longitude,
    required this.nameAccout,
    required this.numberPhone,
    required this.uid,
    required this.email,
    required this.address
  });

  int? auth;
  double? latitude;
  double? longitude;
  String? nameAccout;
  String? numberPhone;
  String? uid;
  String email;
  String address;

  factory AccountModel.fromJson(Map<String, dynamic> json){
    return AccountModel(
      auth: json["Auth"],
      latitude: json["Latitude"],
      longitude: json["Longitude"],
      nameAccout: json["NameAccout"],
      numberPhone: json["NumberPhone"],
      uid: json["UID"],
      email: json["Email"],
      address: json["Address"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Auth": auth,
      "Latitude": latitude,
      "Longitude": longitude,
      "NameAccout": nameAccout,
      "NumberPhone": numberPhone,
      "UID": uid,
      "Email": email,
      "Address": address,
    };
  }


}
