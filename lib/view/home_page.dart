import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_sof/controller/data_controller.dart';
import 'package:gym_sof/utils/person_card.dart';
import 'package:gym_sof/view/add_member.dart';
import 'package:gym_sof/view/cash_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  static int index = 0;
  static String filters = "";
  static TextEditingController filter = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    int filter_active_length = 0;
    int filter_exp_length = 0;
    int filter_blocked_length = 0;
    Data data_controller = Get.find();
    int filter_length = 0;

    return Scaffold(
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          data_controller.start();
          filter = TextEditingController(text: "");
          filter_blocked_length =
                                                  data_controller.myBox.values
                                                      .where((element) =>
                                                          element.name
                                                              .toLowerCase()
                                                              .contains(filter.text
                                                                  .toLowerCase()) &&
                                                          element.blocked == true)
                                                      .toList()
                                                      .length;
                                              filter_exp_length = data_controller
                                                  .myBox.values
                                                  .where((element) =>
                                                      element.name
                                                          .toLowerCase()
                                                          .contains(filter.text
                                                              .toLowerCase()) &&
                                                      DateTime.now().isAfter(
                                                              element.end_date) ==
                                                          true &&
                                                      element.blocked == false)
                                                  .toList()
                                                  .length;
                                        
                                              filter_active_length = data_controller
                                                  .myBox.values
                                                  .where((element) =>
                                                      element.name
                                                          .toLowerCase()
                                                          .contains(filter.text
                                                              .toLowerCase()) &&
                                                      DateTime.now().isAfter(
                                                              element.end_date) ==
                                                          false &&
                                                      element.blocked == false)
                                                  .toList()
                                                  .length;
                                        
                                              filter_length = data_controller
                                                  .myBox.values
                                                  .where((element) => element.name
                                                      .toLowerCase()
                                                      .contains(filter.text
                                                          .toLowerCase()))
                                                  .toList()
                                                  .length;
                                              data_controller.starting_blocked = 0;
                                              filter_blocked_length >= 10
                                                  ? data_controller.ending_blocked =
                                                      10
                                                  : data_controller.ending_blocked =
                                                      filter_blocked_length;
                                        
                                              data_controller.starting_expired = 0;
                                              filter_exp_length >= 10
                                                  ? data_controller.ending_expired =
                                                      10
                                                  : data_controller.ending_expired =
                                                      filter_exp_length;
                                              data_controller.starting_active = 0;
                                              filter_active_length >= 10
                                                  ? data_controller.end_active = 10
                                                  : data_controller.end_active =
                                                      filter_active_length;
                                        
                                              data_controller.starting = 0;
                                              filter_length >= 10
                                                  ? data_controller.ending = 10
                                                  : data_controller.ending =
                                                      filter_length;
          data_controller.update();
        },
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            double velocity = details.primaryVelocity ?? 0;
            print(velocity);
            if (velocity < -500) {
              Get.to(() => CashPage(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 200));
            }
          },
          child: SizedBox(
            height: double.maxFinite,
            child: DefaultTabController(
              length: 4,
              child: SingleChildScrollView(
                controller: data_controller.scrollController,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: 1.sw,
                          height: 280.h,
                          decoration: const BoxDecoration(
                              color: Color(0xFF232020),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(35),
                                  bottomRight: Radius.circular(35))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 35.h,
                                ),
                                Text(
                                  '${DateFormat.EEEE().format(DateTime.now())},',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontFamily: 'Helvetica Light',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: DateFormat.MMMM()
                                            .format(DateTime.now())
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontFamily: 'Helvetica Light',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontFamily: 'Helvetica',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: DateFormat.d()
                                            .format(DateTime.now()),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontFamily: 'Helvetica',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ',',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontFamily: 'Helvetica Light',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${DateFormat.y().format(DateTime.now())}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.sp,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GetBuilder<Data>(
                                      builder: (context) {
                                        return Container(
                                          margin: EdgeInsets.only(top: 5.h),
                                          width: 281.56.w,
                                          height: 37.h,
                                          child: TextField(
                                            style:
                                                TextStyle(color: Color(0xFFD9D9D9)),
                                            cursorColor: Color(0xFFD9D9D9),
                                            controller: filter,
                                            onChanged: (value) {
                                              filters = value;
                                              filter_blocked_length =
                                                  data_controller.myBox.values
                                                      .where((element) =>
                                                          element.name
                                                              .toLowerCase()
                                                              .contains(filter.text
                                                                  .toLowerCase()) &&
                                                          element.blocked == true)
                                                      .toList()
                                                      .length;
                                              filter_exp_length = data_controller
                                                  .myBox.values
                                                  .where((element) =>
                                                      element.name
                                                          .toLowerCase()
                                                          .contains(filter.text
                                                              .toLowerCase()) &&
                                                      DateTime.now().isAfter(
                                                              element.end_date) ==
                                                          true &&
                                                      element.blocked == false)
                                                  .toList()
                                                  .length;
                                        
                                              filter_active_length = data_controller
                                                  .myBox.values
                                                  .where((element) =>
                                                      element.name
                                                          .toLowerCase()
                                                          .contains(filter.text
                                                              .toLowerCase()) &&
                                                      DateTime.now().isAfter(
                                                              element.end_date) ==
                                                          false &&
                                                      element.blocked == false)
                                                  .toList()
                                                  .length;
                                        
                                              filter_length = data_controller
                                                  .myBox.values
                                                  .where((element) => element.name
                                                      .toLowerCase()
                                                      .contains(filter.text
                                                          .toLowerCase()))
                                                  .toList()
                                                  .length;
                                              data_controller.starting_blocked = 0;
                                              filter_blocked_length >= 10
                                                  ? data_controller.ending_blocked =
                                                      10
                                                  : data_controller.ending_blocked =
                                                      filter_blocked_length;
                                        
                                              data_controller.starting_expired = 0;
                                              filter_exp_length >= 10
                                                  ? data_controller.ending_expired =
                                                      10
                                                  : data_controller.ending_expired =
                                                      filter_exp_length;
                                              data_controller.starting_active = 0;
                                              filter_active_length >= 10
                                                  ? data_controller.end_active = 10
                                                  : data_controller.end_active =
                                                      filter_active_length;
                                        
                                              data_controller.starting = 0;
                                              filter_length >= 10
                                                  ? data_controller.ending = 10
                                                  : data_controller.ending =
                                                      filter_length;
                                              data_controller
                                                  .filter_data(filter.text);
                                        
                                              data_controller.update();
                                            },
                                            cursorOpacityAnimates: true,
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(bottom: 12.h),
                                                prefixIcon: Icon(
                                                  Icons.search,
                                                  size: 24.sp,
                                                ),
                                                prefixIconColor: Color(0xFFD9D9D9),
                                                focusColor: Color(0xFFD9D9D9),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                    borderSide: BorderSide(
                                                        color: Color(0xFFD9D9D9))),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                    borderSide: BorderSide(
                                                        color: Color(0xFFD9D9D9))),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                    borderSide: BorderSide(
                                                        color: Color(0xFFD9D9D9)))),
                                          ),
                                        );
                                      }
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10.w, bottom: 4.h),
                                      child: InkWell(
                                        onTap: () {
                                          data_controller.update();
                                          Get.to(() => AddMember(),
                                              transition: Transition.upToDown,
                                              duration:
                                                  Duration(milliseconds: 150));
                                        },
                                        child: Icon(
                                          Icons.person_add,
                                          size: 30,
                                          color: Color(0xFFD9D9D9),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 1.sh,
                                  child: TabBar(
                                      onTap: (value) {
                                        index = value;
                                        filter_blocked_length = data_controller
                                            .myBox.values
                                            .where((element) =>
                                                element.name
                                                    .toLowerCase()
                                                    .contains(filter.text
                                                        .toLowerCase()) &&
                                                element.blocked == true)
                                            .toList()
                                            .length;
                                        filter_exp_length = data_controller
                                            .myBox.values
                                            .where((element) =>
                                                element.name
                                                    .toLowerCase()
                                                    .contains(filter.text
                                                        .toLowerCase()) &&
                                                DateTime.now().isAfter(
                                                        element.end_date) ==
                                                    true &&
                                                element.blocked == false)
                                            .toList()
                                            .length;

                                        filter_active_length = data_controller
                                            .myBox.values
                                            .where((element) =>
                                                element.name
                                                    .toLowerCase()
                                                    .contains(filter.text
                                                        .toLowerCase()) &&
                                                DateTime.now().isAfter(
                                                        element.end_date) ==
                                                    false &&
                                                element.blocked == false)
                                            .toList()
                                            .length;

                                        filter_length = data_controller
                                            .myBox.values
                                            .where((element) => element.name
                                                .toLowerCase()
                                                .contains(
                                                    filter.text.toLowerCase()))
                                            .toList()
                                            .length;
                                        data_controller.starting_blocked = 0;

                                        data_controller.starting =
                                            data_controller.starting_active =
                                                data_controller
                                                    .starting_expired = 0;

                                        data_controller.starting_expired = 0;
                                        filter_exp_length >= 10
                                            ? data_controller.ending_expired =
                                                10
                                            : data_controller.ending_expired =
                                                filter_exp_length;
                                        data_controller.starting_active = 0;
                                        filter_active_length >= 10
                                            ? data_controller.end_active = 10
                                            : data_controller.end_active =
                                                filter_active_length;

                                        data_controller.starting = 0;
                                        filter_length >= 10
                                            ? data_controller.ending = 10
                                            : data_controller.ending =
                                                filter_length;
                                        filter_blocked_length >= 10
                                            ? data_controller.ending_blocked =
                                                10
                                            : data_controller.ending_blocked =
                                                filter_blocked_length;
                                        data_controller
                                            .filter_data(filter.text);
                                      },
                                      indicatorPadding:
                                          EdgeInsets.only(bottom: 10),
                                      dividerHeight: 0,
                                      indicatorColor: Color(0xFFD9D9D9),
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      unselectedLabelStyle: TextStyle(
                                          color: Color(0xFFD9D9D9),
                                          fontSize: 13),
                                      labelStyle: TextStyle(
                                          color: Color(
                                            0xFFD9D9D9,
                                          ),
                                          fontSize: 14.5.sp),
                                      tabs: const [
                                        Tab(
                                          text: "All",
                                        ),
                                        Tab(
                                          text: "Active",
                                        ),
                                        Tab(
                                          text: "Expired",
                                        ),
                                        Tab(
                                          text: "Blocked",
                                        )
                                      ]),
                                ),
                                GetBuilder<Data>(builder: (context) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 35, bottom: 10),
                                        width: 50,
                                        height: 20.h,
                                        child: Center(
                                            child: Text(
                                          "(${data_controller.all_filter.toString()})",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp),
                                        )),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 42.w, bottom: 10.h),
                                        width: 50.w,
                                        height: 20.h,
                                        child: Center(
                                            child: Text(
                                          "(${data_controller.length_active.toString()})",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp),
                                        )),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 40, bottom: 10.h),
                                        width: 50,
                                        height: 20.h,
                                        child: Center(
                                            child: Text(
                                          "(${data_controller.length_exp.toString()})",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp),
                                        )),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 40, bottom: 10.h),
                                        width: 50.w,
                                        height: 20.h,
                                        child: Center(
                                            child: Text(
                                          "(${data_controller.length_blocked.toString()})",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp),
                                        )),
                                      ),
                                    ],
                                  );
                                }),
                              ])),
                    ),
                    GetBuilder<Data>(builder: (context) {
                      return Container(
                        height: HomePage.index == 0
                            ? 1980.h *
                                (data_controller.filtered_data.length / 10)
                            : HomePage.index == 1
                                ? 1980.h *
                                    (data_controller
                                            .filtered_active_data.length /
                                        10)
                                : HomePage.index == 2
                                    ? 1980.h *
                                        (data_controller
                                                .filtered_exp_data.length /
                                            10)
                                    : 1980.h *
                                        (data_controller
                                                .filtered_blocked_data.length /
                                            10),
                        width: 1.sw,
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                  top: 15.h, left: 25, right: 25),
                              itemCount: data_controller.filtered_data.length,
                              itemBuilder: (context, index) {
                                return PersonCard(
                                  member: data_controller.filtered_data,
                                  index: index,
                                  data_controller: data_controller,
                                );
                              },
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                  top: 10.h, left: 25, right: 25),
                              itemCount:
                                  data_controller.filtered_active_data.length,
                              itemBuilder: (context, index) {
                                return PersonCard(
                                  member: data_controller.filtered_active_data,
                                  index: index,
                                  data_controller: data_controller,
                                );
                              },
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                  top: 10.h, left: 25, right: 25),
                              itemCount:
                                  data_controller.filtered_exp_data.length,
                              itemBuilder: (context, index) {
                                return PersonCard(
                                  member: data_controller.filtered_exp_data,
                                  index: index,
                                  data_controller: data_controller,
                                );
                              },
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                  top: 10.h, left: 25, right: 25),
                              itemCount:
                                  data_controller.filtered_blocked_data.length,
                              itemBuilder: (context, index) {
                                return PersonCard(
                                  member: data_controller.filtered_blocked_data,
                                  index: index,
                                  data_controller: data_controller,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
