class UserModel {
  String? uid;
  String? username;
  String? phone;
  String? address;
  String? token;
  String? image;
  bool? isAdmin;
  bool ? isMale;


  UserModel(
      {required this.uid,
        required this.username,
        required this.phone,
        required this.address,
        required this.token,
        required this.image,
        required this.isAdmin,
        required this.isMale,
        });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ;
    username = json['username'];
    phone = json['phone'];
    address = json['address'];
    token = json['token'];
    isMale = json['isMale'];
    image = json['image'];
    isAdmin = json['isAdmin'];

  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "username": username,
      "phone": phone,
      "address": address,
      "token": token,
      "image": image,
      "isAdmin": isAdmin,
      "isMale": isMale,

    };
  }
}
