import 'dart:convert';

GetDoctorAppointmentHistoryModel getDoctorAppointmentHistoryModelFromJson(
        String str) =>
    GetDoctorAppointmentHistoryModel.fromJson(json.decode(str));
String getDoctorAppointmentHistoryModelToJson(
        GetDoctorAppointmentHistoryModel data) =>
    json.encode(data.toJson());

class GetDoctorAppointmentHistoryModel {
  GetDoctorAppointmentHistoryModel({
    GetDoctorAppointmentHistoryDataModel? data,
    bool? success,
    String? message,
    dynamic errors,
  }) {
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
  }

  GetDoctorAppointmentHistoryModel.fromJson(dynamic json) {
    _data = json['data'] != null
        ? GetDoctorAppointmentHistoryDataModel.fromJson(json['data'])
        : null;
    _success = json['success'];
    _message = json['message'];
    _errors = json['errors'];
  }
  GetDoctorAppointmentHistoryDataModel? _data;
  bool? _success;
  String? _message;
  dynamic _errors;
  GetDoctorAppointmentHistoryModel copyWith({
    GetDoctorAppointmentHistoryDataModel? data,
    bool? success,
    String? message,
    dynamic errors,
  }) =>
      GetDoctorAppointmentHistoryModel(
        data: data ?? _data,
        success: success ?? _success,
        message: message ?? _message,
        errors: errors ?? _errors,
      );
  GetDoctorAppointmentHistoryDataModel? get data => _data;
  bool? get success => _success;
  String? get message => _message;
  dynamic get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    map['errors'] = _errors;
    return map;
  }
}

GetDoctorAppointmentHistoryDataModel dataFromJson(String str) =>
    GetDoctorAppointmentHistoryDataModel.fromJson(json.decode(str));
String dataToJson(GetDoctorAppointmentHistoryDataModel data) =>
    json.encode(data.toJson());

class GetDoctorAppointmentHistoryDataModel {
  GetDoctorAppointmentHistoryDataModel({
    List<DoctorAppointmentHistoryModel>? data,
    Links? links,
    Meta? meta,
  }) {
    _data = data;
    _links = links;
    _meta = meta;
  }

  GetDoctorAppointmentHistoryDataModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DoctorAppointmentHistoryModel.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<DoctorAppointmentHistoryModel>? _data;
  Links? _links;
  Meta? _meta;
  GetDoctorAppointmentHistoryDataModel copyWith({
    List<DoctorAppointmentHistoryModel>? data,
    Links? links,
    Meta? meta,
  }) =>
      GetDoctorAppointmentHistoryDataModel(
        data: data ?? _data,
        links: links ?? _links,
        meta: meta ?? _meta,
      );
  List<DoctorAppointmentHistoryModel>? get data => _data;
  Links? get links => _links;
  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map['links'] = _links?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}

Meta metaFromJson(String str) => Meta.fromJson(json.decode(str));
String metaToJson(Meta data) => json.encode(data.toJson());

class Meta {
  Meta({
    num? currentPage,
    num? from,
    num? lastPage,
    List<Links>? links,
    String? path,
    num? perPage,
    num? to,
    num? total,
  }) {
    _currentPage = currentPage;
    _from = from;
    _lastPage = lastPage;
    _links = links;
    _path = path;
    _perPage = perPage;
    _to = to;
    _total = total;
  }

  Meta.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _from = json['from'];
    _lastPage = json['last_page'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _path = json['path'];
    _perPage = json['per_page'];
    _to = json['to'];
    _total = json['total'];
  }
  num? _currentPage;
  num? _from;
  num? _lastPage;
  List<Links>? _links;
  String? _path;
  num? _perPage;
  num? _to;
  num? _total;
  Meta copyWith({
    num? currentPage,
    num? from,
    num? lastPage,
    List<Links>? links,
    String? path,
    num? perPage,
    num? to,
    num? total,
  }) =>
      Meta(
        currentPage: currentPage ?? _currentPage,
        from: from ?? _from,
        lastPage: lastPage ?? _lastPage,
        links: links ?? _links,
        path: path ?? _path,
        perPage: perPage ?? _perPage,
        to: to ?? _to,
        total: total ?? _total,
      );
  num? get currentPage => _currentPage;
  num? get from => _from;
  num? get lastPage => _lastPage;
  List<Links>? get links => _links;
  String? get path => _path;
  num? get perPage => _perPage;
  num? get to => _to;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

Links linksFromJson(String str) => Links.fromJson(json.decode(str));
String linksToJson(Links data) => json.encode(data.toJson());

class Links {
  Links({
    dynamic url,
    String? label,
    bool? active,
  }) {
    _url = url;
    _label = label;
    _active = active;
  }

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;
  Links copyWith({
    dynamic url,
    String? label,
    bool? active,
  }) =>
      Links(
        url: url ?? _url,
        label: label ?? _label,
        active: active ?? _active,
      );
  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }
}

DoctorAppointmentHistoryModel doctorAppointmentHistoryModelFromJson(
        String str) =>
    DoctorAppointmentHistoryModel.fromJson(json.decode(str));
String doctorAppointmentHistoryModelToJson(
        DoctorAppointmentHistoryModel data) =>
    json.encode(data.toJson());

class DoctorAppointmentHistoryModel {
  DoctorAppointmentHistoryModel({
    num? id,
    num? patientId,
    String? patientName,
    String? patientImage,
    String? doctorNameWithDate,
    String? appointmentStatusName,
    String? appointmentTypeName,
    num? isScheduleRequired,
    num? doctorId,
    String? doctorName,
    String? doctorImage,
    String? doctorSpeciality,
    dynamic clinicId,
    dynamic clinicName,
    dynamic clinicImage,
    String? date,
    String? startTime,
    String? endTime,
    num? fee,
    num? isPaid,
    num? appointmentTypeId,
    String? appointmentType,
    String? question,
    dynamic attachmentUrl,
    num? appointmentStatusCode,
    String? prescription,
    List<Messages>? messages,
    List<Medicines>? medicines,
    List<Tests>? tests,
    List<Diseases>? diseases,
    List<PatientHealths>? patientHealths,
    bool? isStarted,
    bool? isEnded,
    dynamic startedAt,
    dynamic endedAt,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _patientId = patientId;
    _patientName = patientName;
    _patientImage = patientImage;
    _doctorNameWithDate = doctorNameWithDate;
    _appointmentStatusName = appointmentStatusName;
    _appointmentTypeName = appointmentTypeName;
    _isScheduleRequired = isScheduleRequired;
    _doctorId = doctorId;
    _doctorName = doctorName;
    _doctorImage = doctorImage;
    _doctorSpeciality = doctorSpeciality;
    _clinicId = clinicId;
    _clinicName = clinicName;
    _clinicImage = clinicImage;
    _date = date;
    _startTime = startTime;
    _endTime = endTime;
    _fee = fee;
    _isPaid = isPaid;
    _appointmentTypeId = appointmentTypeId;
    _appointmentType = appointmentType;
    _question = question;
    _attachmentUrl = attachmentUrl;
    _appointmentStatusCode = appointmentStatusCode;
    _prescription = prescription;
    _messages = messages;
    _medicines = medicines;
    _tests = tests;
    _diseases = diseases;
    _patientHealths = patientHealths;
    _isStarted = isStarted;
    _isEnded = isEnded;
    _startedAt = startedAt;
    _endedAt = endedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  DoctorAppointmentHistoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _patientId = json['patient_id'];
    _patientName = json['patient_name'];
    _patientImage = json['patient_image'];
    _doctorNameWithDate = json['doctor_name_with_date'];
    _appointmentStatusName = json['appointment_status_name'];
    _appointmentTypeName = json['appointment_type_name'];
    _isScheduleRequired = json['is_schedule_required'];
    _doctorId = json['doctor_id'];
    _doctorName = json['doctor_name'];
    _doctorImage = json['doctor_image'];
    _doctorSpeciality = json['doctor_speciality'];
    _clinicId = json['clinic_id'];
    _clinicName = json['clinic_name'];
    _clinicImage = json['clinic_image'];
    _date = json['date'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _fee = json['fee'];
    _isPaid = json['is_paid'];
    _appointmentTypeId = json['appointment_type_id'];
    _appointmentType = json['appointment_type'];
    _question = json['question'];
    _attachmentUrl = json['attachment_url'];
    _appointmentStatusCode = json['appointment_status_code'];
    _prescription = json['prescription'];
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        _messages?.add(Messages.fromJson(v));
      });
    }
    if (json['medicines'] != null) {
      _medicines = [];
      json['medicines'].forEach((v) {
        _medicines?.add(Medicines.fromJson(v));
      });
    }
    if (json['tests'] != null) {
      _tests = [];
      json['tests'].forEach((v) {
        _tests?.add(Tests.fromJson(v));
      });
    }
    if (json['diseases'] != null) {
      _diseases = [];
      json['diseases'].forEach((v) {
        _diseases?.add(Diseases.fromJson(v));
      });
    }
    if (json['patient_healths'] != null) {
      _patientHealths = [];
      json['patient_healths'].forEach((v) {
        _patientHealths?.add(PatientHealths.fromJson(v));
      });
    }
    _isStarted = json['is_started'];
    _isEnded = json['is_ended'];
    _startedAt = json['started_at'];
    _endedAt = json['ended_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _patientId;
  String? _patientName;
  String? _patientImage;
  String? _doctorNameWithDate;
  String? _appointmentStatusName;
  String? _appointmentTypeName;
  num? _isScheduleRequired;
  num? _doctorId;
  String? _doctorName;
  String? _doctorImage;
  String? _doctorSpeciality;
  dynamic _clinicId;
  dynamic _clinicName;
  dynamic _clinicImage;
  String? _date;
  String? _startTime;
  String? _endTime;
  num? _fee;
  num? _isPaid;
  num? _appointmentTypeId;
  String? _appointmentType;
  String? _question;
  dynamic _attachmentUrl;
  num? _appointmentStatusCode;
  String? _prescription;
  List<Messages>? _messages;
  List<Medicines>? _medicines;
  List<Tests>? _tests;
  List<Diseases>? _diseases;
  List<PatientHealths>? _patientHealths;
  bool? _isStarted;
  bool? _isEnded;
  dynamic _startedAt;
  dynamic _endedAt;
  String? _createdAt;
  String? _updatedAt;
  DoctorAppointmentHistoryModel copyWith({
    num? id,
    num? patientId,
    String? patientName,
    String? patientImage,
    String? doctorNameWithDate,
    String? appointmentStatusName,
    String? appointmentTypeName,
    num? isScheduleRequired,
    num? doctorId,
    String? doctorName,
    String? doctorImage,
    String? doctorSpeciality,
    dynamic clinicId,
    dynamic clinicName,
    dynamic clinicImage,
    String? date,
    String? startTime,
    String? endTime,
    num? fee,
    num? isPaid,
    num? appointmentTypeId,
    String? appointmentType,
    String? question,
    dynamic attachmentUrl,
    num? appointmentStatusCode,
    String? prescription,
    List<Messages>? messages,
    List<Medicines>? medicines,
    List<Tests>? tests,
    List<Diseases>? diseases,
    List<PatientHealths>? patientHealths,
    bool? isStarted,
    bool? isEnded,
    dynamic startedAt,
    dynamic endedAt,
    String? createdAt,
    String? updatedAt,
  }) =>
      DoctorAppointmentHistoryModel(
        id: id ?? _id,
        patientId: patientId ?? _patientId,
        patientName: patientName ?? _patientName,
        patientImage: patientImage ?? _patientImage,
        doctorNameWithDate: doctorNameWithDate ?? _doctorNameWithDate,
        appointmentStatusName: appointmentStatusName ?? _appointmentStatusName,
        appointmentTypeName: appointmentTypeName ?? _appointmentTypeName,
        isScheduleRequired: isScheduleRequired ?? _isScheduleRequired,
        doctorId: doctorId ?? _doctorId,
        doctorName: doctorName ?? _doctorName,
        doctorImage: doctorImage ?? _doctorImage,
        doctorSpeciality: doctorSpeciality ?? _doctorSpeciality,
        clinicId: clinicId ?? _clinicId,
        clinicName: clinicName ?? _clinicName,
        clinicImage: clinicImage ?? _clinicImage,
        date: date ?? _date,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        fee: fee ?? _fee,
        isPaid: isPaid ?? _isPaid,
        appointmentTypeId: appointmentTypeId ?? _appointmentTypeId,
        appointmentType: appointmentType ?? _appointmentType,
        question: question ?? _question,
        attachmentUrl: attachmentUrl ?? _attachmentUrl,
        appointmentStatusCode: appointmentStatusCode ?? _appointmentStatusCode,
        prescription: prescription ?? _prescription,
        messages: messages ?? _messages,
        medicines: medicines ?? _medicines,
        tests: tests ?? _tests,
        diseases: diseases ?? _diseases,
        patientHealths: patientHealths ?? _patientHealths,
        isStarted: isStarted ?? _isStarted,
        isEnded: isEnded ?? _isEnded,
        startedAt: startedAt ?? _startedAt,
        endedAt: endedAt ?? _endedAt,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get patientId => _patientId;
  String? get patientName => _patientName;
  String? get patientImage => _patientImage;
  String? get doctorNameWithDate => _doctorNameWithDate;
  String? get appointmentStatusName => _appointmentStatusName;
  String? get appointmentTypeName => _appointmentTypeName;
  num? get isScheduleRequired => _isScheduleRequired;
  num? get doctorId => _doctorId;
  String? get doctorName => _doctorName;
  String? get doctorImage => _doctorImage;
  String? get doctorSpeciality => _doctorSpeciality;
  dynamic get clinicId => _clinicId;
  dynamic get clinicName => _clinicName;
  dynamic get clinicImage => _clinicImage;
  String? get date => _date;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  num? get fee => _fee;
  num? get isPaid => _isPaid;
  num? get appointmentTypeId => _appointmentTypeId;
  String? get appointmentType => _appointmentType;
  String? get question => _question;
  dynamic get attachmentUrl => _attachmentUrl;
  num? get appointmentStatusCode => _appointmentStatusCode;
  String? get prescription => _prescription;
  List<Messages>? get messages => _messages;
  List<Medicines>? get medicines => _medicines;
  List<Tests>? get tests => _tests;
  List<Diseases>? get diseases => _diseases;
  List<PatientHealths>? get patientHealths => _patientHealths;
  bool? get isStarted => _isStarted;
  bool? get isEnded => _isEnded;
  dynamic get startedAt => _startedAt;
  dynamic get endedAt => _endedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['patient_id'] = _patientId;
    map['patient_name'] = _patientName;
    map['patient_image'] = _patientImage;
    map['doctor_name_with_date'] = _doctorNameWithDate;
    map['appointment_status_name'] = _appointmentStatusName;
    map['appointment_type_name'] = _appointmentTypeName;
    map['is_schedule_required'] = _isScheduleRequired;
    map['doctor_id'] = _doctorId;
    map['doctor_name'] = _doctorName;
    map['doctor_image'] = _doctorImage;
    map['doctor_speciality'] = _doctorSpeciality;
    map['clinic_id'] = _clinicId;
    map['clinic_name'] = _clinicName;
    map['clinic_image'] = _clinicImage;
    map['date'] = _date;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['fee'] = _fee;
    map['is_paid'] = _isPaid;
    map['appointment_type_id'] = _appointmentTypeId;
    map['appointment_type'] = _appointmentType;
    map['question'] = _question;
    map['attachment_url'] = _attachmentUrl;
    map['appointment_status_code'] = _appointmentStatusCode;
    map['prescription'] = _prescription;
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    if (_medicines != null) {
      map['medicines'] = _medicines?.map((v) => v.toJson()).toList();
    }
    if (_tests != null) {
      map['tests'] = _tests?.map((v) => v.toJson()).toList();
    }
    if (_diseases != null) {
      map['diseases'] = _diseases?.map((v) => v.toJson()).toList();
    }
    if (_patientHealths != null) {
      map['patient_healths'] = _patientHealths?.map((v) => v.toJson()).toList();
    }
    map['is_started'] = _isStarted;
    map['is_ended'] = _isEnded;
    map['started_at'] = _startedAt;
    map['ended_at'] = _endedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

PatientHealths patientHealthsFromJson(String str) =>
    PatientHealths.fromJson(json.decode(str));
String patientHealthsToJson(PatientHealths data) => json.encode(data.toJson());

class PatientHealths {
  PatientHealths({
    num? id,
    String? name,
    num? value,
    dynamic description,
    dynamic image,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _value = value;
    _description = description;
    _image = image;
    _updatedAt = updatedAt;
  }

  PatientHealths.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _value = json['value'];
    _description = json['description'];
    _image = json['image'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  num? _value;
  dynamic _description;
  dynamic _image;
  String? _updatedAt;
  PatientHealths copyWith({
    num? id,
    String? name,
    num? value,
    dynamic description,
    dynamic image,
    String? updatedAt,
  }) =>
      PatientHealths(
        id: id ?? _id,
        name: name ?? _name,
        value: value ?? _value,
        description: description ?? _description,
        image: image ?? _image,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get name => _name;
  num? get value => _value;
  dynamic get description => _description;
  dynamic get image => _image;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['value'] = _value;
    map['description'] = _description;
    map['image'] = _image;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

Diseases diseasesFromJson(String str) => Diseases.fromJson(json.decode(str));
String diseasesToJson(Diseases data) => json.encode(data.toJson());

class Diseases {
  Diseases({
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

  Diseases.fromJson(dynamic json) {
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
  Diseases copyWith({
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
      Diseases(
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

Tests testsFromJson(String str) => Tests.fromJson(json.decode(str));
String testsToJson(Tests data) => json.encode(data.toJson());

class Tests {
  Tests({
    num? id,
    String? name,
    String? description,
    dynamic image,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _image = image;
    _updatedAt = updatedAt;
  }

  Tests.fromJson(dynamic json) {
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
  Tests copyWith({
    num? id,
    String? name,
    String? description,
    dynamic image,
    String? updatedAt,
  }) =>
      Tests(
        id: id ?? _id,
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

Medicines medicinesFromJson(String str) => Medicines.fromJson(json.decode(str));
String medicinesToJson(Medicines data) => json.encode(data.toJson());

class Medicines {
  Medicines({
    num? id,
    String? name,
    String? dosage,
    String? frequency,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _dosage = dosage;
    _frequency = frequency;
    _updatedAt = updatedAt;
  }

  Medicines.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _dosage = json['dosage'];
    _frequency = json['frequency'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _dosage;
  String? _frequency;
  String? _updatedAt;
  Medicines copyWith({
    num? id,
    String? name,
    String? dosage,
    String? frequency,
    String? updatedAt,
  }) =>
      Medicines(
        id: id ?? _id,
        name: name ?? _name,
        dosage: dosage ?? _dosage,
        frequency: frequency ?? _frequency,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get name => _name;
  String? get dosage => _dosage;
  String? get frequency => _frequency;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['dosage'] = _dosage;
    map['frequency'] = _frequency;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

Messages messagesFromJson(String str) => Messages.fromJson(json.decode(str));
String messagesToJson(Messages data) => json.encode(data.toJson());

class Messages {
  Messages({
    num? id,
    String? message,
    num? appointmentId,
    num? senderId,
    String? senderType,
    String? recieverId,
    String? recieverType,
    dynamic attachmentUrl,
    bool? isAttachment,
    bool? isSeen,
    dynamic seenAt,
    bool? isDelivered,
    dynamic deliveredAt,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _message = message;
    _appointmentId = appointmentId;
    _senderId = senderId;
    _senderType = senderType;
    _recieverId = recieverId;
    _recieverType = recieverType;
    _attachmentUrl = attachmentUrl;
    _isAttachment = isAttachment;
    _isSeen = isSeen;
    _seenAt = seenAt;
    _isDelivered = isDelivered;
    _deliveredAt = deliveredAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Messages.fromJson(dynamic json) {
    _id = json['id'];
    _message = json['message'];
    _appointmentId = json['appointment_id'];
    _senderId = json['sender_id'];
    _senderType = json['sender_type'];
    _recieverId = json['reciever_id'];
    _recieverType = json['reciever_type'];
    _attachmentUrl = json['attachment_url'];
    _isAttachment = json['is_attachment'];
    _isSeen = json['is_seen'];
    _seenAt = json['seen_at'];
    _isDelivered = json['is_delivered'];
    _deliveredAt = json['delivered_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _message;
  num? _appointmentId;
  num? _senderId;
  String? _senderType;
  String? _recieverId;
  String? _recieverType;
  dynamic _attachmentUrl;
  bool? _isAttachment;
  bool? _isSeen;
  dynamic _seenAt;
  bool? _isDelivered;
  dynamic _deliveredAt;
  String? _createdAt;
  String? _updatedAt;
  Messages copyWith({
    num? id,
    String? message,
    num? appointmentId,
    num? senderId,
    String? senderType,
    String? recieverId,
    String? recieverType,
    dynamic attachmentUrl,
    bool? isAttachment,
    bool? isSeen,
    dynamic seenAt,
    bool? isDelivered,
    dynamic deliveredAt,
    String? createdAt,
    String? updatedAt,
  }) =>
      Messages(
        id: id ?? _id,
        message: message ?? _message,
        appointmentId: appointmentId ?? _appointmentId,
        senderId: senderId ?? _senderId,
        senderType: senderType ?? _senderType,
        recieverId: recieverId ?? _recieverId,
        recieverType: recieverType ?? _recieverType,
        attachmentUrl: attachmentUrl ?? _attachmentUrl,
        isAttachment: isAttachment ?? _isAttachment,
        isSeen: isSeen ?? _isSeen,
        seenAt: seenAt ?? _seenAt,
        isDelivered: isDelivered ?? _isDelivered,
        deliveredAt: deliveredAt ?? _deliveredAt,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get message => _message;
  num? get appointmentId => _appointmentId;
  num? get senderId => _senderId;
  String? get senderType => _senderType;
  String? get recieverId => _recieverId;
  String? get recieverType => _recieverType;
  dynamic get attachmentUrl => _attachmentUrl;
  bool? get isAttachment => _isAttachment;
  bool? get isSeen => _isSeen;
  dynamic get seenAt => _seenAt;
  bool? get isDelivered => _isDelivered;
  dynamic get deliveredAt => _deliveredAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['message'] = _message;
    map['appointment_id'] = _appointmentId;
    map['sender_id'] = _senderId;
    map['sender_type'] = _senderType;
    map['reciever_id'] = _recieverId;
    map['reciever_type'] = _recieverType;
    map['attachment_url'] = _attachmentUrl;
    map['is_attachment'] = _isAttachment;
    map['is_seen'] = _isSeen;
    map['seen_at'] = _seenAt;
    map['is_delivered'] = _isDelivered;
    map['delivered_at'] = _deliveredAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
