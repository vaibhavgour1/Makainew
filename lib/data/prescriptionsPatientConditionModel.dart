// To parse this JSON data, do
//
//     final prescriptionsPatientConditionModel = prescriptionsPatientConditionModelFromJson(jsonString);

import 'dart:convert';

PrescriptionsPatientConditionModel prescriptionsPatientConditionModelFromJson(String str) =>
    PrescriptionsPatientConditionModel.fromJson(json.decode(str));

String prescriptionsPatientConditionModelToJson(PrescriptionsPatientConditionModel data) => json.encode(data.toJson());

class PrescriptionsPatientConditionModel {
  Data? data;

  PrescriptionsPatientConditionModel({
    this.data,
  });

  factory PrescriptionsPatientConditionModel.fromJson(Map<String, dynamic> json) => PrescriptionsPatientConditionModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  String? patientMobileNo;
  String? doctorMobileNo;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic lastChat;
  List<Symptom>? symptoms;
  Doctor? patient;
  Doctor? doctor;
  List<Prescription>? prescriptions;

  Data({
    this.id,
    this.patientMobileNo,
    this.doctorMobileNo,
    this.createdAt,
    this.updatedAt,
    this.lastChat,
    this.symptoms,
    this.patient,
    this.doctor,
    this.prescriptions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        patientMobileNo: json["patientMobileNo"],
        doctorMobileNo: json["doctorMobileNo"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        lastChat: json["lastChat"],
        symptoms: json["symptoms"] == null ? [] : List<Symptom>.from(json["symptoms"]!.map((x) => Symptom.fromJson(x))),
        patient: json["patient"] == null ? null : Doctor.fromJson(json["patient"]),
        doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
        prescriptions: json["prescriptions"] == null
            ? []
            : List<Prescription>.from(json["prescriptions"]!.map((x) => Prescription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientMobileNo": patientMobileNo,
        "doctorMobileNo": doctorMobileNo,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "lastChat": lastChat,
        "symptoms": symptoms == null ? [] : List<dynamic>.from(symptoms!.map((x) => x.toJson())),
        "patient": patient?.toJson(),
        "doctor": doctor?.toJson(),
        "prescriptions": prescriptions == null ? [] : List<dynamic>.from(prescriptions!.map((x) => x.toJson())),
      };
}

class Doctor {
  String? id;
  String? name;
  String? email;
  String? mobileNo;
  bool? active;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  Patient? patient;

  Doctor({
    this.id,
    this.name,
    this.email,
    this.mobileNo,
    this.active,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.patient,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        active: json["active"],
        role: json["role"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobileNo": mobileNo,
        "active": active,
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "patient": patient?.toJson(),
      };
}

class Patient {
  String? id;
  int? age;
  String? gender;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;

  Patient({
    this.id,
    this.age,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        age: json["age"],
        gender: json["gender"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "age": age,
        "gender": gender,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
      };
}

class Prescription {
  String? id;
  String? doctorId;
  String? patientId;
  String? patientConditionId;
  String? assessmentId;
  String? prescriptionPdfUrl;
  dynamic advice;
  DateTime? createdAt;
  DateTime? updatedAt;

  Prescription({
    this.id,
    this.doctorId,
    this.patientId,
    this.patientConditionId,
    this.assessmentId,
    this.prescriptionPdfUrl,
    this.advice,
    this.createdAt,
    this.updatedAt,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
        id: json["id"],
        doctorId: json["doctorId"],
        patientId: json["patientId"],
        patientConditionId: json["patientConditionId"],
        assessmentId: json["assessmentId"],
        prescriptionPdfUrl: json["prescriptionPdfUrl"],
        advice: json["advice"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctorId": doctorId,
        "patientId": patientId,
        "patientConditionId": patientConditionId,
        "assessmentId": assessmentId,
        "prescriptionPdfUrl": prescriptionPdfUrl,
        "advice": advice,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Symptom {
  String? id;
  String? name;
  String? template;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  Symptom({
    this.id,
    this.name,
    this.template,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  factory Symptom.fromJson(Map<String, dynamic> json) => Symptom(
        id: json["id"],
        name: json["name"],
        template: json["template"],
        slug: json["slug"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "template": template,
        "slug": slug,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
