class ItemModel {

  String? title;
  String? image;

  ItemModel({this.title, this.image});

// factory MovieResponse.fromJson(Map<String, dynamic> map) {
  //   var listResult = (map['results'] as List<dynamic>).map((list) =>
  //       MovieModel.fromJson(list)).toList();
  //   return MovieResponse(totalPages: map['total_pages'], results: listResult);
  // }

  @override
  String toString() {
    return 'ItemModel{title: $title, image: $image}';
  }

}
