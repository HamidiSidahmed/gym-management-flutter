import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_sof/model/member.dart';
import 'package:hive_flutter/adapters.dart';
import 'view/intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Hive.initFlutter();
  Hive.registerAdapter(MemberAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ScreenUtilInit(
      designSize: const Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: IntroPage(),
        );
      }));
}
