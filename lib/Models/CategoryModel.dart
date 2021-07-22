class CategoryModel {
  String sId;
  String text;
  String thumbnail;

  CategoryModel({this.sId, this.text, this.thumbnail});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['text'] = this.text;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

