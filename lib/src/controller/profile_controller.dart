import 'dart:io';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:kakao_sample_profile/src/model/user_model.dart';

import 'image_crop_controller.dart';

enum ProfileImageType { THUMBNAIL, BACKGROUND }

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;
  UserModel originMyProfile = UserModel(
    name: "개발하는 남자",
    discription: "구독과 좋아요",
  );
  Rx<UserModel> myProfile = UserModel().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    isEditMyProfile(false);
    // myProfile에는 originMyProfile의 주소값이 들어가고 업데이트할때 myProfile의 데이터가 업데이트되는 것이 아니라 origin이 업데이트됨
    // 그렇기에 clone이 필
    // myProfile(originMyProfile);
    myProfile(UserModel.clone(originMyProfile));
    super.onInit();
  }

  void toggleEditProfile() {
    isEditMyProfile(!isEditMyProfile.value);
  }

  void rollback() {
    myProfile(originMyProfile);
    toggleEditProfile();
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

  Future<void> pickImage(ProfileImageType type) async {
    if (!isEditMyProfile.value) return;
    switch (type) {
      case ProfileImageType.THUMBNAIL:
        File file = await ImageCropController.to.selectImage();
        myProfile.update((val) {
          val!.avatarFile = file;
        });

        break;
      case ProfileImageType.BACKGROUND:
        File file = await ImageCropController.to.selectImage();
        myProfile.update((val) {
          val!.backgroundFile = file;
        });
        break;
    }
  }
}
