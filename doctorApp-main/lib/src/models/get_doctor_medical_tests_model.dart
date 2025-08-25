import 'dart:convert';
GetDoctorMedicalTestsModel getDoctorMedicalTestsModelFromJson(String str) => GetDoctorMedicalTestsModel.fromJson(json.decode(str));
String getDoctorMedicalTestsModelToJson(GetDoctorMedicalTestsModel data) => json.encode(data.toJson());
class GetDoctorMedicalTestsModel {
  GetDoctorMedicalTestsModel({
      List<Data>? data, 
      bool? success, 
      String? message, 
      dynamic errors,}){
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
}

  GetDoctorMedicalTestsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _errors = json['errors'];
  }
  List<Data>? _data;
  bool? _success;
  String? _message;
  dynamic _errors;
GetDoctorMedicalTestsModel copyWith({  List<Data>? data,
  bool? success,
  String? message,
  dynamic errors,
}) => GetDoctorMedicalTestsModel(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  errors: errors ?? _errors,
);
  List<Data>? get data => _data;
  bool? get success => _success;
  String? get message => _message;
  dynamic get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    map['errors'] = _errors;
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? name, 
      String? description, 
      dynamic image, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _description = description;
    _image = image;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _description;
  dynamic _image;
  String? _updatedAt;
Data copyWith({  num? id,
  String? name,
  String? description,
  dynamic image,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  image: image ?? _image,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get description => _description;
  dynamic get image => _image;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['image'] = _image;
    map['updated_at'] = _updatedAt;
    return map;
  }

}