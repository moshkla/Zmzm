class CategoriesModel {
  bool? status;

  CategoriesModelData? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesModelData.fromJson(json['data']);
  }
}

class CategoriesModelData {
  int? current_page;
  List<DataModel>? data;

  CategoriesModelData.fromJson(Map<String, dynamic> json) {
    current_page=json['current_page'];
    data=(json['data'] as List)
        .map((e) =>
        DataModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
