import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:systemrepair/modules/pay_order/models/pay_oder_model.dart';
import 'package:systemrepair/shared/utils/date_utils.dart';

import '../../../base_utils/base_widget/base_show_notification.dart';
import '../../oders/models/registration_schedule_model.dart';
import '../views/sales_data_view.dart';
import 'home_view_controller.dart';

class HomeViewControllerImp extends HomeViewController {
  @override
  Future<void> onInit() async {
    showLoading();
    await getDataStatistical();
    await getDataPayOder().whenComplete(() => hideLoading());
    findData();
    super.onInit();
  }

  @override
  Future<void> getDataStatistical() async {

    final documentSnapshot = await FirebaseFirestore.instance
        .collection(
            'RegistrationSchedule') // Thay 'your_collection_name' bằng tên collection của bạn
        .get();
    if (documentSnapshot.docs.isNotEmpty) {
      for (final dataFixerModel in documentSnapshot.docs) {
        listDataSchedule
            .add(RegistrationScheduleModel.fromJson(dataFixerModel.data()));
      }
      for (var item in listDataSchedule) {
        if (item.status == 1) {
          numberWaiting++;
        } else if (item.status == 2) {
          numberConfirmedStatus++;
        } else if (item.status == 3) {
          numberFinish++;
        } else if (item.status == 4) {
          numberCanceledStatus++;
        }
      }
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu không rỗng",
        QuickAlertType.error,
      );
    }
  }

  void findData() {
    salesData = [
      SalesData('Hoàn thành', numberFinish.toDouble()),
      SalesData('Chờ sửa', numberWaiting.toDouble()),
      SalesData('Chờ duyệt', numberCanceledStatus.toDouble()),
      SalesData('Đã huỷ', numberCanceledStatus.toDouble()),
    ];

    for (int i = 0; i < listPayModel.length; i++) {
      int month =
          convertStringToDate(listPayModel[i].createDate ?? "", PATTERN_1)
              .month;
      if (mapAmount.containsKey(month)) {
        // int number1 = listPayModel[i].amount;
        // number1 = number1 + listPayModel[i].amount;
        mapAmount[month] = (mapAmount[month] ?? 0) + listPayModel[i].amount;
      } else {
        mapAmount.addAll({month: listPayModel[i].amount});
      }
    }

    List<int> listKey = mapAmount.keys.toList();
    for (var item in listKey) {
      charGetData.add(MonthMoney(item, (mapAmount[item]!.toDouble())));
    }
  }


  Future<void> getDataPayOder() async {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('PayOder')
        .get()
        .whenComplete(() => hideLoading());
    if (documentSnapshot.docs.isNotEmpty) {
      for (final payModel in documentSnapshot.docs) {
        PayOderModel payOderModel = PayOderModel.fromJson(payModel.data());
        if (convertStringToDate(payOderModel.createDate ?? "", PATTERN_1)
                .year ==
            DateTime.now().year) {
          listPayModel.add(PayOderModel.fromJson(payModel.data()));
        }
      }
    } else {
      BaseShowNotification.showNotification(
        Get.context!,
        "Dữ liệu thanh toán rỗng",
        QuickAlertType.error,
      );
    }
  }
}
