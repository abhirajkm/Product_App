class OrderModel {
  bool paymentDone;
  String sId;
  String orderId;
  int orderType;
  String cart;
  String user;
  String status;
  List<StatusHistory> statusHistory;
  Address address;
  String created;
  String total;
  int iV;

  OrderModel(
      {this.paymentDone,
        this.sId,
        this.orderId,
        this.orderType,
        this.cart,
        this.user,
        this.status,
        this.statusHistory,
        this.address,
        this.created,
        this.total,
        this.iV});

  OrderModel.fromJson(Map<String, dynamic> json) {
    paymentDone = json['paymentDone'];
    sId = json['_id'];
    orderId = json['orderId'];
    orderType = json['orderType'];
    cart = json['cart'];
    user = json['user'];
    status = json['status'];
    if (json['statusHistory'] != null) {
      statusHistory = new List<StatusHistory>();
      json['statusHistory'].forEach((v) {
        statusHistory.add(new StatusHistory.fromJson(v));
      });
    }
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    created = json['created'];
    total = json['total'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentDone'] = this.paymentDone;
    data['_id'] = this.sId;
    data['orderId'] = this.orderId;
    data['orderType'] = this.orderType;
    data['cart'] = this.cart;
    data['user'] = this.user;
    data['status'] = this.status;
    if (this.statusHistory != null) {
      data['statusHistory'] =
          this.statusHistory.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['created'] = this.created;
    data['total'] = this.total;
    data['__v'] = this.iV;
    return data;
  }
}

class StatusHistory {
  String sId;
  String status;
  String addedOn;

  StatusHistory({this.sId, this.status, this.addedOn});

  StatusHistory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    addedOn = json['added_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['added_on'] = this.addedOn;
    return data;
  }
}

class Address {
  String name;
  String addressLine1;
  String addressLine2;
  String pincode;
  String landmark;
  String phone;

  Address(
      {this.name,
        this.addressLine1,
        this.addressLine2,
        this.pincode,
        this.landmark,
        this.phone});

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['phone'] = this.phone;
    return data;
  }
}
