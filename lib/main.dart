import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_sof/model/member.dart';
import 'package:gym_sof/view/home_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'view/intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Hive.initFlutter();
  Hive.registerAdapter(MemberAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyACX3AqIRoJwL-eV5VhDiOBJWsIq7zeArg",
          appId: "1:873812168823:android:20129bdbc96a72d0c53672",
          messagingSenderId: "873812168823",
          projectId: "gym-sof"));
  runApp(ScreenUtilInit(
      designSize: const Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: IntroPage(),
        );
      }));
}
