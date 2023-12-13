class CancelOderModel {
  CancelOderModel({
    required this.dateCancel,
    required this.idCustom,
    required this.idFixer,
    required this.idOder,
    required this.reason,
  });

  final String? dateCancel;
  final dynamic idCustom;
  final String? idFixer;
  final String? idOder;
  final String? reason;

  factory CancelOderModel.fromJson(Map<String, dynamic> json){
    return CancelOderModel(
      dateCancel: json["DateCancel"],
      idCustom: json["IDCustom"],
      idFixer: json["IDFixer"],
      idOder: json["IDOder"],
      reason: json["Reason"],
    );
  }
}
