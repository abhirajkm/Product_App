class Userdetails {
  bool success;
  String token;
  User user;

  Userdetails({this.success, this.token, this.user});

  Userdetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String sId;
  String name;
  String email;
  String phone;
  String password;
  List<Address> address;
  String district;
  String locality;
  String localityType;
  String state;
  String thumbnail;

  User(
      {this.sId,
        this.name,
        this.email,
        this.phone,
        this.password,
        this.address,
        this.district,
        this.locality,
        this.localityType,
        this.state,
        this.thumbnail});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    if (json['address'] != null) {
      address = new List<Address>();
      json['address'].forEach((v) {
        address.add(new Address.fromJson(v));
      });
    }
    district = json['district'];
    locality = json['locality'];
    localityType = json['locality_type'];
    state = json['state'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    if (this.address != null) {
      data['address'] = this.address.map((v) => v.toJson()).toList();
    }
    data['district'] = this.district;
    data['locality'] = this.locality;
    data['locality_type'] = this.localityType;
    data['state'] = this.state;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class Address {
  String sId;
  String name;
  String addressLine1;
  String addressLine2;
  String pincode;
  String landmark;
  String phone;

  Address(
      {this.sId,
        this.name,
        this.addressLine1,
        this.addressLine2,
        this.pincode,
        this.landmark,
        this.phone});

  Address.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['phone'] = this.phone;
    return data;
  }
}
