import 'dart:convert';

class CognigyApiResponse {
  String? text;
  Data? data;
  List<OutputStack>? outputStack;
  String? userId;
  String? sessionId;

  CognigyApiResponse({
    this.text,
    this.data,
    this.outputStack,
    this.userId,
    this.sessionId,
  });

  factory CognigyApiResponse.fromRawJson(String str) => CognigyApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CognigyApiResponse.fromJson(Map<String, dynamic> json) => CognigyApiResponse(
    text: json["text"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    outputStack: json["outputStack"] == null ? [] : List<OutputStack>.from(json["outputStack"]!.map((x) => OutputStack.fromJson(x))),
    userId: json["userId"],
    sessionId: json["sessionId"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "data": data?.toJson(),
    "outputStack": outputStack == null ? [] : List<dynamic>.from(outputStack!.map((x) => x.toJson())),
    "userId": userId,
    "sessionId": sessionId,
  };
}

class Data {
  String? dataData;
  String? type;
  bool? linear;
  bool? loop;
  List<String>? text;
  Cognigy? cognigy;
  DataClass? data;

  Data({
    this.dataData,
    this.type,
    this.linear,
    this.loop,
    this.text,
    this.cognigy,
    this.data,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dataData: json["data"],
    type: json["type"],
    linear: json["linear"],
    loop: json["loop"],
    text: json["text"] == null ? [] : List<String>.from(json["text"]!.map((x) => x)),
    cognigy: json["_cognigy"] == null ? null : Cognigy.fromJson(json["_cognigy"]),
    data: json["_data"] == null ? null : DataClass.fromJson(json["_data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": dataData,
    "type": type,
    "linear": linear,
    "loop": loop,
    "text": text == null ? [] : List<dynamic>.from(text!.map((x) => x)),
    "_cognigy": cognigy?.toJson(),
    "_data": data?.toJson(),
  };
}

class Cognigy {
  Default? cognigyDefault;

  Cognigy({
    this.cognigyDefault,
  });

  factory Cognigy.fromRawJson(String str) => Cognigy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cognigy.fromJson(Map<String, dynamic> json) => Cognigy(
    cognigyDefault: json["_default"] == null ? null : Default.fromJson(json["_default"]),
  );

  Map<String, dynamic> toJson() => {
    "_default": cognigyDefault?.toJson(),
  };
}

class Default {
  QuickReplies? quickReplies;

  Default({
    this.quickReplies,
  });

  factory Default.fromRawJson(String str) => Default.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    quickReplies: json["_quickReplies"] == null ? null : QuickReplies.fromJson(json["_quickReplies"]),
  );

  Map<String, dynamic> toJson() => {
    "_quickReplies": quickReplies?.toJson(),
  };
}

class QuickReplies {
  String? type;
  List<QuickReply>? quickReplies;
  String? text;

  QuickReplies({
    this.type,
    this.quickReplies,
    this.text,
  });

  factory QuickReplies.fromRawJson(String str) => QuickReplies.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuickReplies.fromJson(Map<String, dynamic> json) => QuickReplies(
    type: json["type"],
    quickReplies: json["quickReplies"] == null ? [] : List<QuickReply>.from(json["quickReplies"]!.map((x) => QuickReply.fromJson(x))),
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "quickReplies": quickReplies == null ? [] : List<dynamic>.from(quickReplies!.map((x) => x.toJson())),
    "text": text,
  };
}

class QuickReply {
  double? id;
  String? title;
  String? imageAltText;
  String? imageUrl;
  ContentType? contentType;
  String? payload;

  QuickReply({
    this.id,
    this.title,
    this.imageAltText,
    this.imageUrl,
    this.contentType,
    this.payload,
  });

  factory QuickReply.fromRawJson(String str) => QuickReply.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuickReply.fromJson(Map<String, dynamic> json) => QuickReply(
    id: json["id"]?.toDouble(),
    title: json["title"],
    imageAltText: json["imageAltText"],
    imageUrl: json["imageUrl"],
    contentType: contentTypeValues.map[json["contentType"]]!,
    payload: json["payload"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "imageAltText": imageAltText,
    "imageUrl": imageUrl,
    "contentType": contentTypeValues.reverse[contentType],
    "payload": payload,
  };
}

enum ContentType {
  POSTBACK
}

final contentTypeValues = EnumValues({
  "postback": ContentType.POSTBACK
});

class DataClass {
  Cognigy? cognigy;

  DataClass({
    this.cognigy,
  });

  factory DataClass.fromRawJson(String str) => DataClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
    cognigy: json["_cognigy"] == null ? null : Cognigy.fromJson(json["_cognigy"]),
  );

  Map<String, dynamic> toJson() => {
    "_cognigy": cognigy?.toJson(),
  };
}

class OutputStack {
  String? text;
  Data? data;
  String? traceId;
  bool? disableSensitiveLogging;
  String? source;

  OutputStack({
    this.text,
    this.data,
    this.traceId,
    this.disableSensitiveLogging,
    this.source,
  });

  factory OutputStack.fromRawJson(String str) => OutputStack.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OutputStack.fromJson(Map<String, dynamic> json) => OutputStack(
    text: json["text"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    traceId: json["traceId"],
    disableSensitiveLogging: json["disableSensitiveLogging"],
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "data": data?.toJson(),
    "traceId": traceId,
    "disableSensitiveLogging": disableSensitiveLogging,
    "source": source,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
