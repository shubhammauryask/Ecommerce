class CategoryModel {
  String? sId;
  String? title;
  String? description;
  String? updatedOn;
  String? createdOn;
  int? iV;

  CategoryModel(
  {this.sId,
  this.title,
  this.description,
  this.updatedOn,
  this.createdOn,
  this.iV});

  CategoryModel.fromJson(Map<String, dynamic> json) {
  sId = json['_id'];
  title = json['title'];
  description = json['description'];
  updatedOn = json['updatedOn'];
  createdOn = json['createdOn'];
  iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['_id'] = this.sId;
  data['title'] = this.title;
  data['description'] = this.description;
  data['updatedOn'] = this.updatedOn;
  data['createdOn'] = this.createdOn;
  data['__v'] = this.iV;
  return data;
  }
}
