import 'dart:convert';

GetLoggedInDoctorModel getLoggedInDoctorModelFromJson(String str) =>
    GetLoggedInDoctorModel.fromJson(json.decode(str));
String getLoggedInDoctorModelToJson(GetLoggedInDoctorModel data) =>
    json.encode(data.toJson());

class GetLoggedInDoctorModel {
  GetLoggedInDoctorModel({
    GetLoggedInDoctorDataModel? data,
    bool? success,
    String? message,
    dynamic errors,
  }) {
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
  }

  GetLoggedInDoctorModel.fromJson(dynamic json) {
    _data = json['data'] != null
        ? GetLoggedInDoctorDataModel.fromJson(json['data'])
        : null;
    _success = json['success'];
    _message = json['message'];
    _errors = json['errors'];
  }
  GetLoggedInDoctorDataModel? _data;
  bool? _success;
  String? _message;
  dynamic _errors;
  GetLoggedInDoctorModel copyWith({
    GetLoggedInDoctorDataModel? data,
    bool? success,
    String? message,
    dynamic errors,
  }) =>
      GetLoggedInDoctorModel(
        data: data ?? _data,
        success: success ?? _success,
        message: message ?? _message,
        errors: errors ?? _errors,
      );
  GetLoggedInDoctorDataModel? get data => _data;
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

GetLoggedInDoctorDataModel dataFromJson(String str) =>
    GetLoggedInDoctorDataModel.fromJson(json.decode(str));
String dataToJson(GetLoggedInDoctorDataModel data) =>
    json.encode(data.toJson());

class GetLoggedInDoctorDataModel {
  GetLoggedInDoctorDataModel({
    num? id,
    String? name,
    String? email,
    num? isActive,
    dynamic countryId,
    String? emailVerifiedAt,
    bool? isEmailVerified,
    dynamic profileImagePath,
    dynamic passwordLastChanged,
    bool? isDoctor,
    bool? isPatient,
    bool? isClinic,
    List<String>? doctorModules,
    List<String>? clinicModules,
    LoginInfo? loginInfo,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _isActive = isActive;
    _countryId = countryId;
    _emailVerifiedAt = emailVerifiedAt;
    _isEmailVerified = isEmailVerified;
    _profileImagePath = profileImagePath;
    _passwordLastChanged = passwordLastChanged;
    _isDoctor = isDoctor;
    _isPatient = isPatient;
    _isClinic = isClinic;
    _doctorModules = doctorModules;
    _clinicModules = clinicModules;
    _loginInfo = loginInfo;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  GetLoggedInDoctorDataModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _isActive = json['is_active'];
    _countryId = json['country_id'];
    _emailVerifiedAt = json['email_verified_at'];
    _isEmailVerified = json['is_email_verified'];
    _profileImagePath = json['profile_image_path'];
    _passwordLastChanged = json['password_last_changed'];
    _isDoctor = json['is_doctor'];
    _isPatient = json['is_patient'];
    _isClinic = json['is_clinic'];
    _doctorModules = json['doctor_modules'] != null
        ? json['doctor_modules'].cast<String>()
        : [];
    if (json['clinic_modules'] != null) {
      _clinicModules = [];
      json['clinic_modules'].forEach((v) {
        // _clinicModules?.add(Dynamic.fromJson(v));
      });
    }
    _loginInfo = json['login_info'] != null
        ? LoginInfo.fromJson(json['login_info'])
        : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  num? _id;
  String? _name;
  String? _email;
  num? _isActive;
  dynamic _countryId;
  String? _emailVerifiedAt;
  bool? _isEmailVerified;
  dynamic _profileImagePath;
  dynamic _passwordLastChanged;
  bool? _isDoctor;
  bool? _isPatient;
  bool? _isClinic;
  List<String>? _doctorModules;
  List<String>? _clinicModules;
  LoginInfo? _loginInfo;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  GetLoggedInDoctorDataModel copyWith({
    num? id,
    String? name,
    String? email,
    num? isActive,
    dynamic countryId,
    String? emailVerifiedAt,
    bool? isEmailVerified,
    dynamic profileImagePath,
    dynamic passwordLastChanged,
    bool? isDoctor,
    bool? isPatient,
    bool? isClinic,
    List<String>? doctorModules,
    List<String>? clinicModules,
    LoginInfo? loginInfo,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      GetLoggedInDoctorDataModel(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        isActive: isActive ?? _isActive,
        countryId: countryId ?? _countryId,
        emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
        isEmailVerified: isEmailVerified ?? _isEmailVerified,
        profileImagePath: profileImagePath ?? _profileImagePath,
        passwordLastChanged: passwordLastChanged ?? _passwordLastChanged,
        isDoctor: isDoctor ?? _isDoctor,
        isPatient: isPatient ?? _isPatient,
        isClinic: isClinic ?? _isClinic,
        doctorModules: doctorModules ?? _doctorModules,
        clinicModules: clinicModules ?? _clinicModules,
        loginInfo: loginInfo ?? _loginInfo,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
      );
  num? get id => _id;
  String? get name => _name;
  String? get email => _email;
  num? get isActive => _isActive;
  dynamic get countryId => _countryId;
  String? get emailVerifiedAt => _emailVerifiedAt;
  bool? get isEmailVerified => _isEmailVerified;
  dynamic get profileImagePath => _profileImagePath;
  dynamic get passwordLastChanged => _passwordLastChanged;
  bool? get isDoctor => _isDoctor;
  bool? get isPatient => _isPatient;
  bool? get isClinic => _isClinic;
  List<String>? get doctorModules => _doctorModules;
  List<String>? get clinicModules => _clinicModules;
  LoginInfo? get loginInfo => _loginInfo;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['is_active'] = _isActive;
    map['country_id'] = _countryId;
    map['email_verified_at'] = _emailVerifiedAt;
    map['is_email_verified'] = _isEmailVerified;
    map['profile_image_path'] = _profileImagePath;
    map['password_last_changed'] = _passwordLastChanged;
    map['is_doctor'] = _isDoctor;
    map['is_patient'] = _isPatient;
    map['is_clinic'] = _isClinic;
    map['doctor_modules'] = _doctorModules;
    map['clinic_modules'] = _doctorModules;
    // if (_clinicModules != null) {
    //   map['clinic_modules'] =
    //       _clinicModules?.map((v) => v.toJson()).toList();
    // }
    if (_loginInfo != null) {
      map['login_info'] = _loginInfo?.toJson();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }
}

LoginInfo loginInfoFromJson(String str) => LoginInfo.fromJson(json.decode(str));
String loginInfoToJson(LoginInfo data) => json.encode(data.toJson());

class LoginInfo {
  LoginInfo({
    num? id,
    num? userId,
    dynamic countryId,
    dynamic stateId,
    dynamic cityId,
    String? name,
    String? firstName,
    String? lastName,
    String? description,
    String? addressLine1,
    String? addressLine2,
    String? userName,
    String? zipCode,
    num? isApproved,
    String? approvedAt,
    num? isActive,
    num? isOnline,
    num? isFeatured,
    dynamic icon,
    String? image,
    dynamic coverImage,
    num? rating,
    DoctorSettings? doctorSettings,
    List<num>? doctorCategoryIds,
    AppointmentTypes? appointmentTypes,
    List<DoctorCategories>? doctorCategories,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _countryId = countryId;
    _stateId = stateId;
    _cityId = cityId;
    _name = name;
    _firstName = firstName;
    _lastName = lastName;
    _description = description;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _userName = userName;
    _zipCode = zipCode;
    _isApproved = isApproved;
    _approvedAt = approvedAt;
    _isActive = isActive;
    _isOnline = isOnline;
    _isFeatured = isFeatured;
    _icon = icon;
    _image = image;
    _coverImage = coverImage;
    _rating = rating;
    _doctorSettings = doctorSettings;
    _doctorCategoryIds = doctorCategoryIds;
    _appointmentTypes = appointmentTypes;
    _doctorCategories = doctorCategories;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  LoginInfo.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _countryId = json['country_id'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _name = json['name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _description = json['description'];
    _addressLine1 = json['address_line_1'];
    _addressLine2 = json['address_line_2'];
    _userName = json['user_name'];
    _zipCode = json['zip_code'];
    _isApproved = json['is_approved'];
    _approvedAt = json['approved_at'];
    _isActive = json['is_active'];
    _isOnline = json['is_online'];
    _isFeatured = json['is_featured'];
    _icon = json['icon'];
    _image = json['image'];
    _coverImage = json['cover_image'];
    _rating = json['rating'];
    _doctorSettings = json['doctor_settings'] != null
        ? DoctorSettings.fromJson(json['doctor_settings'])
        : null;
    _doctorCategoryIds = json['doctor_category_ids'] != null
        ? json['doctor_category_ids'].cast<num>()
        : [];
    _appointmentTypes = json['appointment_types'] != null
        ? AppointmentTypes.fromJson(json['appointment_types'])
        : null;
    if (json['doctor_categories'] != null) {
      _doctorCategories = [];
      json['doctor_categories'].forEach((v) {
        _doctorCategories?.add(DoctorCategories.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _userId;
  dynamic _countryId;
  dynamic _stateId;
  dynamic _cityId;
  String? _name;
  String? _firstName;
  String? _lastName;
  String? _description;
  String? _addressLine1;
  String? _addressLine2;
  String? _userName;
  String? _zipCode;
  num? _isApproved;
  String? _approvedAt;
  num? _isActive;
  num? _isOnline;
  num? _isFeatured;
  dynamic _icon;
  String? _image;
  dynamic _coverImage;
  num? _rating;
  DoctorSettings? _doctorSettings;
  List<num>? _doctorCategoryIds;
  AppointmentTypes? _appointmentTypes;
  List<DoctorCategories>? _doctorCategories;
  String? _createdAt;
  String? _updatedAt;
  LoginInfo copyWith({
    num? id,
    num? userId,
    dynamic countryId,
    dynamic stateId,
    dynamic cityId,
    String? name,
    String? firstName,
    String? lastName,
    String? description,
    String? addressLine1,
    String? addressLine2,
    String? userName,
    String? zipCode,
    num? isApproved,
    String? approvedAt,
    num? isActive,
    num? isOnline,
    num? isFeatured,
    dynamic icon,
    String? image,
    dynamic coverImage,
    num? rating,
    DoctorSettings? doctorSettings,
    List<num>? doctorCategoryIds,
    AppointmentTypes? appointmentTypes,
    List<DoctorCategories>? doctorCategories,
    String? createdAt,
    String? updatedAt,
  }) =>
      LoginInfo(
        id: id ?? _id,
        userId: userId ?? _userId,
        countryId: countryId ?? _countryId,
        stateId: stateId ?? _stateId,
        cityId: cityId ?? _cityId,
        name: name ?? _name,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        description: description ?? _description,
        addressLine1: addressLine1 ?? _addressLine1,
        addressLine2: addressLine2 ?? _addressLine2,
        userName: userName ?? _userName,
        zipCode: zipCode ?? _zipCode,
        isApproved: isApproved ?? _isApproved,
        approvedAt: approvedAt ?? _approvedAt,
        isActive: isActive ?? _isActive,
        isOnline: isOnline ?? _isOnline,
        isFeatured: isFeatured ?? _isFeatured,
        icon: icon ?? _icon,
        image: image ?? _image,
        coverImage: coverImage ?? _coverImage,
        rating: rating ?? _rating,
        doctorSettings: doctorSettings ?? _doctorSettings,
        doctorCategoryIds: doctorCategoryIds ?? _doctorCategoryIds,
        appointmentTypes: appointmentTypes ?? _appointmentTypes,
        doctorCategories: doctorCategories ?? _doctorCategories,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get userId => _userId;
  dynamic get countryId => _countryId;
  dynamic get stateId => _stateId;
  dynamic get cityId => _cityId;
  String? get name => _name;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get description => _description;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get userName => _userName;
  String? get zipCode => _zipCode;
  num? get isApproved => _isApproved;
  String? get approvedAt => _approvedAt;
  num? get isActive => _isActive;
  num? get isOnline => _isOnline;
  num? get isFeatured => _isFeatured;
  dynamic get icon => _icon;
  String? get image => _image;
  dynamic get coverImage => _coverImage;
  num? get rating => _rating;
  DoctorSettings? get doctorSettings => _doctorSettings;
  List<num>? get doctorCategoryIds => _doctorCategoryIds;
  AppointmentTypes? get appointmentTypes => _appointmentTypes;
  List<DoctorCategories>? get doctorCategories => _doctorCategories;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['country_id'] = _countryId;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['name'] = _name;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['description'] = _description;
    map['address_line_1'] = _addressLine1;
    map['address_line_2'] = _addressLine2;
    map['user_name'] = _userName;
    map['zip_code'] = _zipCode;
    map['is_approved'] = _isApproved;
    map['approved_at'] = _approvedAt;
    map['is_active'] = _isActive;
    map['is_online'] = _isOnline;
    map['is_featured'] = _isFeatured;
    map['icon'] = _icon;
    map['image'] = _image;
    map['cover_image'] = _coverImage;
    map['rating'] = _rating;
    if (_doctorSettings != null) {
      map['doctor_settings'] = _doctorSettings?.toJson();
    }
    map['doctor_category_ids'] = _doctorCategoryIds;
    if (_appointmentTypes != null) {
      map['appointment_types'] = _appointmentTypes?.toJson();
    }
    if (_doctorCategories != null) {
      map['doctor_categories'] =
          _doctorCategories?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

DoctorCategories doctorCategoriesFromJson(String str) =>
    DoctorCategories.fromJson(json.decode(str));
String doctorCategoriesToJson(DoctorCategories data) =>
    json.encode(data.toJson());

class DoctorCategories {
  DoctorCategories({
    num? id,
    String? name,
    String? description,
    String? slug,
    num? isActive,
    num? isFeatured,
    dynamic icon,
    dynamic image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _slug = slug;
    _isActive = isActive;
    _isFeatured = isFeatured;
    _icon = icon;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  DoctorCategories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _slug = json['slug'];
    _isActive = json['is_active'];
    _isFeatured = json['is_featured'];
    _icon = json['icon'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _description;
  String? _slug;
  num? _isActive;
  num? _isFeatured;
  dynamic _icon;
  dynamic _image;
  String? _createdAt;
  String? _updatedAt;
  DoctorCategories copyWith({
    num? id,
    String? name,
    String? description,
    String? slug,
    num? isActive,
    num? isFeatured,
    dynamic icon,
    dynamic image,
    String? createdAt,
    String? updatedAt,
  }) =>
      DoctorCategories(
        id: id ?? _id,
        name: name ?? _name,
        description: description ?? _description,
        slug: slug ?? _slug,
        isActive: isActive ?? _isActive,
        isFeatured: isFeatured ?? _isFeatured,
        icon: icon ?? _icon,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get slug => _slug;
  num? get isActive => _isActive;
  num? get isFeatured => _isFeatured;
  dynamic get icon => _icon;
  dynamic get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['slug'] = _slug;
    map['is_active'] = _isActive;
    map['is_featured'] = _isFeatured;
    map['icon'] = _icon;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

AppointmentTypes appointmentTypesFromJson(String str) =>
    AppointmentTypes.fromJson(json.decode(str));
String appointmentTypesToJson(AppointmentTypes data) =>
    json.encode(data.toJson());

class AppointmentTypes {
  AppointmentTypes({
    Chat? chat,
    Video? video,
    Audio? audio,
  }) {
    _chat = chat;
    _video = video;
    _audio = audio;
  }

  AppointmentTypes.fromJson(dynamic json) {
    _chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
    _video = json['video'] != null ? Video.fromJson(json['video']) : null;
    _audio = json['audio'] != null ? Audio.fromJson(json['audio']) : null;
  }
  Chat? _chat;
  Video? _video;
  Audio? _audio;
  AppointmentTypes copyWith({
    Chat? chat,
    Video? video,
    Audio? audio,
  }) =>
      AppointmentTypes(
        chat: chat ?? _chat,
        video: video ?? _video,
        audio: audio ?? _audio,
      );
  Chat? get chat => _chat;
  Video? get video => _video;
  Audio? get audio => _audio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_chat != null) {
      map['chat'] = _chat?.toJson();
    }
    if (_video != null) {
      map['video'] = _video?.toJson();
    }
    if (_audio != null) {
      map['audio'] = _audio?.toJson();
    }
    return map;
  }
}

Audio audioFromJson(String str) => Audio.fromJson(json.decode(str));
String audioToJson(Audio data) => json.encode(data.toJson());

class Audio {
  Audio({
    num? id,
    num? doctorId,
    dynamic clinicId,
    num? appointmentTypeId,
    num? fee,
    String? day,
    num? isHoliday,
    String? startTime,
    String? endTime,
    num? slotDuration,
    String? type,
    AppointmentType? appointmentType,
    List<dynamic>? scheduleSlots,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _doctorId = doctorId;
    _clinicId = clinicId;
    _appointmentTypeId = appointmentTypeId;
    _fee = fee;
    _day = day;
    _isHoliday = isHoliday;
    _startTime = startTime;
    _endTime = endTime;
    _slotDuration = slotDuration;
    _type = type;
    _appointmentType = appointmentType;
    _scheduleSlots = scheduleSlots;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Audio.fromJson(dynamic json) {
    _id = json['id'];
    _doctorId = json['doctor_id'];
    _clinicId = json['clinic_id'];
    _appointmentTypeId = json['appointment_type_id'];
    _fee = json['fee'];
    _day = json['day'];
    _isHoliday = json['is_holiday'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _slotDuration = json['slot_duration'];
    _type = json['type'];
    _appointmentType = json['appointment_type'] != null
        ? AppointmentType.fromJson(json['appointment_type'])
        : null;
    if (json['schedule_slots'] != null) {
      _scheduleSlots = [];
      json['schedule_slots'].forEach((v) {
        // _scheduleSlots?.add(Dynamic.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _doctorId;
  dynamic _clinicId;
  num? _appointmentTypeId;
  num? _fee;
  String? _day;
  num? _isHoliday;
  String? _startTime;
  String? _endTime;
  num? _slotDuration;
  String? _type;
  AppointmentType? _appointmentType;
  List<dynamic>? _scheduleSlots;
  String? _createdAt;
  String? _updatedAt;
  Audio copyWith({
    num? id,
    num? doctorId,
    dynamic clinicId,
    num? appointmentTypeId,
    num? fee,
    String? day,
    num? isHoliday,
    String? startTime,
    String? endTime,
    num? slotDuration,
    String? type,
    AppointmentType? appointmentType,
    List<dynamic>? scheduleSlots,
    String? createdAt,
    String? updatedAt,
  }) =>
      Audio(
        id: id ?? _id,
        doctorId: doctorId ?? _doctorId,
        clinicId: clinicId ?? _clinicId,
        appointmentTypeId: appointmentTypeId ?? _appointmentTypeId,
        fee: fee ?? _fee,
        day: day ?? _day,
        isHoliday: isHoliday ?? _isHoliday,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        slotDuration: slotDuration ?? _slotDuration,
        type: type ?? _type,
        appointmentType: appointmentType ?? _appointmentType,
        scheduleSlots: scheduleSlots ?? _scheduleSlots,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get doctorId => _doctorId;
  dynamic get clinicId => _clinicId;
  num? get appointmentTypeId => _appointmentTypeId;
  num? get fee => _fee;
  String? get day => _day;
  num? get isHoliday => _isHoliday;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  num? get slotDuration => _slotDuration;
  String? get type => _type;
  AppointmentType? get appointmentType => _appointmentType;
  List<dynamic>? get scheduleSlots => _scheduleSlots;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['doctor_id'] = _doctorId;
    map['clinic_id'] = _clinicId;
    map['appointment_type_id'] = _appointmentTypeId;
    map['fee'] = _fee;
    map['day'] = _day;
    map['is_holiday'] = _isHoliday;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['slot_duration'] = _slotDuration;
    map['type'] = _type;
    if (_appointmentType != null) {
      map['appointment_type'] = _appointmentType?.toJson();
    }
    if (_scheduleSlots != null) {
      map['schedule_slots'] = _scheduleSlots?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

AppointmentType appointmentTypeFromJson(String str) =>
    AppointmentType.fromJson(json.decode(str));
String appointmentTypeToJson(AppointmentType data) =>
    json.encode(data.toJson());

class AppointmentType {
  AppointmentType({
    num? id,
    String? displayName,
    String? description,
    String? type,
    num? isScheduleRequired,
    num? isPaid,
    num? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _displayName = displayName;
    _description = description;
    _type = type;
    _isScheduleRequired = isScheduleRequired;
    _isPaid = isPaid;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  AppointmentType.fromJson(dynamic json) {
    _id = json['id'];
    _displayName = json['display_name'];
    _description = json['description'];
    _type = json['type'];
    _isScheduleRequired = json['is_schedule_required'];
    _isPaid = json['is_paid'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _displayName;
  String? _description;
  String? _type;
  num? _isScheduleRequired;
  num? _isPaid;
  num? _isActive;
  String? _createdAt;
  String? _updatedAt;
  AppointmentType copyWith({
    num? id,
    String? displayName,
    String? description,
    String? type,
    num? isScheduleRequired,
    num? isPaid,
    num? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      AppointmentType(
        id: id ?? _id,
        displayName: displayName ?? _displayName,
        description: description ?? _description,
        type: type ?? _type,
        isScheduleRequired: isScheduleRequired ?? _isScheduleRequired,
        isPaid: isPaid ?? _isPaid,
        isActive: isActive ?? _isActive,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get displayName => _displayName;
  String? get description => _description;
  String? get type => _type;
  num? get isScheduleRequired => _isScheduleRequired;
  num? get isPaid => _isPaid;
  num? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['display_name'] = _displayName;
    map['description'] = _description;
    map['type'] = _type;
    map['is_schedule_required'] = _isScheduleRequired;
    map['is_paid'] = _isPaid;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

Video videoFromJson(String str) => Video.fromJson(json.decode(str));
String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  Video({
    num? id,
    num? doctorId,
    dynamic clinicId,
    num? appointmentTypeId,
    num? fee,
    String? day,
    num? isHoliday,
    String? startTime,
    String? endTime,
    num? slotDuration,
    String? type,
    AppointmentType? appointmentType,
    List<dynamic>? scheduleSlots,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _doctorId = doctorId;
    _clinicId = clinicId;
    _appointmentTypeId = appointmentTypeId;
    _fee = fee;
    _day = day;
    _isHoliday = isHoliday;
    _startTime = startTime;
    _endTime = endTime;
    _slotDuration = slotDuration;
    _type = type;
    _appointmentType = appointmentType;
    _scheduleSlots = scheduleSlots;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Video.fromJson(dynamic json) {
    _id = json['id'];
    _doctorId = json['doctor_id'];
    _clinicId = json['clinic_id'];
    _appointmentTypeId = json['appointment_type_id'];
    _fee = json['fee'];
    _day = json['day'];
    _isHoliday = json['is_holiday'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _slotDuration = json['slot_duration'];
    _type = json['type'];
    _appointmentType = json['appointment_type'] != null
        ? AppointmentType.fromJson(json['appointment_type'])
        : null;
    if (json['schedule_slots'] != null) {
      _scheduleSlots = [];
      json['schedule_slots'].forEach((v) {
        // _scheduleSlots?.add(Dynamic.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _doctorId;
  dynamic _clinicId;
  num? _appointmentTypeId;
  num? _fee;
  String? _day;
  num? _isHoliday;
  String? _startTime;
  String? _endTime;
  num? _slotDuration;
  String? _type;
  AppointmentType? _appointmentType;
  List<dynamic>? _scheduleSlots;
  String? _createdAt;
  String? _updatedAt;
  Video copyWith({
    num? id,
    num? doctorId,
    dynamic clinicId,
    num? appointmentTypeId,
    num? fee,
    String? day,
    num? isHoliday,
    String? startTime,
    String? endTime,
    num? slotDuration,
    String? type,
    AppointmentType? appointmentType,
    List<dynamic>? scheduleSlots,
    String? createdAt,
    String? updatedAt,
  }) =>
      Video(
        id: id ?? _id,
        doctorId: doctorId ?? _doctorId,
        clinicId: clinicId ?? _clinicId,
        appointmentTypeId: appointmentTypeId ?? _appointmentTypeId,
        fee: fee ?? _fee,
        day: day ?? _day,
        isHoliday: isHoliday ?? _isHoliday,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        slotDuration: slotDuration ?? _slotDuration,
        type: type ?? _type,
        appointmentType: appointmentType ?? _appointmentType,
        scheduleSlots: scheduleSlots ?? _scheduleSlots,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get doctorId => _doctorId;
  dynamic get clinicId => _clinicId;
  num? get appointmentTypeId => _appointmentTypeId;
  num? get fee => _fee;
  String? get day => _day;
  num? get isHoliday => _isHoliday;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  num? get slotDuration => _slotDuration;
  String? get type => _type;
  AppointmentType? get appointmentType => _appointmentType;
  List<dynamic>? get scheduleSlots => _scheduleSlots;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['doctor_id'] = _doctorId;
    map['clinic_id'] = _clinicId;
    map['appointment_type_id'] = _appointmentTypeId;
    map['fee'] = _fee;
    map['day'] = _day;
    map['is_holiday'] = _isHoliday;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['slot_duration'] = _slotDuration;
    map['type'] = _type;
    if (_appointmentType != null) {
      map['appointment_type'] = _appointmentType?.toJson();
    }
    if (_scheduleSlots != null) {
      map['schedule_slots'] = _scheduleSlots?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));
String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  Chat({
    num? id,
    num? doctorId,
    dynamic clinicId,
    num? appointmentTypeId,
    num? fee,
    dynamic day,
    dynamic isHoliday,
    dynamic startTime,
    dynamic endTime,
    dynamic slotDuration,
    String? type,
    AppointmentType? appointmentType,
    List<dynamic>? scheduleSlots,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _doctorId = doctorId;
    _clinicId = clinicId;
    _appointmentTypeId = appointmentTypeId;
    _fee = fee;
    _day = day;
    _isHoliday = isHoliday;
    _startTime = startTime;
    _endTime = endTime;
    _slotDuration = slotDuration;
    _type = type;
    _appointmentType = appointmentType;
    _scheduleSlots = scheduleSlots;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Chat.fromJson(dynamic json) {
    _id = json['id'];
    _doctorId = json['doctor_id'];
    _clinicId = json['clinic_id'];
    _appointmentTypeId = json['appointment_type_id'];
    _fee = json['fee'];
    _day = json['day'];
    _isHoliday = json['is_holiday'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _slotDuration = json['slot_duration'];
    _type = json['type'];
    _appointmentType = json['appointment_type'] != null
        ? AppointmentType.fromJson(json['appointment_type'])
        : null;
    if (json['schedule_slots'] != null) {
      _scheduleSlots = [];
      json['schedule_slots'].forEach((v) {
        // _scheduleSlots?.add(Dynamic.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _doctorId;
  dynamic _clinicId;
  num? _appointmentTypeId;
  num? _fee;
  dynamic _day;
  dynamic _isHoliday;
  dynamic _startTime;
  dynamic _endTime;
  dynamic _slotDuration;
  String? _type;
  AppointmentType? _appointmentType;
  List<dynamic>? _scheduleSlots;
  String? _createdAt;
  String? _updatedAt;
  Chat copyWith({
    num? id,
    num? doctorId,
    dynamic clinicId,
    num? appointmentTypeId,
    num? fee,
    dynamic day,
    dynamic isHoliday,
    dynamic startTime,
    dynamic endTime,
    dynamic slotDuration,
    String? type,
    AppointmentType? appointmentType,
    List<dynamic>? scheduleSlots,
    String? createdAt,
    String? updatedAt,
  }) =>
      Chat(
        id: id ?? _id,
        doctorId: doctorId ?? _doctorId,
        clinicId: clinicId ?? _clinicId,
        appointmentTypeId: appointmentTypeId ?? _appointmentTypeId,
        fee: fee ?? _fee,
        day: day ?? _day,
        isHoliday: isHoliday ?? _isHoliday,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        slotDuration: slotDuration ?? _slotDuration,
        type: type ?? _type,
        appointmentType: appointmentType ?? _appointmentType,
        scheduleSlots: scheduleSlots ?? _scheduleSlots,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  num? get doctorId => _doctorId;
  dynamic get clinicId => _clinicId;
  num? get appointmentTypeId => _appointmentTypeId;
  num? get fee => _fee;
  dynamic get day => _day;
  dynamic get isHoliday => _isHoliday;
  dynamic get startTime => _startTime;
  dynamic get endTime => _endTime;
  dynamic get slotDuration => _slotDuration;
  String? get type => _type;
  AppointmentType? get appointmentType => _appointmentType;
  List<dynamic>? get scheduleSlots => _scheduleSlots;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['doctor_id'] = _doctorId;
    map['clinic_id'] = _clinicId;
    map['appointment_type_id'] = _appointmentTypeId;
    map['fee'] = _fee;
    map['day'] = _day;
    map['is_holiday'] = _isHoliday;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['slot_duration'] = _slotDuration;
    map['type'] = _type;
    if (_appointmentType != null) {
      map['appointment_type'] = _appointmentType?.toJson();
    }
    if (_scheduleSlots != null) {
      map['schedule_slots'] = _scheduleSlots?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

DoctorSettings doctorSettingsFromJson(String str) =>
    DoctorSettings.fromJson(json.decode(str));
String doctorSettingsToJson(DoctorSettings data) => json.encode(data.toJson());

class DoctorSettings {
  DoctorSettings({
    String? facebookUrl,
    String? twitterUrl,
    String? youtubeUrl,
    String? tiktokUrl,
    String? linkedinUrl,
    String? whatsappUrl,
    String? snapchatUrl,
    String? instagramUrl,
    String? pinterestUrl,
    String? youtubePlaylistLink,
    String? youtubeChannelLink,
    String? instagramProfileLink,
    String? instagramAccessToken,
    String? calendlyLink,
  }) {
    _facebookUrl = facebookUrl;
    _twitterUrl = twitterUrl;
    _youtubeUrl = youtubeUrl;
    _tiktokUrl = tiktokUrl;
    _linkedinUrl = linkedinUrl;
    _whatsappUrl = whatsappUrl;
    _snapchatUrl = snapchatUrl;
    _instagramUrl = instagramUrl;
    _pinterestUrl = pinterestUrl;
    _youtubePlaylistLink = youtubePlaylistLink;
    _youtubeChannelLink = youtubeChannelLink;
    _instagramProfileLink = instagramProfileLink;
    _instagramAccessToken = instagramAccessToken;
    _calendlyLink = calendlyLink;
  }

  DoctorSettings.fromJson(dynamic json) {
    _facebookUrl = json['facebook_url'];
    _twitterUrl = json['twitter_url'];
    _youtubeUrl = json['youtube_url'];
    _tiktokUrl = json['tiktok_url'];
    _linkedinUrl = json['linkedin_url'];
    _whatsappUrl = json['whatsapp_url'];
    _snapchatUrl = json['snapchat_url'];
    _instagramUrl = json['instagram_url'];
    _pinterestUrl = json['pinterest_url'];
    _youtubePlaylistLink = json['youtube_playlist_link'];
    _youtubeChannelLink = json['youtube_channel_link'];
    _instagramProfileLink = json['instagram_profile_link'];
    _instagramAccessToken = json['instagram_access_token'];
    _calendlyLink = json['calendly_link'];
  }
  String? _facebookUrl;
  String? _twitterUrl;
  String? _youtubeUrl;
  String? _tiktokUrl;
  String? _linkedinUrl;
  String? _whatsappUrl;
  String? _snapchatUrl;
  String? _instagramUrl;
  String? _pinterestUrl;
  String? _youtubePlaylistLink;
  String? _youtubeChannelLink;
  String? _instagramProfileLink;
  String? _instagramAccessToken;
  String? _calendlyLink;
  DoctorSettings copyWith({
    String? facebookUrl,
    String? twitterUrl,
    String? youtubeUrl,
    String? tiktokUrl,
    String? linkedinUrl,
    String? whatsappUrl,
    String? snapchatUrl,
    String? instagramUrl,
    String? pinterestUrl,
    String? youtubePlaylistLink,
    String? youtubeChannelLink,
    String? instagramProfileLink,
    String? instagramAccessToken,
    String? calendlyLink,
  }) =>
      DoctorSettings(
        facebookUrl: facebookUrl ?? _facebookUrl,
        twitterUrl: twitterUrl ?? _twitterUrl,
        youtubeUrl: youtubeUrl ?? _youtubeUrl,
        tiktokUrl: tiktokUrl ?? _tiktokUrl,
        linkedinUrl: linkedinUrl ?? _linkedinUrl,
        whatsappUrl: whatsappUrl ?? _whatsappUrl,
        snapchatUrl: snapchatUrl ?? _snapchatUrl,
        instagramUrl: instagramUrl ?? _instagramUrl,
        pinterestUrl: pinterestUrl ?? _pinterestUrl,
        youtubePlaylistLink: youtubePlaylistLink ?? _youtubePlaylistLink,
        youtubeChannelLink: youtubeChannelLink ?? _youtubeChannelLink,
        instagramProfileLink: instagramProfileLink ?? _instagramProfileLink,
        instagramAccessToken: instagramAccessToken ?? _instagramAccessToken,
        calendlyLink: calendlyLink ?? _calendlyLink,
      );
  String? get facebookUrl => _facebookUrl;
  String? get twitterUrl => _twitterUrl;
  String? get youtubeUrl => _youtubeUrl;
  String? get tiktokUrl => _tiktokUrl;
  String? get linkedinUrl => _linkedinUrl;
  String? get whatsappUrl => _whatsappUrl;
  String? get snapchatUrl => _snapchatUrl;
  String? get instagramUrl => _instagramUrl;
  String? get pinterestUrl => _pinterestUrl;
  String? get youtubePlaylistLink => _youtubePlaylistLink;
  String? get youtubeChannelLink => _youtubeChannelLink;
  String? get instagramProfileLink => _instagramProfileLink;
  String? get instagramAccessToken => _instagramAccessToken;
  String? get calendlyLink => _calendlyLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['facebook_url'] = _facebookUrl;
    map['twitter_url'] = _twitterUrl;
    map['youtube_url'] = _youtubeUrl;
    map['tiktok_url'] = _tiktokUrl;
    map['linkedin_url'] = _linkedinUrl;
    map['whatsapp_url'] = _whatsappUrl;
    map['snapchat_url'] = _snapchatUrl;
    map['instagram_url'] = _instagramUrl;
    map['pinterest_url'] = _pinterestUrl;
    map['youtube_playlist_link'] = _youtubePlaylistLink;
    map['youtube_channel_link'] = _youtubeChannelLink;
    map['instagram_profile_link'] = _instagramProfileLink;
    map['instagram_access_token'] = _instagramAccessToken;
    map['calendly_link'] = _calendlyLink;
    return map;
  }
}
