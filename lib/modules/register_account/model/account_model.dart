class AccountModel {
  AccountModel({
    required this.auth,
    required this.latitude,
    required this.longitude,
    required this.nameAccout,
    required this.numberPhone,
    required this.uid,
  });

  int? auth;
  double? latitude;
  double? longitude;
  String? nameAccout;
  String? numberPhone;
  String? uid;

  factory AccountModel.fromJson(Map<String, dynamic> json){
    return AccountModel(
      auth: json["Auth"],
      latitude: json["Latitude"],
      longitude: json["Longitude"],
      nameAccout: json["NameAccout"],
      numberPhone: json["NumberPhone"],
      uid: json["UID"],
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
    };
  }


}
