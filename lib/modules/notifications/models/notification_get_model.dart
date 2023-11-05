class NotificationGetModel {
  NotificationGetModel({
    required this.createDate,
    required this.uidReceiver,
    required this.uidSend,
    required this.content,
    required this.id,
    required this.title,
  });

  final String? createDate;
  final String? uidReceiver;
  final String? uidSend;
  final String? content;
  final String? id;
  final String? title;

  factory NotificationGetModel.fromJson(Map<String, dynamic> json){
    return NotificationGetModel(
      createDate: json["CreateDate"],
      uidReceiver: json["UID_Receiver"],
      uidSend: json["UID_Send"],
      content: json["content"],
      id: json["id"],
      title: json["title"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "CreateDate": createDate,
      "UID_Receiver": uidReceiver,
      "UID_Send": uidSend,
      "content": content,
      "id": id,
      "title": title,
    };
  }

}
