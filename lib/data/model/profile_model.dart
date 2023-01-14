class ProfileModel {
  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String email;
  late final Null emailVerifiedAt;
  late final Null twoFactorSecret;
  late final Null twoFactorRecoveryCodes;
  late final String createdAt;
  late final String updatedAt;

  ProfileModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = null;
    twoFactorSecret = null;
    twoFactorRecoveryCodes = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['two_factor_secret'] = twoFactorSecret;
    _data['two_factor_recovery_codes'] = twoFactorRecoveryCodes;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}