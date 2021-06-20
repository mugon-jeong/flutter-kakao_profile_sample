import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:kakao_sample_profile/src/app.dart';
import 'package:kakao_sample_profile/src/controller/image_crop_controller.dart';
import 'package:kakao_sample_profile/src/controller/profile_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ImageCropper',
      theme: ThemeData.light().copyWith(primaryColor: Colors.deepOrange),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => ProfileController());
        Get.lazyPut(() => ImageCropController());
      }),
      home: App(),
    );
  }
}
