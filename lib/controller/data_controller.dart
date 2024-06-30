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

class Data extends GetxController {
  late Box myBox;
  late Member member;
  List<Member> filtered_data = [];
  List<Member> filtered_active_data = [];
  List<Member> filtered_exp_data = [];
  List<Member> filtered_blocked_data = [];
  bool show = false;
  late int all_filter;
  int starting_active = 0;
  int starting_blocked = 0;
  int ending_blocked = 10;
  int starting_expired = 0;
  int ending_expired = 10;
  int end_active = 10;
  int starting = 0;
  int ending = 10;
  XFile? imagepicker;
  int index = 0;
  int length_active = 0;
  int length_exp = 0;
  int length_blocked = 0;
  var compressedfile;
  int count = 0;
  DateTime now = DateTime.now();
  ScrollController scrollController = ScrollController();
  @override
  void onInit() async {
    myBox = await Hive.openBox<Member>("MemberBox");
    start();

    scrollController.addListener(
      () async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          filter_data(HomePage.filters);
          await Future.delayed(Duration(milliseconds: 50));
          await scrollController.animateTo(
              scrollController.position.maxScrollExtent - 5,
              duration: Duration(milliseconds: 100),
              curve: Curves.ease);
          print("end");

          update();
        }
      },
    );

    super.onInit();
  }

  @override
  void onClose() {
    myBox.close();
    scrollController.removeListener(() {});
    super.onClose();
  }

  Future start() async {
    all_filter = myBox.length;
    for (int i = myBox.length - 1; i >= 0; i--) {
      Member current = myBox.getAt(i);

      current.phone = i + 1;
      await myBox.putAt(i, current);
    }
    myBox.length < 10
        ? filtered_data = myBox.values.toList().cast<Member>()
        : filtered_data = myBox.values.toList().sublist(0, 10).cast<Member>();
    myBox.values
                .where((element) =>
                    DateTime.now().isAfter(element.end_date) == false &&
                    element.blocked == false)
                .toList()
                .length <
            10
        ? filtered_active_data = myBox.values
            .where((element) =>
                DateTime.now().isAfter(element.end_date) == false &&
                element.blocked == false)
            .toList()
            .cast<Member>()
        : filtered_active_data = myBox.values
            .where((element) =>
                DateTime.now().isAfter(element.end_date) == false &&
                element.blocked == false)
            .toList()
            .sublist(0, 10)
            .cast<Member>();
    length_active = myBox.values
        .where((element) =>
            DateTime.now().isAfter(element.end_date) == false &&
            element.blocked == false)
        .toList()
        .length;
    myBox.values
                .where((element) =>
                    DateTime.now().isAfter(element.end_date) == true &&
                    element.blocked == false)
                .toList()
                .length <
            10
        ? filtered_exp_data = myBox.values
            .where((element) =>
                DateTime.now().isAfter(element.end_date) == true &&
                element.blocked == false)
            .toList()
            .cast<Member>()
        : filtered_exp_data = myBox.values
            .where((element) =>
                DateTime.now().isAfter(element.end_date) == true &&
                element.blocked == false)
            .toList()
            .sublist(0, 10)
            .cast<Member>();

    length_exp = myBox.values
        .where((element) =>
            DateTime.now().isAfter(element.end_date) == true &&
            element.blocked == false)
        .toList()
        .length;
    myBox.values.where((element) => element.blocked == true).toList().length <
            10
        ? filtered_blocked_data = myBox.values
            .where((element) => element.blocked == true)
            .toList()
            .cast<Member>()
        : filtered_blocked_data = myBox.values
            .where((element) => element.blocked == true)
            .toList()
            .sublist(0, 10)
            .cast<Member>();
    length_blocked = myBox.values
        .where((element) => element.blocked == true)
        .toList()
        .length;
    

    filtered_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_active_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_exp_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_blocked_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    update();
  }

  Future<void> push_data(Member added_member, int phone) async {
    try {
      await myBox.add(added_member);
      all_filter = myBox.length;
      myBox.length < 10
          ? filtered_data = myBox.values.toList().cast<Member>()
          : filtered_data = myBox.values.toList().sublist(0, 10).cast<Member>();
      myBox.values
                  .where((element) =>
                      DateTime.now().isAfter(element.end_date) == false &&
                      element.blocked == false)
                  .toList()
                  .length <
              10
          ? filtered_active_data = filtered_active_data = myBox.values
              .where((element) =>
                  DateTime.now().isAfter(element.end_date) == false &&
                  element.blocked == false)
              .toList()
              .cast<Member>()
          : filtered_active_data = myBox.values
              .where((element) =>
                  DateTime.now().isAfter(element.end_date) == false &&
                  element.blocked == false)
              .toList()
              .sublist(0, 10)
              .cast<Member>();

      myBox.values
                  .where((element) =>
                      DateTime.now().isAfter(element.end_date) == true &&
                      element.blocked == false)
                  .toList()
                  .length <
              10
          ? filtered_exp_data = myBox.values
              .where((element) =>
                  DateTime.now().isAfter(element.end_date) == true &&
                  element.blocked == false)
              .toList()
              .cast<Member>()
          : filtered_exp_data = myBox.values
              .where((element) =>
                  DateTime.now().isAfter(element.end_date) == true &&
                  element.blocked == false)
              .toList()
              .sublist(0, 10)
              .cast<Member>();

      myBox.values.where((element) => element.blocked == true).toList().length <
              10
          ? filtered_blocked_data = myBox.values
              .where((element) => element.blocked == true)
              .toList()
              .cast<Member>()
          : filtered_blocked_data = myBox.values
              .where((element) => element.blocked == true)
              .toList()
              .sublist(0, 10)
              .cast<Member>();
      if (kDebugMode) {
        print('added sucssefully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('debug: $e');
      }
    }
    filtered_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_active_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_exp_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_blocked_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    update();
  }

  Future<Member> get_data(int index) async {
    return await myBox.getAt(index);
  }

  Future<void> delete_data(String phone) async {
    int place = 0;

    place = await places(phone);

    await deleteFile(myBox.getAt(place).image);
    print("the phone is ${int.parse(phone)}");
    await myBox.deleteAt(place);
    for (int i = myBox.length - 1; i >= 0; i--) {
      Member current = myBox.getAt(i);

      current.phone = i + 1;
      await myBox.putAt(i, current);
    }

    if (HomePage.filters == "") {
      all_filter = myBox.values.length;
      all_filter > 10 ? ending = 10 : ending = all_filter;
      starting = 0;
      filtered_data = myBox.values
          .toList()
          .sublist(myBox.length > 10 ? starting : 0, ending)
          .cast<Member>();

      length_active = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .length;
      length_active > 10 ? end_active = 10 : end_active = length_active;
      starting_active = 0;
      filtered_active_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .sublist(length_active > 10 ? starting_active : 0,
              length_active < 10 ? length_active : end_active)
          .cast<Member>();

      length_exp = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .length;
          length_exp > 10 ? ending_expired = 10 : ending_expired = length_exp;
      starting_expired = 0;

      filtered_exp_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .sublist(starting_expired, ending_expired)
          .cast<Member>();

           length_blocked = myBox.values
          .where((element) =>
              element.blocked == true)
          .toList()
          .length;
      length_blocked > 10
          ? ending_blocked = 10
          : ending_blocked = length_blocked;
      starting_blocked = 0;
   
        filtered_blocked_data = myBox.values
            .where((element) =>
                element.blocked == true)
            .toList()
            .sublist(starting_blocked, ending_blocked)
            .cast<Member>();
    
    } else {
      all_filter = myBox.values
          .where((element) => element.name
              .toLowerCase()
              .contains(HomePage.filters.toLowerCase()))
          .toList()
          .length;
      all_filter > 10 ? ending = 10 : ending = all_filter;
      starting = 0;

      filtered_data = myBox.values
          .where((element) => element.name
              .toLowerCase()
              .contains(HomePage.filters.toLowerCase()))
          .toList()
          .sublist(starting, ending)
          .cast<Member>();

      //------------------------------------------------------//
      //----------------------Active-----------------------------//
      length_active = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .length;
      length_active > 10 ? end_active = 10 : end_active = length_active;
      starting_active = 0;

      filtered_active_data = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .sublist(starting_active, end_active)
          .cast<Member>();

      //------------------------------------------------------//
      //----------------------Expired-----------------------------//
      length_exp = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .length;
      length_exp > 10 ? ending_expired = 10 : ending_expired = length_exp;
      starting_expired = 0;

      filtered_exp_data = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .sublist(starting_expired, ending_expired)
          .cast<Member>();

      //------------------------------------------------------//
      //----------------------Blocked-----------------------------//
      length_blocked = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              element.blocked == true)
          .toList()
          .length;
      length_blocked > 10
          ? ending_blocked = 10
          : ending_blocked = length_blocked;
      starting_blocked = 0;
   
        filtered_blocked_data = myBox.values
            .where((element) =>
                element.name
                    .toLowerCase()
                    .contains(HomePage.filters.toLowerCase()) &&
                element.blocked == true)
            .toList()
            .sublist(starting_blocked, ending_blocked)
            .cast<Member>();
    
    }
    filtered_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_active_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_exp_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_blocked_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );

    update();
  }

  Future<void> block_member(Member blocked_member, String phone) async {
    int place = 0;
    place = await places(phone);
    await myBox.putAt(place, blocked_member);
        if (HomePage.filters == "") {
      all_filter = myBox.values.length;
      all_filter > 10 ? ending = 10 : ending = all_filter;
      starting = 0;
      filtered_data = myBox.values
          .toList()
          .sublist(myBox.length > 10 ? starting : 0, ending)
          .cast<Member>();

      length_active = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .length;
      length_active > 10 ? end_active = 10 : end_active = length_active;
      starting_active = 0;
      filtered_active_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .sublist(length_active > 10 ? starting_active : 0,
              length_active < 10 ? length_active : end_active)
          .cast<Member>();

      length_exp = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .length;
          length_exp > 10 ? ending_expired = 10 : ending_expired = length_exp;
      starting_expired = 0;

      filtered_exp_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .sublist(starting_expired, ending_expired)
          .cast<Member>();

           length_blocked = myBox.values
          .where((element) =>
              element.blocked == true)
          .toList()
          .length;
      length_blocked > 10
          ? ending_blocked = 9
          : ending_blocked = length_blocked;
      starting_blocked = 0;
   
        filtered_blocked_data = myBox.values
            .where((element) =>
                element.blocked == true)
            .toList()
            .sublist(0, ending_blocked)
            .cast<Member>();
    
    } else {
      all_filter = myBox.values
          .where((element) => element.name
              .toLowerCase()
              .contains(HomePage.filters.toLowerCase()))
          .toList()
          .length;
      all_filter > 10 ? ending = 10 : ending = all_filter;
      starting = 0;

      filtered_data = myBox.values
          .where((element) => element.name
              .toLowerCase()
              .contains(HomePage.filters.toLowerCase()))
          .toList()
          .sublist(starting, ending)
          .cast<Member>();

      //------------------------------------------------------//
      //----------------------Active-----------------------------//
      length_active = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .length;
      length_active > 10 ? end_active = 10 : end_active = length_active;
      starting_active = 0;

      filtered_active_data = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .sublist(starting_active, end_active)
          .cast<Member>();

      //------------------------------------------------------//
      //----------------------Expired-----------------------------//
      length_exp = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .length;
      length_exp > 10 ? ending_expired = 10 : ending_expired = length_exp;
      starting_expired = 0;

      filtered_exp_data = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .sublist(starting_expired, ending_expired)
          .cast<Member>();

      //------------------------------------------------------//
      //----------------------Blocked-----------------------------//
      length_blocked = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              element.blocked == true)
          .toList()
          .length;
      length_blocked > 10
          ? ending_blocked = 10
          : ending_blocked = length_blocked;
      starting_blocked = 0;
   
        filtered_blocked_data = myBox.values
            .where((element) =>
                element.name
                    .toLowerCase()
                    .contains(HomePage.filters.toLowerCase()) &&
                element.blocked == true)
            .toList()
            .sublist(starting_blocked, ending_blocked)
            .cast<Member>();
    
    }
    filtered_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_active_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_exp_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_blocked_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    update();
  }

  Future<void> update_member(
      Member member, String phone, String filePath) async {
    int place = 0;

    place = await places(phone);

    await myBox.putAt(place, member);
    if (myBox.getAt(place).image != filePath) {
      await deleteFile(filePath);
    }
        if (HomePage.filters == "") {
      all_filter = myBox.values.length;
      all_filter > 10 ? ending = 10 : ending = all_filter;
      starting = 0;
      filtered_data = myBox.values
          .toList()
          .sublist(myBox.length > 10 ? starting : 0, ending)
          .cast<Member>();

      length_active = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .length;
      length_active > 10 ? end_active = 10 : end_active = length_active;
      starting_active = 0;
      filtered_active_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .sublist(length_active > 10 ? starting_active : 0,
              length_active < 10 ? length_active : end_active)
          .cast<Member>();

      length_exp = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .length;
          length_exp > 10 ? ending_expired = 10 : ending_expired = length_exp;
      starting_expired = 0;

      filtered_exp_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .sublist(starting_expired, ending_expired)
          .cast<Member>();

           length_blocked = myBox.values
          .where((element) =>
              element.blocked == true)
          .toList()
          .length;
      length_blocked > 10
          ? ending_blocked = 10
          : ending_blocked = length_blocked;
      starting_blocked = 0;
   
        filtered_blocked_data = myBox.values
            .where((element) =>
                element.blocked == true)
            .toList()
            .sublist(starting_blocked, ending_blocked)
            .cast<Member>();
    
    } else {
      all_filter = myBox.values
          .where((element) => element.name
              .toLowerCase()
              .contains(HomePage.filters.toLowerCase()))
          .toList()
          .length;
      all_filter > 10 ? ending = 10 : ending = all_filter;
      starting = 0;

      filtered_data = myBox.values
          .where((element) => element.name
              .toLowerCase()
              .contains(HomePage.filters.toLowerCase()))
          .toList()
          .sublist(starting, ending)
          .cast<Member>();

      //------------------------------------------------------//
      //----------------------Active-----------------------------//
      length_active = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .length;
      length_active > 10 ? end_active = 10 : end_active = length_active;
      starting_active = 0;

      filtered_active_data = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .sublist(starting_active, end_active)
          .cast<Member>();

      //------------------------------------------------------//
      //----------------------Expired-----------------------------//
      length_exp = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .length;
      length_exp > 10 ? ending_expired = 10 : ending_expired = length_exp;
      starting_expired = 0;

      filtered_exp_data = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .sublist(starting_expired, ending_expired)
          .cast<Member>();

      //------------------------------------------------------//
      //----------------------Blocked-----------------------------//
      length_blocked = myBox.values
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(HomePage.filters.toLowerCase()) &&
              element.blocked == true)
          .toList()
          .length;
      length_blocked > 10
          ? ending_blocked = 10
          : ending_blocked = length_blocked;
      starting_blocked = 0;
   
        filtered_blocked_data = myBox.values
            .where((element) =>
                element.name
                    .toLowerCase()
                    .contains(HomePage.filters.toLowerCase()) &&
                element.blocked == true)
            .toList()
            .sublist(starting_blocked, ending_blocked)
            .cast<Member>();
    
    }
    filtered_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_active_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_exp_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_blocked_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );

    update();
  }

  void filter_data(String filter) {
    //---------------------All-------------------------------//
    if (filter == "") {
      all_filter = myBox.values.length;
      filtered_data = myBox.values
          .toList()
          .sublist(myBox.length > 10 ? starting : 0,
              myBox.length > 10 ? ending : myBox.length)
          .cast<Member>();

      if (ending + 10 >= myBox.length) {
        ending = myBox.length;
        starting = myBox.length - 10;
      } else {
        starting += 10;
        ending += 10;
      }
      //------------------------------------------------------//
      //----------------------Active-----------------------------//

      length_active = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .length;
      filtered_active_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .sublist(length_active > 10 ? starting_active : 0,
              length_active < 10 ? length_active : end_active)
          .cast<Member>();
      if (end_active + 10 >= length_active) {
        end_active = length_active;
        starting_active = length_active - 10;
      } else {
        starting_active += 10;
        end_active += 10;
      }
      //-------------------------------------------------------//
//----------------------Expired-----------------------------//
      length_exp = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .length;
      filtered_exp_data = myBox.values
          .where((element) =>
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .sublist(length_exp > 10 ? starting_expired : 0,
              length_exp < 10 ? length_exp : ending_expired)
          .cast();
      if (ending_expired + 10 >= length_exp) {
        ending_expired = length_exp;
        starting_expired = length_exp - 10;
      } else {
        starting_expired += 10;
        ending_expired += 10;
      }
      //-------------------------------------------------------//
//----------------------Blocked-----------------------------//
      length_blocked = myBox.values
          .where((element) => element.blocked == true)
          .toList()
          .length;
      filtered_blocked_data = myBox.values
          .where((element) => element.blocked == true)
          .toList()
          .sublist(length_blocked > 10 ? starting_blocked : 0,
              length_blocked < 10 ? length_blocked : ending_blocked)
          .cast<Member>();
      if (ending_blocked + 10 >= length_blocked) {
        ending_blocked = length_blocked;
        starting_blocked = length_blocked - 10;
      } else {
        starting_blocked += 10;
        ending_blocked += 10;
      }
      //-------------------------------------------------------//
    } else {
      //---------------------All-------------------------------//
      all_filter = myBox.values
          .where((element) =>
              element.name.toLowerCase().contains(filter.toLowerCase()))
          .toList()
          .length;
      if (all_filter > 10) {
        filtered_data = myBox.values
            .where((element) =>
                element.name.toLowerCase().contains(filter.toLowerCase()))
            .toList()
            .sublist(starting, ending )
            .cast<Member>();
        if (ending + 10 >=
            myBox.values
                .where((element) =>
                    element.name.toLowerCase().contains(filter.toLowerCase()))
                .toList()
                .length) {
          ending = myBox.values
              .where((element) =>
                  element.name.toLowerCase().contains(filter.toLowerCase()))
              .toList()
              .length;
          starting = myBox.values
                  .where((element) =>
                      element.name.toLowerCase().contains(filter.toLowerCase()))
                  .toList()
                  .length -
              10;
        } else {
          starting += 10;
          ending += 10;
        }
      } else {
        filtered_data = myBox.values
            .where((element) =>
                element.name.toLowerCase().contains(filter.toLowerCase()))
            .toList()
            .sublist(starting, all_filter)
            .cast<Member>();
      }
      //------------------------------------------------------//
      //----------------------Active-----------------------------//
      length_active = myBox.values
          .where((element) =>
              element.name.toLowerCase().contains(filter.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == false &&
              element.blocked == false)
          .toList()
          .length;
      if (length_active > 10) {
        filtered_active_data = myBox.values
            .where((element) =>
                element.name.toLowerCase().contains(filter.toLowerCase()) &&
                DateTime.now().isAfter(element.end_date) == false &&
                element.blocked == false)
            .toList()
            .sublist(starting_active, end_active )
            .cast<Member>();
        if (end_active + 10 >=
            myBox.values
                .where((element) =>
                    element.name.toLowerCase().contains(filter.toLowerCase()) &&
                    DateTime.now().isAfter(element.end_date) == false &&
                    element.blocked == false)
                .toList()
                .length) {
          end_active = myBox.values
              .where((element) =>
                  element.name.toLowerCase().contains(filter.toLowerCase()) &&
                  DateTime.now().isAfter(element.end_date) == false &&
                  element.blocked == false)
              .toList()
              .length;
          starting_active = myBox.values
                  .where((element) =>
                      element.name
                          .toLowerCase()
                          .contains(filter.toLowerCase()) &&
                      DateTime.now().isAfter(element.end_date) == false &&
                      element.blocked == false)
                  .toList()
                  .length -
              10;
        } else {
          starting_active += 10;
          end_active += 10;
        }
      } else {
        filtered_active_data = myBox.values
            .where((element) =>
                element.name.toLowerCase().contains(filter.toLowerCase()) &&
                DateTime.now().isAfter(element.end_date) == false &&
                element.blocked == false)
            .toList()
            .sublist(starting_active, length_active)
            .cast<Member>();
      }
      //------------------------------------------------------//
      //----------------------Expired-----------------------------//
      length_exp = myBox.values
          .where((element) =>
              element.name.toLowerCase().contains(filter.toLowerCase()) &&
              DateTime.now().isAfter(element.end_date) == true &&
              element.blocked == false)
          .toList()
          .length;
      if (length_exp > 10) {
        filtered_exp_data = myBox.values
            .where((element) =>
                element.name.toLowerCase().contains(filter.toLowerCase()) &&
                DateTime.now().isAfter(element.end_date) == true &&
                element.blocked == false)
            .toList()
            .sublist(starting_expired, ending_expired)
            .cast<Member>();
        if (ending_expired + 10 >=
            myBox.values
                .where((element) =>
                    element.name.toLowerCase().contains(filter.toLowerCase()) &&
                    DateTime.now().isAfter(element.end_date) == true &&
                    element.blocked == false)
                .toList()
                .length) {
          ending_expired = myBox.values
              .where((element) =>
                  element.name.toLowerCase().contains(filter.toLowerCase()) &&
                  DateTime.now().isAfter(element.end_date) == true &&
                  element.blocked == false)
              .toList()
              .length;
          starting_expired = myBox.values
                  .where((element) =>
                      element.name
                          .toLowerCase()
                          .contains(filter.toLowerCase()) &&
                      DateTime.now().isAfter(element.end_date) == true &&
                      element.blocked == false)
                  .toList()
                  .length -
              10;
        } else {
          starting_expired += 10;
          ending_expired += 10;
        }
      } else {
        print(starting_active);
        filtered_exp_data = myBox.values
            .where((element) =>
                element.name.toLowerCase().contains(filter.toLowerCase()) &&
                DateTime.now().isAfter(element.end_date) == true &&
                element.blocked == false)
            .toList()
            .sublist(starting_expired, length_exp)
            .cast<Member>();
      }
      //------------------------------------------------------//
      //----------------------Blocked-----------------------------//
      length_blocked = myBox.values
          .where((element) =>
              element.name.toLowerCase().contains(filter.toLowerCase()) &&
              element.blocked == true)
          .toList()
          .length;
      if (length_exp > 10) {
        filtered_blocked_data = myBox.values
            .where((element) =>
                element.name.toLowerCase().contains(filter.toLowerCase()) &&
                element.blocked == true)
            .toList()
            .sublist(starting_blocked, ending_blocked)
            .cast<Member>();
        if (ending_blocked + 10 >=
            myBox.values
                .where((element) =>
                    element.name.toLowerCase().contains(filter.toLowerCase()) &&
                    element.blocked == true)
                .toList()
                .length) {
          ending_blocked = myBox.values
              .where((element) =>
                  element.name.toLowerCase().contains(filter.toLowerCase()) &&
                  element.blocked == true)
              .toList()
              .length;
          starting_blocked = myBox.values
                  .where((element) =>
                      element.name
                          .toLowerCase()
                          .contains(filter.toLowerCase()) &&
                      element.blocked == true)
                  .toList()
                  .length -
              10;
        } else {
          starting_blocked += 10;
          ending_blocked += 10;
        }
      } else {
        filtered_blocked_data = myBox.values
            .where((element) =>
                element.name.toLowerCase().contains(filter.toLowerCase()) &&
                element.blocked == true)
            .toList()
            .sublist(starting_blocked, length_blocked)
            .cast<Member>();
      }
    }
    filtered_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_active_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_exp_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    filtered_blocked_data.sort(
      (a, b) => a.phone.compareTo(b.phone),
    );
    update();
  }

  Future<int> places(String phone) async {
    int current = 0;

    for (int i = 0; i < myBox.length; i++) {
      if (myBox.getAt(i).phone.toString() == phone) {
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
          minHeight: 1000, minWidth: 1000, quality: 94);
      if (compressedfile != null) {}
    }
    update();
  }

  ImageProvider display_image(String? path) {
    if (path == "") {
      return const AssetImage("assets/25.png");
    } else {
      return FileImage(File(path!));
    }
  }

  Future<void> deleteFile(String filePath) async {
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
