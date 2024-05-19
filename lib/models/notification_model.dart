class NotificationModel {
  String? notificationId;
  String? date;
  String? time;
  String? title;
  String? body;

  NotificationModel({
    required this.notificationId,
    required this.date,
    required this.time,
    required this.title,
    required this.body,
  });

  NotificationModel.fromJson({required Map<String, dynamic> json}) {
    notificationId = json['notificationId'];
    date = json['date'];
    time = json['time'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    return {
      "notificationId": notificationId,
      "date": date,
      "time": time,
      "title": title,
      "body": body,
    };
  }
}
