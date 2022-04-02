class DataMessageModel {
  // Property data message model
  List<DataMessage>? dataMessage;

  // Constructor data model
  DataMessageModel({
    this.dataMessage,
  });

  // Named Constructor to convert json
  factory DataMessageModel.fromJson(Map<String, dynamic> json) {
    List list = json['data_message'];
    List<DataMessage> dataMessageList =
        list.map((e) => DataMessage.fromJson(e)).toList();
    return DataMessageModel(
      dataMessage: dataMessageList,
    );
  }
}

class DataMessage {
  // Property data message
  int? id;
  String? body;
  String? attachment;
  String? timestamp;
  String? from;
  String? to;

  // Constructor data message
  DataMessage({
    this.id,
    this.body,
    this.attachment,
    this.timestamp,
    this.from,
    this.to,
  });

  factory DataMessage.fromJson(Map<String, dynamic> json) => DataMessage(
        id: json["id"],
        body: json["body"],
        attachment: json["attachment"],
        timestamp: json["timestamp"],
        from: json["from"],
        to: json["to"],
      );
}
