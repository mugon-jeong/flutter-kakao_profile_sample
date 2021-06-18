class UserModel {
  String? uid;
  String? docId;
  String? name;
  String? discription;
  String? avatarUrl;
  String? backgroundUrl;
  // File? avatarFile;
  // File? backgroundFile;
  DateTime? lastLoginTime;
  DateTime? createdTime;

  UserModel({
    this.uid,
    this.docId,
    this.name,
    this.discription,
    this.backgroundUrl,
    this.avatarUrl,
    this.createdTime,
    this.lastLoginTime,
  });

  UserModel.clone(UserModel user)
      : this(
          uid: user.uid,
          docId: user.docId,
          name: user.name,
          discription: user.discription,
          avatarUrl: user.avatarUrl,
          backgroundUrl: user.backgroundUrl,
          lastLoginTime: user.lastLoginTime,
          createdTime: user.createdTime,
        );
}
