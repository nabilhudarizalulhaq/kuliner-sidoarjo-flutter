class PlaceDetailModel {
  PlaceDetailModel({
    required this.data,
  });
  late final Data data;

  PlaceDetailModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.subDistrict,
  });
  late final int id;
  late final String name;
  late final String description;
  late final String address;
  late final String phone;
  late final String image;
  late final String latitude;
  late final String longitude;
  late final SubDistrict subDistrict;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    phone = json['phone'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    subDistrict = SubDistrict.fromJson(json['sub_district']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['address'] = address;
    _data['phone'] = phone;
    _data['image'] = image;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['sub_district'] = subDistrict.toJson();
    return _data;
  }
}

class SubDistrict {
  SubDistrict({
    required this.id,
    required this.name,
    required this.slug,
  });
  late final int id;
  late final String name;
  late final String slug;

  SubDistrict.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    return _data;
  }
}