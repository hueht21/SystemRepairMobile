import 'package:systemrepair/modules/login/models/fixer_account_model.dart';
import 'package:systemrepair/modules/oders/models/fixer_model.dart';

class CancelModel {

  CancelModel({
    required this.dateCancel,
    required this.fixerAccountModel,
    required this.idOder,
    required this.reason,
  });

  final String? dateCancel;
  final FixerModel fixerAccountModel;
  final String? idOder;
  final String? reason;
}