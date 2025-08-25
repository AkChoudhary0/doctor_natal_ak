import 'dart:convert';

GetThemesModel getThemesModelFromJson(String str) =>
    GetThemesModel.fromJson(json.decode(str));
String getThemesModelToJson(GetThemesModel data) => json.encode(data.toJson());

class GetThemesModel {
  GetThemesModel({
    List<GetThemesDataModel>? data,
    bool? success,
    String? message,
    dynamic errors,
  }) {
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
  }

  GetThemesModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetThemesDataModel.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _errors = json['errors'];
  }
  List<GetThemesDataModel>? _data;
  bool? _success;
  String? _message;
  dynamic _errors;
  GetThemesModel copyWith({
    List<GetThemesDataModel>? data,
    bool? success,
    String? message,
    dynamic errors,
  }) =>
      GetThemesModel(
        data: data ?? _data,
        success: success ?? _success,
        message: message ?? _message,
        errors: errors ?? _errors,
      );
  List<GetThemesDataModel>? get data => _data;
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

GetThemesDataModel dataFromJson(String str) =>
    GetThemesDataModel.fromJson(json.decode(str));
String dataToJson(GetThemesDataModel data) => json.encode(data.toJson());

class GetThemesDataModel {
  GetThemesDataModel({
    num? id,
    String? name,
    String? color,
    String? displayName,
    String? value,
    String? themeCode,
    num? isEditable,
    num? isProtected,
    num? isSpecific,
    num? isMultilang,
    String? type,
    String? page,
    String? image,
    num? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _color = color;
    _displayName = displayName;
    _value = value;
    _themeCode = themeCode;
    _isEditable = isEditable;
    _isProtected = isProtected;
    _isSpecific = isSpecific;
    _isMultilang = isMultilang;
    _type = type;
    _page = page;
    _image = image;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GetThemesDataModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _color = json['color'];
    _displayName = json['display_name'];
    _value = json['value'];
    _themeCode = json['theme_code'];
    _isEditable = json['is_editable'];
    _isProtected = json['is_protected'];
    _isSpecific = json['is_specific'];
    _isMultilang = json['is_multilang'];
    _type = json['type'];
    _page = json['page'];
    _image = json['image'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _color;
  String? _displayName;
  String? _value;
  String? _themeCode;
  num? _isEditable;
  num? _isProtected;
  num? _isSpecific;
  num? _isMultilang;
  String? _type;
  String? _page;
  String? _image;
  num? _isActive;
  String? _createdAt;
  String? _updatedAt;
  GetThemesDataModel copyWith({
    num? id,
    String? name,
    String? color,
    String? displayName,
    String? value,
    String? themeCode,
    num? isEditable,
    num? isProtected,
    num? isSpecific,
    num? isMultilang,
    String? type,
    String? page,
    String? image,
    num? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      GetThemesDataModel(
        id: id ?? _id,
        name: name ?? _name,
        color: color ?? _color,
        displayName: displayName ?? _displayName,
        value: value ?? _value,
        themeCode: themeCode ?? _themeCode,
        isEditable: isEditable ?? _isEditable,
        isProtected: isProtected ?? _isProtected,
        isSpecific: isSpecific ?? _isSpecific,
        isMultilang: isMultilang ?? _isMultilang,
        type: type ?? _type,
        page: page ?? _page,
        image: image ?? _image,
        isActive: isActive ?? _isActive,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get name => _name;
  String? get color => _color;
  String? get displayName => _displayName;
  String? get value => _value;
  String? get themeCode => _themeCode;
  num? get isEditable => _isEditable;
  num? get isProtected => _isProtected;
  num? get isSpecific => _isSpecific;
  num? get isMultilang => _isMultilang;
  String? get type => _type;
  String? get page => _page;
  String? get image => _image;
  num? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['color'] = _color;
    map['display_name'] = _displayName;
    map['value'] = _value;
    map['theme_code'] = _themeCode;
    map['is_editable'] = _isEditable;
    map['is_protected'] = _isProtected;
    map['is_specific'] = _isSpecific;
    map['is_multilang'] = _isMultilang;
    map['type'] = _type;
    map['page'] = _page;
    map['image'] = _image;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
