import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_sof/controller/data_controller.dart';
import 'package:gym_sof/utils/person_card.dart';
import 'package:gym_sof/view/add_member.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Data data_controller = Get.find();
    TextEditingController filter = TextEditingController(text: "");
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  data_controller.update_lenght();
                },
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
                                    fontSize: 24.sp,
                                    fontFamily: 'Helvetica Light',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: DateFormat.d().format(DateTime.now()),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: ',',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
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
                              Container(
                                margin: EdgeInsets.only(top: 10.h),
                                width: 281.56.w,
                                height: 37.h,
                                child: TextField(
                                  style: TextStyle(color: Color(0xFFD9D9D9)),
                                  cursorColor: Color(0xFFD9D9D9),
                                  controller: filter,
                                  onChanged: (value) {
                                    data_controller.filter_data(filter.text);
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
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: 10.w, bottom: 4.h),
                                child: InkWell(
                                  onTap: () {
                                    data_controller.length = 5;
                                    data_controller.update();
                                    Get.to(() => AddMember());
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
                                indicatorPadding: EdgeInsets.only(bottom: 10),
                                dividerHeight: 0,
                                indicatorColor: Color(0xFFD9D9D9),
                                padding: EdgeInsets.only(left: 15, right: 15),
                                unselectedLabelStyle: TextStyle(
                                    color: Color(0xFFD9D9D9), fontSize: 13),
                                labelStyle: TextStyle(
                                    color: Color(
                                      0xFFD9D9D9,
                                    ),
                                    fontSize: 14.5),
                                tabs: [
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
                          )
                        ])),
              ),
              GetBuilder<Data>(builder: (context) {
                return SizedBox(
                  height: (182 * data_controller.length).toDouble(),
                  width: 1.sw,
                  child: TabBarView(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: 15.h, left: 25, right: 25, bottom: 20),
                        itemCount: data_controller.length,
                        itemBuilder: (context, index) {
                          return PersonCard(
                            member: data_controller.filtered_data,
                            index: index,
                            data_controller: data_controller,
                          );
                        },
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: 10.h, left: 25, right: 25, bottom: 20),
                        itemCount: data_controller.length,
                        itemBuilder: (context, index) {
                          if (data_controller.filtered_data[index].start_date
                              .isAfter(data_controller
                                  .filtered_data[index].end_date)) {
                            return PersonCard(
                                member: data_controller.filtered_data,
                                index: index,
                                data_controller: data_controller);
                          }
                        },
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: 10.h, left: 25, right: 25, bottom: 20),
                        itemCount: data_controller.length,
                        itemBuilder: (context, index) {
                          if (data_controller.filtered_data[index].start_date
                                  .isAfter(data_controller
                                      .filtered_data[index].end_date) ==
                              false) {
                            return PersonCard(
                                member: data_controller.filtered_data,
                                index: index,
                                data_controller: data_controller);
                          }
                        },
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: 10.h, left: 25, right: 25, bottom: 20),
                        itemCount: data_controller.length,
                        itemBuilder: (context, index) {
                          return PersonCard(
                              member: data_controller.filtered_data,
                              index: index,
                              data_controller: data_controller);
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
    );
  }
}
