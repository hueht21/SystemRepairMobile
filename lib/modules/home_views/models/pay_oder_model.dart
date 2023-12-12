class PayOderModel {
  PayOderModel({
    required this.amount,
    required this.createDate,
    required this.idOder,
    required this.imgPay,
    required this.uidCustomer,
    required this.uidFixer,
  });

  final int? amount;
  final String? createDate;
  final String? idOder;
  final String? imgPay;
  final String? uidCustomer;
  final String? uidFixer;

  factory PayOderModel.fromJson(Map<String, dynamic> json){
    return PayOderModel(
      amount: json["Amount"],
      createDate: json["CreateDate"],
      idOder: json["IDOder"],
      imgPay: json["ImgPay"],
      uidCustomer: json["UID_Customer"],
      uidFixer: json["UID_Fixer"],
    );
  }

}
