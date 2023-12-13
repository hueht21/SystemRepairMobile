import 'package:systemrepair/modules/login/models/account_model.dart';

class CancelOderListModel {
  CancelOderListModel({
    required this.dateCancel,
    required this.accountModel,
    required this.idOder,
    required this.reason,
  });

  final String? dateCancel;
  final AccountModel? accountModel;
  final String? idOder;
  final String? reason;

}
