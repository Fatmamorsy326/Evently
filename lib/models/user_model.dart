class UserModel {
  String userId;
  String userName;
  String email;
  List<String> favEventsIds;
  static UserModel? currentUser;
  UserModel({required this.userId,required this.email ,required this.userName,required this.favEventsIds});
  Map<String,dynamic> toJson(){
    return {
      "id" : userId,
      "email":email,
      "name":userName,
      "favEventsIds":favEventsIds
    };
  }
  UserModel.fromJson(Map<String,dynamic> json) : this(userId: json["id"],email: json["email"],userName: json["name"],favEventsIds: (json["favEventsIds"] as List<dynamic>).map((obj) => obj.toString(),).toList());
}