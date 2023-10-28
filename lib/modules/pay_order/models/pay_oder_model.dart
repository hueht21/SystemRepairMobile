class PayOderModel {
  PayOderModel({
    required this.amount,
    required this.createDate,
    required this.idOder,
    required this.uidCustomer,
    required this.uidFixer,
    required this.imgPay,
  });

  int? amount;
  String? createDate;
  String? idOder;
  String? uidCustomer;
  String? uidFixer;
  String? imgPay;

  factory PayOderModel.fromJson(Map<String, dynamic> json){
    return PayOderModel(
      amount: json["Amount"],
      createDate: json["CreateDate"],
      idOder: json["IDOder"],
      uidCustomer: json["UID_Customer"],
      uidFixer: json["UID_Fixer"],
      imgPay: json["ImgPay"],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Amount': amount,
      'CreateDate': createDate,
      'IDOder': idOder,
      'UID_Customer': uidCustomer,
      'UID_Fixer': uidFixer,
      'ImgPay': imgPay,
    };
  }

}
