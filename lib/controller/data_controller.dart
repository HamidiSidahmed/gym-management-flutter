import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gym_sof/model/member.dart';
import 'package:hive/hive.dart';

class Data extends GetxController {
  late Box myBox;
  late Member member;
  late List<Member> filtered_data;
  final limit = 5;
  int length = 0;
  int count = 0;
  @override
  void onInit() async {
    filtered_data = [];
    myBox = await Hive.openBox<Member>("MemberBox");
    filtered_data = myBox.values.toList().cast<Member>();
    if (myBox.length > limit) {
      length = 5;
    } else {
      length = myBox.length;
    }
    print(length);
    super.onInit();
  }

  @override
  void onClose() {
    myBox.close();
    super.onClose();
  }

  void push_data(Member added_member) async {
    try {
      await myBox.put(added_member.phone, added_member);
      filtered_data = myBox.values.toList().cast<Member>();
      if (kDebugMode) {
        print('added sucssefully');
      }
      update();
    } catch (e) {
      if (kDebugMode) {
        print('debug: $e');
      }
    }
  }

  Future<Member> get_data(int index) async {
    return await myBox.getAt(index);
  }

  void delete_data(String phone) async {
    await myBox.delete(phone);
    filtered_data.removeWhere((element) => element.phone == phone);
    filtered_data.length > length
        ? length = limit
        : length = filtered_data.length;
    update();
  }

  void update_lenght() {
    if (length >= filtered_data.length) {
      length = filtered_data.length;
    } else if (length + 5 >= filtered_data.length) {
      length = filtered_data.length;
    } else {
      length += 5;
    }
    print(length);
    update();
  }

  void filter_data(String filter) {
    if (filter == "") {
      filtered_data = myBox.values.toList().cast<Member>();
      length = 5;
    } else {
      filtered_data = myBox.values
          .where((element) =>
              element.name.toLowerCase().contains(filter.toLowerCase()))
          .toList()
          .cast<Member>();
    }
    if (filtered_data.length > 5) {
      length = 5;
    } else {
      length = filtered_data.length;
    }

    update();
  }
}
