import '../../../cores/enum/enum_status.dart';
import 'order_controler.dart';

class OrderControllerImp extends OrderController {
  @override
  void setIndexOption(int index) {
    // TODO: implement setIndexOption

  }

  @override
  String getStatus(int index) {
    // TODO: implement getStatus
    switch(index) {
      case 0:
        return EnumStatusOder.waitingStatus;
      case 1:
        return EnumStatusOder.confirmedStatus;
      case 2:
        return EnumStatusOder.completeStatus;
      case 3:
        return EnumStatusOder.canceledStatus;
    }
    return "";

  }
}