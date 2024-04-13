class SignUpModel {
  SignUpModel({
    this.data,
    this.token,
  });

  SignUpModel.fromJson(dynamic json) {
    data = json['data'] != null ? SignUpData.fromJson(json['data']) : null;
    token = json['token'];
  }

  SignUpData? data;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['token'] = token;
    return map;
  }
}

class SignUpData {
  SignUpData({
    this.id,
    this.name,
    this.email,
    this.mobileNo,
    this.active,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  SignUpData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    active = json['active'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  String? id;
  String? name;
  String? email;
  String? mobileNo;
  bool? active;
  String? role;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['mobileNo'] = mobileNo;
    map['active'] = active;
    map['role'] = role;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
