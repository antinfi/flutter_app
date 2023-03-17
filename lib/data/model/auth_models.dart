import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class IdentityRes {
  Identity? identity;
  int? clientId;

  IdentityRes({this.identity, this.clientId});

  factory IdentityRes.fromJson(Map<String, dynamic> json) => _$IdentityResFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityResToJson(this);
}

@JsonSerializable()
class Identity {
  int? id;
  String? code;

  Identity({this.id, this.code});

  factory Identity.fromJson(Map<String, dynamic> json) => _$IdentityFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityToJson(this);
}

@JsonSerializable()
class LoginRes {
  String? token;
  bool? didSetup;
  bool? hasGroup;
  bool? canTransfer;
  bool? noPassword;
  int? id;
  int? clientId;
  String? email;
  String? facebookId;
  String? facebookToken;
  String? facebookTokenExpire;
  String? deviceId;
  int? verifyCode;
  String? verifyExpire;
  bool? isPending;
  DateTime? passwordChangedAt;
  DateTime? lastLoginAt;
  String? version;
  String? deviceName;
  String? versionSmsSendStatus;
  int? synchronize;
  Client? client;

  LoginRes({
    this.token,
    this.didSetup,
    this.hasGroup,
    this.canTransfer,
    this.noPassword,
    this.id,
    this.clientId,
    this.email,
    this.facebookId,
    this.facebookToken,
    this.facebookTokenExpire,
    this.deviceId,
    this.verifyCode,
    this.verifyExpire,
    this.isPending,
    this.passwordChangedAt,
    this.lastLoginAt,
    this.version,
    this.deviceName,
    this.versionSmsSendStatus,
    this.synchronize,
    this.client,
  });

  factory LoginRes.fromJson(Map<String, dynamic> json) => _$LoginResFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResToJson(this);
}

@JsonSerializable()
class Client {
  int? id;
  int? identityTypeId;
  String? identityNumber;
  String? identityExpire;
  String? firstName;
  String? middleName;
  String? lastName;
  String? birthDate;
  String? gender;
  String? phone;
  int? defaultCountryId;
  int? residentCountryId;
  String? state;
  String? city;
  String? address;
  String? clientType;
  bool? didSetup;
  bool? isApproved;
  String? affiliateId;
  int? isChanged;
  String? dateOfIssue;
  String? birthPlace;
  Vip? vip;
  String? affiliate;
  List<AdminGroups>? adminGroups;
  List<Map>? transfers;

  Client({
    this.id,
    this.identityTypeId,
    this.identityNumber,
    this.identityExpire,
    this.firstName,
    this.middleName,
    this.lastName,
    this.birthDate,
    this.gender,
    this.phone,
    this.defaultCountryId,
    this.residentCountryId,
    this.state,
    this.city,
    this.address,
    this.clientType,
    this.didSetup,
    this.isApproved,
    this.affiliateId,
    this.isChanged,
    this.dateOfIssue,
    this.birthPlace,
    this.vip,
    this.affiliate,
    this.adminGroups,
    this.transfers,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

@JsonSerializable()
class Vip {
  int? id;
  int? number;
  int? credits;

  Vip({
    this.id,
    this.number,
    this.credits,
  });

  factory Vip.fromJson(Map<String, dynamic> json) => _$VipFromJson(json);

  Map<String, dynamic> toJson() => _$VipToJson(this);
}

@JsonSerializable()
class AdminGroups {
  int? id;
  String? name;
  int? adminClientId;
  List<Map>? memberClients;

  AdminGroups({
    this.id,
    this.name,
    this.adminClientId,
    this.memberClients,
  });

  factory AdminGroups.fromJson(Map<String, dynamic> json) => _$AdminGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminGroupsToJson(this);
}

@JsonSerializable()
class SignupRes {
  String? token;

  SignupRes({
    this.token,
  });

  factory SignupRes.fromJson(Map<String, dynamic> json) => _$SignupResFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResToJson(this);
}
