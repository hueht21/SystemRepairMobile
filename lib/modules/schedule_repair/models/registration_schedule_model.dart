class RegistrationScheduleModel {
  RegistrationScheduleModel({
    required this.address,
    required this.customerName,
    required this.dateSet,
    required this.describe,
    required this.email,
    required this.id,
    required this.imgFix,
    required this.latitude,
    required this.longitude,
    required this.note,
    required this.numberCancel,
    required this.numberPhone,
    required this.status,
    required this.timeSet,
    required this.uidClient,
    required this.uidFixer,
  });

  final String? address;
  final String? customerName;
  final String? dateSet;
  final String? describe;
  final String? email;
  final String? id;
  final String? imgFix;
  final double? latitude;
  final double? longitude;
  final String? note;
  final int? numberCancel;
  final String? numberPhone;
  final int? status;
  final String? timeSet;
  final String? uidClient;
  final String? uidFixer;

  factory RegistrationScheduleModel.fromJson(Map<String, dynamic> json){
    return RegistrationScheduleModel(
      address: json["Address"],
      customerName: json["CustomerName"],
      dateSet: json["DateSet"],
      describe: json["Describe"],
      email: json["Email"],
      id: json["ID"],
      imgFix: json["ImgFix"],
      latitude: json["Latitude"],
      longitude: json["Longitude"],
      note: json["Note"],
      numberCancel: json["NumberCancel"],
      numberPhone: json["NumberPhone"],
      status: json["Status"],
      timeSet: json["TimeSet"],
      uidClient: json["UIDClient"],
      uidFixer: json["UIDFixer"],
    );
  }

}
