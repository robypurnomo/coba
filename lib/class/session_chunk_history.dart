class SessionChunk {
  int id;
  String startAt;
  String endAt;
  int count;
  String videoUrl;
  // String? analysis;
  String? positionType = "Push up";

  SessionChunk(this.id, this.startAt, this.endAt, this.count, this.videoUrl,
      this.positionType);

  SessionChunk.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        startAt = json['start_at'] as String,
        endAt = json['end_at'] as String,
        count = json['count'] as int,
        videoUrl = json['video_location'] as String,
        // analysis = json['analysis'] == null ? "" : json["analysis"] as String,
        positionType = json['position_type'] == null
            ? "Push Up"
            : json["position_type"] as String;
}
