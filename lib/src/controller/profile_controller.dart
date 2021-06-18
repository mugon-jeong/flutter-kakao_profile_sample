import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:kakao_sample_profile/src/model/user_model.dart';

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;
  Rx<UserModel> myProfile = UserModel(
    name: "개발하는 남자",
    discription: "구독과 좋아요",
  ).obs;
  @override
  void onInit() {
    // TODO: implement onInit
    isEditMyProfile(false);
    super.onInit();
  }

  void toggleEditProfile() {
    isEditMyProfile(!isEditMyProfile.value);
  }

  void updateName(String updateName) {
    myProfile.update((my) {
      my!.name = updateName;
    });
  }

  void updateDiscription(String updateDiscription) {
    myProfile.update((my) {
      my!.discription = updateDiscription;
    });
  }
}
