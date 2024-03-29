import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gym_sof/model/member.dart';
import 'package:hive/hive.dart';

class Data extends GetxController {
  late Box myBox;
  late Member member;

  @override
  void onInit() async {
    myBox = await Hive.openBox<Member>("MemberBox");
    super.onInit();
  }

  void push_data(Member added_member) async {
    try {
      await myBox.put(added_member.phone, added_member);
      update();
    } catch (e) {
      if (kDebugMode) {
        print('debug: $e');
      }
    }
  }
  
}
