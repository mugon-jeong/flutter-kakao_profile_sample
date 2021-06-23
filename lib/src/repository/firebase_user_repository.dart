import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kakao_sample_profile/src/model/user_model.dart';

class FirebaseUserRepository {
  static Future<String> singup(UserModel user) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    // DocumentReference 의 id를 받아와야함, id를 통해서 업데이트 하기 위해
    DocumentReference drf = await users.add(user.toMap());
    return drf.id;
  }

  static Future<UserModel?> findUserByUid(String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    QuerySnapshot data = await users.where("uid", isEqualTo: uid).get();
    if (data.size == 0) {
      return null;
    } else {
      return UserModel.fromJson(
          data.docs[0].data() as Map<String, dynamic>, data.docs[0].id);
    }
  }

  static void updateLastLoginDate(String docId, DateTime time) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"last_login_time": time});
  }
}
