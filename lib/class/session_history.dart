class SessionHistory {
  int id;
  String startAt;
  String? endAt;
  bool isOngoing;
  String? jpegLocation;
  String? name;

  SessionHistory(
    this.id,
    this.startAt,
    this.endAt,
    this.isOngoing,
    // this.jpegLocation,
    this.name,
  );

  SessionHistory.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        startAt = json['start_at'] as String,
        endAt = json['end_at'] == null ? "" : json["end_at"] as String,
        isOngoing = json['is_ongoing'] as bool,
        // jpegLocation = json['jpeg_location'] == null
        //     ? ""
        //     : json["jpeg_location"] as String,
        name = json['name'] == null
            ? "Session #${json['id']}"
            : json["name"] as String;
}
