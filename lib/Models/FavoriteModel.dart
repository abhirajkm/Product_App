class FavoriteModel {
  String sId;
  String user;
  List<Products> products;

  FavoriteModel({this.sId, this.user, this.products});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String sId;
  Product product;
  String addedOn;

  Products({this.sId, this.product, this.addedOn});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    addedOn = json['added_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['added_on'] = this.addedOn;
    return data;
  }
}

class Product {
  bool featured;
  String sId;
  String name;
  String code;
  String unit;
  String featuredImage;
  String category;
  int mrp;
  int sellingPrice;
  String description;
  bool available;
  List<Stocks> stocks;
  int iV;
  Null details;
  int stockLeft;
  int stockTotal;

  Product(
      {this.featured,
        this.sId,
        this.name,
        this.code,
        this.unit,
        this.featuredImage,
        this.category,
        this.mrp,
        this.sellingPrice,
        this.description,
        this.available,
        this.stocks,
        this.iV,
        this.details,
        this.stockLeft,
        this.stockTotal});

  Product.fromJson(Map<String, dynamic> json) {
    featured = json['featured'];
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    unit = json['unit'];
    featuredImage = json['featured_image'];
    category = json['category'];
    mrp = json['mrp'];
    sellingPrice = json['selling_price'];
    description = json['description'];
    available = json['available'];
    if (json['stocks'] != null) {
      stocks = new List<Stocks>();
      json['stocks'].forEach((v) {
        stocks.add(new Stocks.fromJson(v));
      });
    }
    iV = json['__v'];
    details = json['details'];
    stockLeft = json['stock_left'];
    stockTotal = json['stock_total'];
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
    data['description'] = this.description;
    data['available'] = this.available;
    if (this.stocks != null) {
      data['stocks'] = this.stocks.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    data['details'] = this.details;
    data['stock_left'] = this.stockLeft;
    data['stock_total'] = this.stockTotal;
    return data;
  }
}

class Stocks {
  String sId;
  int stock;
  String addedOn;

  Stocks({this.sId, this.stock, this.addedOn});

  Stocks.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    stock = json['stock'];
    addedOn = json['added_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['stock'] = this.stock;
    data['added_on'] = this.addedOn;
    return data;
  }
}
