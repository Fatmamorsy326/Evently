class UserModel {
  String userId;
  String userName;
  String email;
  static UserModel? currentUser;
  UserModel({required this.userId,required this.email ,required this.userName});
  Map<String,dynamic> toJson(){
    return {
      "id" : userId,
      "email":email,
      "name":userName,
    };
  }
  UserModel.fromJson(Map<String,dynamic> json) : this(userId: json["id"],email: json["email"],userName: json["name"]);
}