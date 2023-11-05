class NotificationModel {
  NotificationModel({
    required this.to,
    required this.notification,
  });

  final String? to;
  final NotificationChild? notification;

  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
      to: json["to"],
      notification: json["notification"] == null ? null : NotificationChild.fromJson(json["notification"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "to": to,
      "notification": notification?.toJson(), // Gọi phương thức toJson của lớp Notification nếu notification không null
    };
  }

}

class NotificationChild {
  NotificationChild({
    required this.title,
    required this.body,
  });

  final String? title;
  final String? body;

  factory NotificationChild.fromJson(Map<String, dynamic> json){
    return NotificationChild(
      title: json["title"],
      body: json["body"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
    };
  }

}
