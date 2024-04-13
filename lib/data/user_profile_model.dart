import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    this.data,
  });

  Data? data;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.mobileNo,
    this.active,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  String? id;
  String? name;
  String? email;
  String? mobileNo;
  bool? active;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  Profile? profile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobileNo: json["mobileNo"],
        active: json["active"],
        role: json["role"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        profile: json["profile"] == null
            ? json["patient"] == null
                ? null
                : Profile.fromJson(json["patient"])
            : Profile.fromJson(json["profile"]),
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
        "profile": profile?.toJson(),
      };
}

class Profile {
  Profile({
    this.id,
    this.degrees,
    this.hospitalName,
    this.address,
    this.age,
    this.gender,
    this.qrUrl,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  String? id;
  String? degrees;
  String? hospitalName;
  String? address;
  String? qrUrl;
  String? age;
  String? gender;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        degrees: json["degrees"],
        hospitalName: json["hospitalName"],
        address: json["address"],
        qrUrl: json["qrUrl"],
        age: json["age"].toString(),
        gender: json["gender"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "degrees": degrees,
        "hospitalName": hospitalName,
        "address": address,
        "qrUrl": qrUrl,
        "age": age,
        "gender": gender,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
      };
}
