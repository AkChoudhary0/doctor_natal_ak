import 'dart:convert';

GetDoctorDiseasesModel getDoctorDiseasesModelFromJson(String str) =>
    GetDoctorDiseasesModel.fromJson(json.decode(str));
String getDoctorDiseasesModelToJson(GetDoctorDiseasesModel data) =>
    json.encode(data.toJson());

class GetDoctorDiseasesModel {
  GetDoctorDiseasesModel({
    List<Data>? data,
    bool? success,
    String? message,
    dynamic errors,
  }) {
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
  }

  GetDoctorDiseasesModel.fromJson(dynamic json) {
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
  GetDoctorDiseasesModel copyWith({
    List<Data>? data,
    bool? success,
    String? message,
    dynamic errors,
  }) =>
      GetDoctorDiseasesModel(
        data: data ?? _data,
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
    NameTranslations? nameTranslations,
    DescriptionTranslations? descriptionTranslations,
    String? description,
    String? image,
    String? updatedAt,
    String? appointmentDate,
    String? appointmentDoctorImage,
    String? appointmentDoctorName,
    String? appointmentId,
    String? appointmentDoctorSpeciality,
  }) {
    _id = id;
    _name = name;
    _nameTranslations = nameTranslations;
    _descriptionTranslations = descriptionTranslations;
    _description = description;
    _image = image;
    _updatedAt = updatedAt;
    _appointmentDate = appointmentDate;
    _appointmentDoctorImage = appointmentDoctorImage;
    _appointmentDoctorName = appointmentDoctorName;
    _appointmentId = appointmentId;
    _appointmentDoctorSpeciality = appointmentDoctorSpeciality;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nameTranslations = json['name_translations'] != null
        ? NameTranslations.fromJson(json['name_translations'])
        : null;
    _descriptionTranslations = json['description_translations'] != null
        ? DescriptionTranslations.fromJson(json['description_translations'])
        : null;
    _description = json['description'];
    _image = json['image'];
    _updatedAt = json['updated_at'];
    _appointmentDate = json['appointment_date'];
    _appointmentDoctorImage = json['appointment_doctor_image'];
    _appointmentDoctorName = json['appointment_doctor_name'];
    _appointmentId = json['appointment_id'];
    _appointmentDoctorSpeciality = json['appointment_doctor_speciality'];
  }
  num? _id;
  String? _name;
  NameTranslations? _nameTranslations;
  DescriptionTranslations? _descriptionTranslations;
  String? _description;
  String? _image;
  String? _updatedAt;
  String? _appointmentDate;
  String? _appointmentDoctorImage;
  String? _appointmentDoctorName;
  String? _appointmentId;
  String? _appointmentDoctorSpeciality;
  Data copyWith({
    num? id,
    String? name,
    NameTranslations? nameTranslations,
    DescriptionTranslations? descriptionTranslations,
    String? description,
    String? image,
    String? updatedAt,
    String? appointmentDate,
    String? appointmentDoctorImage,
    String? appointmentDoctorName,
    String? appointmentId,
    String? appointmentDoctorSpeciality,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        nameTranslations: nameTranslations ?? _nameTranslations,
        descriptionTranslations:
            descriptionTranslations ?? _descriptionTranslations,
        description: description ?? _description,
        image: image ?? _image,
        updatedAt: updatedAt ?? _updatedAt,
        appointmentDate: appointmentDate ?? _appointmentDate,
        appointmentDoctorImage:
            appointmentDoctorImage ?? _appointmentDoctorImage,
        appointmentDoctorName: appointmentDoctorName ?? _appointmentDoctorName,
        appointmentId: appointmentId ?? _appointmentId,
        appointmentDoctorSpeciality:
            appointmentDoctorSpeciality ?? _appointmentDoctorSpeciality,
      );
  num? get id => _id;
  String? get name => _name;
  NameTranslations? get nameTranslations => _nameTranslations;
  DescriptionTranslations? get descriptionTranslations =>
      _descriptionTranslations;
  String? get description => _description;
  String? get image => _image;
  String? get updatedAt => _updatedAt;
  String? get appointmentDate => _appointmentDate;
  String? get appointmentDoctorImage => _appointmentDoctorImage;
  String? get appointmentDoctorName => _appointmentDoctorName;
  String? get appointmentId => _appointmentId;
  String? get appointmentDoctorSpeciality => _appointmentDoctorSpeciality;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_nameTranslations != null) {
      map['name_translations'] = _nameTranslations?.toJson();
    }
    if (_descriptionTranslations != null) {
      map['description_translations'] = _descriptionTranslations?.toJson();
    }
    map['description'] = _description;
    map['image'] = _image;
    map['updated_at'] = _updatedAt;
    map['appointment_date'] = _appointmentDate;
    map['appointment_doctor_image'] = _appointmentDoctorImage;
    map['appointment_doctor_name'] = _appointmentDoctorName;
    map['appointment_id'] = _appointmentId;
    map['appointment_doctor_speciality'] = _appointmentDoctorSpeciality;
    return map;
  }
}

DescriptionTranslations descriptionTranslationsFromJson(String str) =>
    DescriptionTranslations.fromJson(json.decode(str));
String descriptionTranslationsToJson(DescriptionTranslations data) =>
    json.encode(data.toJson());

class DescriptionTranslations {
  DescriptionTranslations({
    String? en,
    String? hi,
    String? ar,
  }) {
    _en = en;
    _hi = hi;
    _ar = ar;
  }

  DescriptionTranslations.fromJson(dynamic json) {
    _en = json['en'];
    _hi = json['hi'];
    _ar = json['ar'];
  }
  String? _en;
  String? _hi;
  String? _ar;
  DescriptionTranslations copyWith({
    String? en,
    String? hi,
    String? ar,
  }) =>
      DescriptionTranslations(
        en: en ?? _en,
        hi: hi ?? _hi,
        ar: ar ?? _ar,
      );
  String? get en => _en;
  String? get hi => _hi;
  String? get ar => _ar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['en'] = _en;
    map['hi'] = _hi;
    map['ar'] = _ar;
    return map;
  }
}

NameTranslations nameTranslationsFromJson(String str) =>
    NameTranslations.fromJson(json.decode(str));
String nameTranslationsToJson(NameTranslations data) =>
    json.encode(data.toJson());

class NameTranslations {
  NameTranslations({
    String? en,
    String? hi,
    String? ar,
  }) {
    _en = en;
    _hi = hi;
    _ar = ar;
  }

  NameTranslations.fromJson(dynamic json) {
    _en = json['en'];
    _hi = json['hi'];
    _ar = json['ar'];
  }
  String? _en;
  String? _hi;
  String? _ar;
  NameTranslations copyWith({
    String? en,
    String? hi,
    String? ar,
  }) =>
      NameTranslations(
        en: en ?? _en,
        hi: hi ?? _hi,
        ar: ar ?? _ar,
      );
  String? get en => _en;
  String? get hi => _hi;
  String? get ar => _ar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['en'] = _en;
    map['hi'] = _hi;
    map['ar'] = _ar;
    return map;
  }
}
