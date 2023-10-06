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
  });

  final int? age;
  final String? email;
  final double? latitude;
  final double? longitude;
  final String? name;
  final String? numberPhone;
  final bool? status;
  final String? uid;

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
    );
  }

}
