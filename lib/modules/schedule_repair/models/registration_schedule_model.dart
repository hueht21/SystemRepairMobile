import 'fixer_model.dart';

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

   String? address;
   String? customerName;
   String? dateSet;
   String? describe;
   String? email;
   String? id;
   String? imgFix;
   double? latitude;
   double? longitude;
   String? note;
   int? numberCancel;
   String? numberPhone;
   int? status;
   String? timeSet;
   String? uidClient;
   FixerModel? uidFixer;

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
      uidFixer: json["UIDFixer"] == null ? null : FixerModel.fromJson(json["UIDFixer"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Address": address,
      "CustomerName": customerName,
      "DateSet": dateSet,
      "Describe": describe,
      "Email": email,
      "ID": id,
      "ImgFix": imgFix,
      "Latitude": latitude,
      "Longitude": longitude,
      "Note": note,
      "NumberCancel": numberCancel,
      "NumberPhone": numberPhone,
      "Status": status,
      "TimeSet": timeSet,
      "UIDClient": uidClient,
      "UIDFixer": uidFixer?.toJson(), // Chuyển đối tượng UidFixer thành JSON
    };
  }
}

