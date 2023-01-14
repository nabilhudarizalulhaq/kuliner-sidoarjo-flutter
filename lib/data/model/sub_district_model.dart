class SubDistrictModel {
  SubDistrictModel({
    required this.data,
  });
  late final List<Data> data;

  SubDistrictModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.slug,
    required this.placesCount,
  });
  late final int id;
  late final String name;
  late final String slug;
  late final String placesCount;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    placesCount = json['places_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['places_count'] = placesCount;
    return _data;
  }
}