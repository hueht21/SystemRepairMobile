class NotificationResponseModel {
  NotificationResponseModel({
    required this.multicastId,
    required this.success,
    required this.failure,
    required this.canonicalIds,
    required this.results,
  });

  final int? multicastId;
  final int? success;
  final int? failure;
  final int? canonicalIds;
  final List<Result> results;

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json){
    return NotificationResponseModel(
      multicastId: json["multicast_id"],
      success: json["success"],
      failure: json["failure"],
      canonicalIds: json["canonical_ids"],
      results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );
  }

}

class Result {
  Result({
    required this.messageId,
  });

  final String? messageId;

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      messageId: json["message_id"],
    );
  }

}
