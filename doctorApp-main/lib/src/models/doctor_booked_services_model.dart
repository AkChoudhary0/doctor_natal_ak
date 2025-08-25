import 'dart:convert';

GetDoctorBookedServicesModel getDoctorBookedServicesModelFromJson(String str) =>
    GetDoctorBookedServicesModel.fromJson(json.decode(str));
String getDoctorBookedServicesModelToJson(GetDoctorBookedServicesModel data) =>
    json.encode(data.toJson());

class GetDoctorBookedServicesModel {
  GetDoctorBookedServicesModel({
    GetDoctorBookedServicesDataModel? data,
    bool? success,
    String? message,
    dynamic errors,
  }) {
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
  }

  GetDoctorBookedServicesModel.fromJson(dynamic json) {
    _data = json['data'] != null
        ? GetDoctorBookedServicesDataModel.fromJson(json['data'])
        : null;
    _success = json['success'];
    _message = json['message'];
    _errors = json['errors'];
  }
  GetDoctorBookedServicesDataModel? _data;
  bool? _success;
  String? _message;
  dynamic _errors;
  GetDoctorBookedServicesModel copyWith({
    GetDoctorBookedServicesDataModel? data,
    bool? success,
    String? message,
    dynamic errors,
  }) =>
      GetDoctorBookedServicesModel(
        data: data ?? _data,
        success: success ?? _success,
        message: message ?? _message,
        errors: errors ?? _errors,
      );
  GetDoctorBookedServicesDataModel? get data => _data;
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

GetDoctorBookedServicesDataModel getDoctorBookedServicesDataModelFromJson(
        String str) =>
    GetDoctorBookedServicesDataModel.fromJson(json.decode(str));
String getDoctorBookedServicesDataModelToJson(
        GetDoctorBookedServicesDataModel getDoctorBookedServicesDataModel) =>
    json.encode(getDoctorBookedServicesDataModel.toJson());

class GetDoctorBookedServicesDataModel {
  GetDoctorBookedServicesDataModel({
    List<DoctorBookedServiceModel>? data,
    Links? links,
    Meta? meta,
  }) {
    _data = data;
    _links = links;
    _meta = meta;
  }

  GetDoctorBookedServicesDataModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DoctorBookedServiceModel.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<DoctorBookedServiceModel>? _data;
  Links? _links;
  Meta? _meta;
  GetDoctorBookedServicesDataModel copyWith({
    List<DoctorBookedServiceModel>? data,
    Links? links,
    Meta? meta,
  }) =>
      GetDoctorBookedServicesDataModel(
        data: data ?? _data,
        links: links ?? _links,
        meta: meta ?? _meta,
      );
  List<DoctorBookedServiceModel>? get data => _data;
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

DoctorBookedServiceModel dataFromJson(String str) =>
    DoctorBookedServiceModel.fromJson(json.decode(str));
String dataToJson(DoctorBookedServiceModel data) => json.encode(data.toJson());

class DoctorBookedServiceModel {
  DoctorBookedServiceModel({
    num? id,
    num? patientId,
    String? patientName,
    String? patientImage,
    num? doctorId,
    String? doctorName,
    String? doctorImage,
    dynamic clinicId,
    dynamic clinicName,
    dynamic clinicImage,
    num? serviceId,
    String? serviceName,
    String? serviceImage,
    String? serviceStatusName,
    String? date,
    dynamic startedAt,
    dynamic endedAt,
    num? price,
    num? isPaid,
    dynamic question,
    dynamic attachmentUrl,
    num? serviceStatusCode,
    List<dynamic>? messages,
    List<dynamic>? reviews,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _patientId = patientId;
    _patientName = patientName;
    _patientImage = patientImage;
    _doctorId = doctorId;
    _doctorName = doctorName;
    _doctorImage = doctorImage;
    _clinicId = clinicId;
    _clinicName = clinicName;
    _clinicImage = clinicImage;
    _serviceId = serviceId;
    _serviceName = serviceName;
    _serviceImage = serviceImage;
    _serviceStatusName = serviceStatusName;
    _date = date;
    _startedAt = startedAt;
    _endedAt = endedAt;
    _price = price;
    _isPaid = isPaid;
    _question = question;
    _attachmentUrl = attachmentUrl;
    _serviceStatusCode = serviceStatusCode;
    _messages = messages;
    _reviews = reviews;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  DoctorBookedServiceModel.fromJson(dynamic json) {
    _id = json['id'];
    _patientId = json['patient_id'];
    _patientName = json['patient_name'];
    _patientImage = json['patient_image'];
    _doctorId = json['doctor_id'];
    _doctorName = json['doctor_name'];
    _doctorImage = json['doctor_image'];
    _clinicId = json['clinic_id'];
    _clinicName = json['clinic_name'];
    _clinicImage = json['clinic_image'];
    _serviceId = json['service_id'];
    _serviceName = json['service_name'];
    _serviceImage = json['service_image'];
    _serviceStatusName = json['service_status_name'];
    _date = json['date'];
    _startedAt = json['started_at'];
    _endedAt = json['ended_at'];
    _price = json['price'];
    _isPaid = json['is_paid'];
    _question = json['question'];
    _attachmentUrl = json['attachment_url'];
    _serviceStatusCode = json['service_status_code'];
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        // _messages?.add(Dynamic.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        // _reviews?.add(Dynamic.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _patientId;
  String? _patientName;
  String? _patientImage;
  num? _doctorId;
  String? _doctorName;
  String? _doctorImage;
  dynamic _clinicId;
  dynamic _clinicName;
  dynamic _clinicImage;
  num? _serviceId;
  String? _serviceName;
  String? _serviceImage;
  String? _serviceStatusName;
  String? _date;
  dynamic _startedAt;
  dynamic _endedAt;
  num? _price;
  num? _isPaid;
  dynamic _question;
  dynamic _attachmentUrl;
  num? _serviceStatusCode;
  List<dynamic>? _messages;
  List<dynamic>? _reviews;
  String? _createdAt;
  String? _updatedAt;
  DoctorBookedServiceModel copyWith({
    num? id,
    num? patientId,
    String? patientName,
    String? patientImage,
    num? doctorId,
    String? doctorName,
    String? doctorImage,
    dynamic clinicId,
    dynamic clinicName,
    dynamic clinicImage,
    num? serviceId,
    String? serviceName,
    String? serviceImage,
    String? serviceStatusName,
    String? date,
    dynamic startedAt,
    dynamic endedAt,
    num? price,
    num? isPaid,
    dynamic question,
    dynamic attachmentUrl,
    num? serviceStatusCode,
    List<dynamic>? messages,
    List<dynamic>? reviews,
    String? createdAt,
    String? updatedAt,
  }) =>
      DoctorBookedServiceModel(
        id: id ?? _id,
        patientId: patientId ?? _patientId,
        patientName: patientName ?? _patientName,
        patientImage: patientImage ?? _patientImage,
        doctorId: doctorId ?? _doctorId,
        doctorName: doctorName ?? _doctorName,
        doctorImage: doctorImage ?? _doctorImage,
        clinicId: clinicId ?? _clinicId,
        clinicName: clinicName ?? _clinicName,
        clinicImage: clinicImage ?? _clinicImage,
        serviceId: serviceId ?? _serviceId,
        serviceName: serviceName ?? _serviceName,
        serviceImage: serviceImage ?? _serviceImage,
        serviceStatusName: serviceStatusName ?? _serviceStatusName,
        date: date ?? _date,
        startedAt: startedAt ?? _startedAt,
        endedAt: endedAt ?? _endedAt,
        price: price ?? _price,
        isPaid: isPaid ?? _isPaid,
        question: question ?? _question,
        attachmentUrl: attachmentUrl ?? _attachmentUrl,
        serviceStatusCode: serviceStatusCode ?? _serviceStatusCode,
        messages: messages ?? _messages,
        reviews: reviews ?? _reviews,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get patientId => _patientId;
  String? get patientName => _patientName;
  String? get patientImage => _patientImage;
  num? get doctorId => _doctorId;
  String? get doctorName => _doctorName;
  String? get doctorImage => _doctorImage;
  dynamic get clinicId => _clinicId;
  dynamic get clinicName => _clinicName;
  dynamic get clinicImage => _clinicImage;
  num? get serviceId => _serviceId;
  String? get serviceName => _serviceName;
  String? get serviceImage => _serviceImage;
  String? get serviceStatusName => _serviceStatusName;
  String? get date => _date;
  dynamic get startedAt => _startedAt;
  dynamic get endedAt => _endedAt;
  num? get price => _price;
  num? get isPaid => _isPaid;
  dynamic get question => _question;
  dynamic get attachmentUrl => _attachmentUrl;
  num? get serviceStatusCode => _serviceStatusCode;
  List<dynamic>? get messages => _messages;
  List<dynamic>? get reviews => _reviews;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['patient_id'] = _patientId;
    map['patient_name'] = _patientName;
    map['patient_image'] = _patientImage;
    map['doctor_id'] = _doctorId;
    map['doctor_name'] = _doctorName;
    map['doctor_image'] = _doctorImage;
    map['clinic_id'] = _clinicId;
    map['clinic_name'] = _clinicName;
    map['clinic_image'] = _clinicImage;
    map['service_id'] = _serviceId;
    map['service_name'] = _serviceName;
    map['service_image'] = _serviceImage;
    map['service_status_name'] = _serviceStatusName;
    map['date'] = _date;
    map['started_at'] = _startedAt;
    map['ended_at'] = _endedAt;
    map['price'] = _price;
    map['is_paid'] = _isPaid;
    map['question'] = _question;
    map['attachment_url'] = _attachmentUrl;
    map['service_status_code'] = _serviceStatusCode;
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
