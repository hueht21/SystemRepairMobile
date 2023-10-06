class RegistrationScheduleModel {
  RegistrationScheduleModel({
    required this.address,
    required this.customerName,
    required this.email,
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.numberCancel,
    required this.numberPhone,
    required this.status,
    required this.describe,
    required this.note,
    required this.uidFixer,
  });

  final String? address;
  final String? customerName;
  final String? email;
  final String? id;
  final double? latitude;
  final double? longitude;
  final int? numberCancel;
  final String? numberPhone;
  final int? status;
  final String? describe;
  final String? note;
  final String? uidFixer;

  factory RegistrationScheduleModel.fromJson(Map<String, dynamic> json){
    return RegistrationScheduleModel(
      address: json["Address"],
      customerName: json["CustomerName"],
      email: json["Email"],
      id: json["ID"],
      latitude: json["Latitude"],
      longitude: json["Longitude"],
      numberCancel: json["NumberCance"],
      numberPhone: json["NumberPhone"],
      status: json["Status"],
      describe: json["Describe"],
      note: json["Note"],
      uidFixer: json["UIDFixer"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Address': address,
      'CustomerName': customerName,
      'Email': email,
      'ID': id,
      'Latitude': latitude,
      'Longitude': longitude,
      'NumberCance': numberCancel,
      'NumberPhone': numberPhone,
      'Status': status,
      'UIDFixer': uidFixer,
      'Describe' : describe,
      'Note' : note
    };
  }

}
