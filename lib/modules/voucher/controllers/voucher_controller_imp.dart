import 'package:systemrepair/modules/voucher/controllers/voucher_controller.dart';

class VoucherControllerImp extends VoucherController {
  @override
  void setIndex(int index) {
    // TODO: implement setIndex
    checkIndex.value = index;
  }

}