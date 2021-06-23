import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:kakao_sample_profile/src/model/user_model.dart';
import 'package:kakao_sample_profile/src/repository/firebase_user_repository.dart';
import 'package:kakao_sample_profile/src/repository/firestorage_repository.dart';

import 'image_crop_controller.dart';

enum ProfileImageType { THUMBNAIL, BACKGROUND }

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  RxBool isEditMyProfile = false.obs;
  UserModel originMyProfile = UserModel();
  Rx<UserModel> myProfile = UserModel().obs;
  FirestorageRepository _firestorageRepository = FirestorageRepository();

  void authStateChanges(User firebaseUser) async {
    UserModel? userModel =
        await FirebaseUserRepository.findUserByUid(firebaseUser.uid);
    if (userModel != null) {
      originMyProfile = userModel;
      FirebaseUserRepository.updateLastLoginDate(
          userModel.docId as String, DateTime.now());
    } else {
      originMyProfile = UserModel(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName,
        avatarUrl: firebaseUser.photoURL,
        createdTime: DateTime.now(),
        lastLoginTime: DateTime.now(),
      );
      String docId = await FirebaseUserRepository.singup(originMyProfile);
      originMyProfile.docId = docId;
    }
    myProfile(UserModel.clone(originMyProfile));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    isEditMyProfile(false);
    // myProfile에는 originMyProfile의 주소값이 들어가고 업데이트할때 myProfile의 데이터가 업데이트되는 것이 아니라 origin이 업데이트됨
    // 그렇기에 clone이 필
    // myProfile(originMyProfile);
    // myProfile(UserModel.clone(originMyProfile));
    super.onInit();
  }

  void toggleEditProfile() {
    isEditMyProfile(!isEditMyProfile.value);
  }

  void rollback() {
    myProfile.value.initImageFile();
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
    File? file = await ImageCropController.to.selectImage(type);
    switch (type) {
      case ProfileImageType.THUMBNAIL:
        myProfile.update((val) {
          val!.avatarFile = file;
        });

        break;
      case ProfileImageType.BACKGROUND:
        myProfile.update((val) {
          val!.backgroundFile = file;
        });
        break;
    }
  }

  void _updateProfileImageUrl(String downloadUrl) {
    originMyProfile.avatarUrl = downloadUrl;
    myProfile.update((user) => user!.avatarUrl = downloadUrl);
  }

  void _updateBackgroundImageUrl(String downloadUrl) {
    originMyProfile.backgroundUrl = downloadUrl;
    myProfile.update((user) => user!.backgroundUrl = downloadUrl);
  }

  void save() {
    originMyProfile = myProfile.value;

    //crop image upload
    if (originMyProfile.avatarFile != null) {
      UploadTask task = _firestorageRepository.uploadImageFile(
          originMyProfile.uid as String,
          "profile",
          originMyProfile.avatarFile as File);
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes) {
          String downloadUrl = await event.ref.getDownloadURL();
          _updateProfileImageUrl(downloadUrl);
          FirebaseUserRepository.updateImageUrl(
              originMyProfile.docId as String, downloadUrl, "avatar_url");
        }
      });
    }

    // background image upload
    if (originMyProfile.backgroundFile != null) {
      UploadTask task = _firestorageRepository.uploadImageFile(
          originMyProfile.uid as String,
          "background",
          originMyProfile.backgroundFile as File);
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes) {
          String downloadUrl = await event.ref.getDownloadURL();
          _updateBackgroundImageUrl(downloadUrl);
          FirebaseUserRepository.updateImageUrl(
              originMyProfile.docId as String, downloadUrl, "background_url");
        }
      });
    }

    FirebaseUserRepository.updateData(
        originMyProfile.docId as String, originMyProfile);
    toggleEditProfile();
  }
}
