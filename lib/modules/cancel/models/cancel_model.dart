import 'package:systemrepair/modules/login/models/fixer_account_model.dart';
import 'package:systemrepair/modules/oders/models/fixer_model.dart';
import 'package:systemrepair/modules/oders/models/registration_schedule_model.dart';

class CancelModel {

  CancelModel({
    required this.dateCancel,
    required this.registrationScheduleModel,
    required this.idOder,
    required this.reason,
    required this.idCustom,
    required this.idFixer
  });

  final String? dateCancel;
  final String? idCustom;
  final String? idFixer;
  final RegistrationScheduleModel registrationScheduleModel;
  final String? idOder;
  final String? reason;
}