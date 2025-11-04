class UserModel {
  String userId;
  String userName;
  String email;
  static UserModel? currentUser;
  UserModel({required this.userId,required this.email ,required this.userName});
}