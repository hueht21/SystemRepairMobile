import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:systemrepair/modules/cancel/controllers/cancel_controller.dart';
import 'package:systemrepair/modules/cancel/models/cancel_model.dart';
import 'package:systemrepair/modules/oders/models/registration_schedule_model.dart';

import '../models/cancel_oder_model.dart';

class CancelOderImp extends CancelController {
  @override
  Future<void> onInit() async {
    showLoading();
    await getRegistrationScheduleModel();
    await getDataCancelOder().whenComplete(() => hideLoading());
    super.onInit();
  }

  Future<void> getDataCancelOder() async {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('CancelOder').get();
    if (documentSnapshot.docs.isNotEmpty) {
      listCancelOder.addAll(documentSnapshot.docs
          .map((cancelOrder) => CancelOderModel.fromJson(cancelOrder.data())));
    }
    for (var item in listCancelOder) {
      RegistrationScheduleModel registrationScheduleModel = listRegistrationSchedule
              .firstWhere((element) => element.id == item.idOder);
      CancelModel cancelModel = CancelModel(
        idCustom: item.idCustom,
        idFixer: item.idFixer ?? "",
        dateCancel: item.dateCancel,
        registrationScheduleModel: registrationScheduleModel,
        idOder: item.idOder,
        reason: item.reason,
      );
      listCancelModel.add(cancelModel);
    }
  }

  Future<void> getRegistrationScheduleModel() async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('RegistrationSchedule')
        .get();
    if (documentSnapshot.docs.isNotEmpty) {
      listRegistrationSchedule.addAll(documentSnapshot.docs.map((cancelOrder) =>
          RegistrationScheduleModel.fromJson(cancelOrder.data())));
    }
  }

  @override
  Future<void> onLoadMore() {
    // TODO: implement onLoadMore
    throw UnimplementedError();
  }

  @override
  Future<void> onRefresh() {
    // TODO: implement onRefresh
    throw UnimplementedError();
  }
}
