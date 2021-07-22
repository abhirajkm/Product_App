class CartModel {
  bool featured;
  String sId;
  String name;
  String code;
  String unit;
  String featuredImage;
  String category;
  int mrp;
  int sellingPrice;
  int quantity;
  String total;
  String description;

  CartModel(
      {this.featured,
        this.sId,
        this.name,
        this.code,
        this.unit,
        this.featuredImage,
        this.category,
        this.mrp,
        this.sellingPrice,
        this.quantity,
        this.total,
        this.description});

  CartModel.fromJson(Map<String, dynamic> json) {
    featured = json['featured'];
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    unit = json['unit'];
    featuredImage = json['featured_image'];
    category = json['category'];
    mrp = json['mrp'];
    sellingPrice = json['selling_price'];
    quantity = json['quantity'];
    total = json['total'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['featured'] = this.featured;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['unit'] = this.unit;
    data['featured_image'] = this.featuredImage;
    data['category'] = this.category;
    data['mrp'] = this.mrp;
    data['selling_price'] = this.sellingPrice;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['description'] = this.description;
    return data;
  }
}
