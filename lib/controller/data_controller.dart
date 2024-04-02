import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_sof/model/member.dart';
import 'package:gym_sof/view/home_page.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class Data extends GetxController with GetSingleTickerProviderStateMixin {
  late Box myBox;
  late Member member;
  List<Member> filtered_data = [];
  List<Member> filtered_active_data = [];
  List<Member> filtered_exp_data = [];
  List<Member> filtered_blocked_data = [];
  bool show=false;
  XFile? imagepicker;
  final limit = 5;
  int length = 0;
  int index = 0;
  int length_active = 0;
  int length_exp = 0;
  int length_blocked = 0;
  var compressedfile;
  int count = 0;

  late TabController tab_controller;
  ScrollController scrollController = ScrollController();
  @override
  void onInit() async {
    tab_controller = TabController(length: 4, vsync: this);
    myBox = await Hive.openBox<Member>("MemberBox");
    filtered_data = myBox.values.toList().cast<Member>();
    filtered_active_data = myBox.values
        .where((element) =>
            DateTime.now().isAfter(element.end_date) == false &&
            element.blocked == false)
        .toList()
        .cast<Member>();
    filtered_exp_data = myBox.values
        .where((element) =>
            DateTime.now().isAfter(element.end_date) == true &&
            element.blocked == false)
        .toList()
        .cast<Member>();
    filtered_blocked_data = myBox.values
        .where((element) => element.blocked == true)
        .toList()
        .cast<Member>();

    myBox.length > limit ? length = limit : length = myBox.length;

    filtered_active_data.length > limit
        ? length_active = limit
        : length_active = filtered_active_data.length;

    filtered_exp_data.length > limit
        ? length_exp = limit
        : length_exp = filtered_exp_data.length;

    filtered_blocked_data.length > limit
        ? length_blocked = limit
        : length_blocked = filtered_blocked_data.length;

  
    scrollController.addListener(
      () {
        print(scrollController.position.pixels);
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (HomePage.index == 0) {
            length = update_lenght(filtered_data.length, length);
          } else if (HomePage.index == 1) {
            length_active =
                update_lenght(filtered_active_data.length, length_active);
          } else if (HomePage.index == 2) {
            length_exp = update_lenght(filtered_exp_data.length, length_exp);
          } else {
            length_blocked =
                update_lenght(filtered_blocked_data.length, length_blocked);
          }
        }
      },
    );
    print(length);
    super.onInit();
  }

  @override
  void onClose() {
    myBox.close();
    scrollController.removeListener(() {});
    tab_controller.removeListener(() {});
    super.onClose();
  }

  Future<void> push_data(Member added_member) async {
    try {
      await myBox.put(added_member.phone, added_member);
      filtered_data = myBox.values.toList().cast<Member>();
      filtered_active_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .cast<Member>();
      filtered_exp_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .cast<Member>();
      filtered_blocked_data = myBox.values
          .where((element) => element.blocked == true)
          .toList()
          .cast<Member>();
      if (kDebugMode) {
        print('added sucssefully');
      }
      myBox.length > limit ? length = limit : length = myBox.length;

      filtered_active_data.length > limit
          ? length_active = limit
          : length_active = filtered_active_data.length;

      filtered_exp_data.length > limit
          ? length_exp = limit
          : length_exp = filtered_exp_data.length;

      filtered_blocked_data.length > limit
          ? length_blocked = limit
          : length_blocked = filtered_blocked_data.length;

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

  Future<void> delete_data(String phone) async {
    int place = 0;
    place = await places(phone);
   await deleteFile(myBox.getAt(place).image);
    await myBox.deleteAt(place);
    filtered_data.removeWhere((element) => element.phone == phone);
    filtered_active_data.removeWhere((element) => element.phone == phone);
    filtered_exp_data.removeWhere((element) => element.phone == phone);
    filtered_blocked_data.removeWhere((element) => element.phone == phone);

    filtered_data.length > length
        ? length = limit
        : length = filtered_data.length;

    filtered_active_data.length > length_active
        ? length_active = limit
        : length_active = filtered_active_data.length;

    filtered_exp_data.length > length_exp
        ? length_exp = limit
        : length_exp = filtered_exp_data.length;

    filtered_blocked_data.length > length_blocked
        ? length_blocked = limit
        : length_blocked = filtered_blocked_data.length;
    update();
  }

  Future<void> block_member(Member blocked_member, String phone) async {
    try {
      int place = 0;
      place = await places(phone);
      await myBox.putAt(place, blocked_member);
      filter_data(HomePage.filters);
      filtered_active_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .cast<Member>();
      filtered_exp_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .cast<Member>();
      filtered_blocked_data = myBox.values
          .where((element) => element.blocked == true)
          .toList()
          .cast<Member>();

      filtered_data.length > length
          ? length = limit
          : length = filtered_data.length;
      filtered_active_data.length > limit
          ? length_active = limit
          : length_active = filtered_active_data.length;

      filtered_exp_data.length > limit
          ? length_exp = limit
          : length_exp = filtered_exp_data.length;

      filtered_blocked_data.length > limit
          ? length_blocked = limit
          : length_blocked = filtered_blocked_data.length;

      if (kDebugMode) {
        print('added sucssefully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('debug: $e');
      }
    }
    update();
  }

  Future<void> update_member(Member member, String phone,String filePath) async {
    int place = 0;
    await deleteFile(filePath);
    place = await places(phone);
    await myBox.putAt(place, member);
    filter_data(HomePage.filters);
    filtered_active_data = myBox.values
        .where((element) =>
            DateTime.now().isAfter(element.end_date) == false &&
            element.blocked == false)
        .toList()
        .cast<Member>();
    filtered_exp_data = myBox.values
        .where((element) =>
            DateTime.now().isAfter(element.end_date) == true &&
            element.blocked == false)
        .toList()
        .cast<Member>();
    filtered_blocked_data = myBox.values
        .where((element) => element.blocked == true)
        .toList()
        .cast<Member>();

    filtered_data.length > length
        ? length = limit
        : length = filtered_data.length;
    filtered_active_data.length > limit
        ? length_active = limit
        : length_active = filtered_active_data.length;

    filtered_exp_data.length > limit
        ? length_exp = limit
        : length_exp = filtered_exp_data.length;

    filtered_blocked_data.length > limit
        ? length_blocked = limit
        : length_blocked = filtered_blocked_data.length;
    update();
  }

  int update_lenght(int list_length, int updated_length) {
    if (updated_length >= list_length) {
      updated_length = list_length;
    } else if (updated_length + 5 >= list_length) {
      updated_length = list_length;
    } else {
      updated_length += 5;
    }
    print(updated_length);
    update();
    return updated_length;
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

  Future<int> places(String phone) async {
    int current = 0;

    for (int i = 0; i < myBox.length; i++) {
      if (myBox.getAt(i).phone == phone) {
        current = i;
      }
    }
    return current;
  }

  Future takephoto(ImageSource source) async {
    try {
      imagepicker = await ImagePicker().pickImage(source: source);
    } catch (e) {
      print(e);
    }
    update();
  }

  Future compress_image() async {
    var result = await FlutterImageCompress.compressWithFile(
      File(imagepicker!.path).absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    return result;
  }
  Future<Directory> _getDirectory() async {
      //This is the name of the folder where the backup is stored
      Directory? newDirectory = await getExternalStorageDirectory();
      if (await newDirectory!.exists() == false) {
        return newDirectory.create(recursive: true);
      }
      return newDirectory;
    }
  Future compress() async {
    Directory dir = await _getDirectory();
    if (imagepicker == null) {
      return null;
    } else {
      var original = File(imagepicker!.path);
      compressedfile = await FlutterImageCompress.compressAndGetFile(
          original.path, '${dir.path}${DateTime.now()}.jpg',
          minHeight: 400, minWidth: 400, quality: 80);
      if (compressedfile != null) {}
    }
    update();
  }
  ImageProvider display_image(String? path){
    if(path==""){
      return const AssetImage("assets/25.png");
    }
    else {return FileImage(File(path!));
    }
  }
 Future<void> deleteFile(String filePath)async {
  try {
    File file = File(filePath);
    if (file.existsSync()) {
      file.deleteSync();
      print('File deleted successfully.');
    } else {
      print('File does not exist at the specified path.');
    }
  } catch (e) {
    print('Error deleting file: $e');
  }
}
}
