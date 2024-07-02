import 'dart:convert';

class AssessmentsResponse {
  List<AssessmentsData>? data;
  int? cursor;
String? text;
  AssessmentsResponse({
    this.data,
    this.cursor,
    this.text
  });

  factory AssessmentsResponse.fromRawJson(String str) => AssessmentsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssessmentsResponse.fromJson(Map<String, dynamic> json) => AssessmentsResponse(
    data: json["data"] == null ? [] : List<AssessmentsData>.from(json["data"]!.map((x) => AssessmentsData.fromJson(x))),
    cursor: json["cursor"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "cursor": cursor,
  };
}

class AssessmentsData {
  String? patientId;
  DateTime? date;
  String? bp;
  String? ankleGirth;
  String? breathlessnessScore;
  String? fever;
  String? weightChanges;
  String? urinaryFrequency;
  dynamic sPo2Levels;
  String? pulseReading;
  String? weaknessScale;
  Patient? patient;
  String? id;

  AssessmentsData({
    this.patientId,
    this.date,
    this.bp,
    this.ankleGirth,
    this.breathlessnessScore,
    this.fever,
    this.weightChanges,
    this.urinaryFrequency,
    this.sPo2Levels,
    this.pulseReading,
    this.weaknessScale,
    this.patient,
    this.id,
  });

  factory AssessmentsData.fromRawJson(String str) => AssessmentsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssessmentsData.fromJson(Map<String, dynamic> json) => AssessmentsData(
    patientId: json["PatientId"].toString(),
    date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
    bp: json["BP"].toString(),
    ankleGirth: json["AnkleGirth"].toString(),
    breathlessnessScore: json["BreathlessnessScore"].toString(),
    fever: json["Fever"].toString(),
    weightChanges: json["WeightChanges"].toString(),
    urinaryFrequency: json["UrinaryFrequency"].toString(),
    sPo2Levels: json["sPO2Levels"].toString(),
    pulseReading: json["PulseReading"].toString(),
    weaknessScale: json["WeaknessScale"].toString(),
    patient: json["Patient"] == null ? null : Patient.fromJson(json["Patient"]),
    id: json["id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "PatientId": patientId,
    "Date": date?.toIso8601String(),
    "BP": bp,
    "AnkleGirth": ankleGirth,
    "BreathlessnessScore": breathlessnessScore,
    "Fever": fever,
    "WeightChanges": weightChanges,
    "UrinaryFrequency": urinaryFrequency,
    "sPO2Levels": sPo2Levels,
    "PulseReading": pulseReading,
    "WeaknessScale": weaknessScale,
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
