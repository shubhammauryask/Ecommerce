class UserModel {
  String? sId;
  String? fullName;
  String? email;
  String? password;
  String? phoneNumber;
  String? city;
  String? state;
  String? address;
  int? profileProgress;
  String? id;
  String? updatedOn;
  String? createdOn;

  UserModel(
      {this.sId,
        this.fullName,
        this.email,
        this.password,
        this.phoneNumber,
        this.city,
        this.state,
        this.address,
        this.profileProgress,
        this.id,
        this.updatedOn,
        this.createdOn});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    profileProgress = json['profileProgress'];
    id = json['id'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address'] = this.address;
    data['profileProgress'] = this.profileProgress;
    data['id'] = this.id;
    data['updatedOn'] = this.updatedOn;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
