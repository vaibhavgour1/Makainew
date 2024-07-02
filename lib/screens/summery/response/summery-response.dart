import 'dart:convert';

class EvaluationsResponse {
  List<EvaluationsData>? data;
  int? cursor;
  String ? text;

  EvaluationsResponse({
    this.data,
    this.cursor,
    this.text
  });

  factory EvaluationsResponse.fromRawJson(String str) => EvaluationsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EvaluationsResponse.fromJson(Map<String, dynamic> json) => EvaluationsResponse(
    data: json["data"] == null ? [] : List<EvaluationsData>.from(json["data"]!.map((x) => EvaluationsData.fromJson(x))),
    cursor: json["cursor"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "cursor": cursor,
  };
}

class EvaluationsData {
  int? llmEvaluationId;
  String? patientId;
  DateTime? date;
  String? evaluation;
  Patient? patient;
  int? id;

  EvaluationsData({
    this.llmEvaluationId,
    this.patientId,
    this.date,
    this.evaluation,
    this.patient,
    this.id,
  });

  factory EvaluationsData.fromRawJson(String str) => EvaluationsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EvaluationsData.fromJson(Map<String, dynamic> json) => EvaluationsData(
    llmEvaluationId: json["LLMEvaluationID"],
    patientId: json["PatientId"],
    date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
    evaluation: json["Evaluation"],
    patient: json["Patient"] == null ? null : Patient.fromJson(json["Patient"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "LLMEvaluationID": llmEvaluationId,
    "PatientId": patientId,
    "Date": date?.toIso8601String(),
    "Evaluation": evaluation,
    "Patient": patient?.toJson(),
    "id": id,
  };
}

class Patient {
  String? patientId;
  String? name;
  String? email;
  int? age;
  DateTime? dob;
  String? gender;

  Patient({
    this.patientId,
    this.name,
    this.email,
    this.age,
    this.dob,
    this.gender,
  });

  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    patientId: json["PatientId"],
    name: json["Name"],
    email: json["Email"],
    age: json["Age"],
    dob: json["DOB"] == null ? null : DateTime.parse(json["DOB"]),
    gender: json["Gender"],
  );

  Map<String, dynamic> toJson() => {
    "PatientId": patientId,
    "Name": name,
    "Email": email,
    "Age": age,
    "DOB": dob?.toIso8601String(),
    "Gender": gender,
  };
}
