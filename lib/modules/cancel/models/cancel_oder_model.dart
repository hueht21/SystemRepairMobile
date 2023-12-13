class CancelOder {
  CancelOder({
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

  factory CancelOder.fromJson(Map<String, dynamic> json){
    return CancelOder(
      dateCancel: json["DateCancel"],
      idCustom: json["IDCustom"],
      idFixer: json["IDFixer"],
      idOder: json["IDOder"],
      reason: json["Reason"],
    );
  }
}
