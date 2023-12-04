class AppStr {
  static const String emptyList = "Danh sách rỗng";
  static const String appName = "Repairer";
  static const String done = "Xong";

  static String getNotificationnCancel(
    String timeSet,
    String dateSet,
    String address,
    String cancelOder,
    String nameFixer,
  ) =>
      'Đơn đặt ngày $dateSet: $timeSet tại đại chỉ $address đã bị đổi cho thợ vì lý do $cancelOder';

  static String getNotificationnConfirm(
    String timeSet,
    String dateSet,
    String address,
    String nameFixer,
  ) =>
      'Đơn đặt ngày $dateSet: $timeSet tại đại chỉ $address đã được thợ $nameFixer xác nhận';
}
