class RegisterModel {
  RegisterModel({
    required this.data,
    required this.token,
  });
  late final Data data;
  late final String token;

  RegisterModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['token'] = token;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
  });
  late final int id;
  late final String name;
  late final String email;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    return _data;
  }
}