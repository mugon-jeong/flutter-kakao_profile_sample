import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_sample_profile/src/controller/profile_controller.dart';

class Profile extends GetView<ProfileController> {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3f3f3f),
      body: Container(
        child: Stack(
          children: [
            _backgoundImage(),
            _header(),
            _footer(),
            _myProfile(),
          ],
        ),
      ),
    );
  }

  Widget _myProfile() {
    return Positioned(
      bottom: 120,
      left: 0,
      right: 0,
      child: Obx(
        () => Container(
          height: 220,
          child: Column(
            children: [
              _profileImage(),
              controller.isEditMyProfile.value
                  ? _editProfileInfo()
                  : _profileInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editProfileInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          _partProfileInfo('개발하는 남자', () {}),
          _partProfileInfo('구독과 좋아요', () {}),
        ],
      ),
    );
  }

  Widget _partProfileInfo(String value, Function ontap) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Stack(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.white,
              width: 1,
            ))),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ),
          Positioned(
              right: 0,
              bottom: 15,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 18,
              ))
        ],
      ),
    );
  }

  Widget _profileInfo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            '개발하는 남자',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
        Text(
          '구독과 좋아요',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ],
    );
  }

  Widget _profileImage() {
    return Container(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                width: 100,
                height: 100,
                child: Image.network(
                  'https://i.stack.imgur.com/l60Hf.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          controller.isEditMyProfile.value
              ? Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(Icons.camera_alt),
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }

  Widget _oneButton(IconData icon, String title, Function ontap) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return Obx(
      () => controller.isEditMyProfile.value
          ? Container()
          : Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _oneButton(Icons.chat_bubble, '나와의 채팅', () {}),
                    _oneButton(Icons.edit, '프로필 편집', () {
                      controller.toggleEditProfile();
                    }),
                    _oneButton(Icons.chat_bubble_outline, '카카오스토리', () {}),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _header() {
    return Positioned(
      //  디바이스별 상태표시줄 높이만큼 상단을 띄워줌
      top: Get.mediaQuery.padding.top,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                controller.toggleEditProfile();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                  Text(
                    '프로필 편집',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print("프로필 편집 저장");
              },
              child: Text(
                '완료',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backgoundImage() {
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      left: 0,
      child: GestureDetector(
        child: Container(
          color: Colors.transparent,
        ),
        onTap: () {
          print("change my backgroundImage");
        },
      ),
    );
  }
}
