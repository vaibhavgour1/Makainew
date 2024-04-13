import 'dart:convert';
ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));
String profileModelToJson(ProfileModel data) => json.encode(data.toJson());
class ProfileModel {
  ProfileModel({
      this.data,});

  ProfileModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProfileData.fromJson(v));
      });
    }
  }
  List<ProfileData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

ProfileData dataFromJson(String str) => ProfileData.fromJson(json.decode(str));
String dataToJson(ProfileData data) => json.encode(data.toJson());
class ProfileData {
  ProfileData({
      this.id, 
      this.patientMobileNo, 
      this.doctorMobileNo, 
      this.lastChat, 
      this.createdAt, 
      this.updatedAt, 
      this.symptoms,});

  ProfileData.fromJson(dynamic json) {
    id = json['id'];
    patientMobileNo = json['patientMobileNo'];
    doctorMobileNo = json['doctorMobileNo'];
    lastChat = json['lastChat'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['symptoms'] != null) {
      symptoms = [];
      json['symptoms'].forEach((v) {
        symptoms?.add(Symptoms.fromJson(v));
      });
    }
  }
  String? id;
  String? patientMobileNo;
  String? doctorMobileNo;
  dynamic lastChat;
  String? createdAt;
  String? updatedAt;
  List<Symptoms>? symptoms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['patientMobileNo'] = patientMobileNo;
    map['doctorMobileNo'] = doctorMobileNo;
    map['lastChat'] = lastChat;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    if (symptoms != null) {
      map['symptoms'] = symptoms?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Symptoms symptomsFromJson(String str) => Symptoms.fromJson(json.decode(str));
String symptomsToJson(Symptoms data) => json.encode(data.toJson());
class Symptoms {
  Symptoms({
      this.id, 
      this.name, 
      this.template, 
      this.slug, 
      this.createdAt, 
      this.updatedAt,});

  Symptoms.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    template = json['template'];
    slug = json['slug'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? name;
  String? template;
  String? slug;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['template'] = template;
    map['slug'] = slug;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}