import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/data_controller.dart';
class CashPage extends StatelessWidget {
  const CashPage({super.key});
  @override
  Widget build(BuildContext context) {
    final Data data_controller = Get.find();
    double cush = 0;
    double prev_cush = 0;
    double year_cush = 0;
    int length = 0;
    for (int i = 0; i < data_controller.myBox.length; i++) {
      if ( data_controller.myBox.getAt(i).start_date.year == DateTime.now().year) {
        if (data_controller.myBox.getAt(i).start_date.month == DateTime.now().month) {
          if (data_controller.myBox.getAt(i).paid.isEmpty) {
            data_controller.myBox.getAt(i).paid = "0";
          }
          cush = double.parse(data_controller.myBox.getAt(i).paid) + cush;
          length = length + 1;
        } else if (data_controller.myBox.getAt(i).start_date.month ==
            DateTime.now().month - 1) {
          if (data_controller.myBox.getAt(i).paid.isEmpty) {
            data_controller.myBox.getAt(i).paid = "0";
          }
          prev_cush = double.parse(data_controller.myBox.getAt(i).paid) + prev_cush;
        }
        if (data_controller.myBox.getAt(i).paid.isEmpty) {
          data_controller.myBox.getAt(i).paid= "0";
        }
        year_cush = double.parse(data_controller.myBox.getAt(i).paid) + year_cush;
      }
    }
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          double velocity = details.primaryVelocity ?? 0;
          print(velocity);
          if (velocity > 0) {
            Get.back();
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF242323), Color(0xFF939292)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 60.h),
                            child: Text(
                              'REVENUE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36.sp,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 35.h),
                            width: 350.w,
                            height: 70.h,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF232121),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 22,
                                  offset: Offset(0, 0),
                                  spreadRadius: 4,
                                )
                              ],
                            ),
                            child: Stack(children: [
                              Container(
                                width: 214.w,
                                margin: EdgeInsets.only(top: 14.h, left: 65.w),
                                child: Text(
                                  'YEARLY BALANCE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 12.sp,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 12.h, right: 2.w),
                                  alignment: Alignment.center,
                                  child: GetBuilder<Data>(
                                      builder: (controller) {
                                    return Text(
                                      '${year_cush} DZD',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF00A237),
                                        fontSize: 16.sp,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    );
                                  })),
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 17.h, left: 20.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 165.w,
                                  height: 120.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF232121),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(23),
                                    ),
                                  ),
                                  child: Stack(children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 42.h, left: 25.w),
                                      child: Text(
                                        'CURRENT MONTH',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFD9D9D9),
                                          fontSize: 12.sp,
                                          fontFamily: 'Helvetica',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 25.w, top: 60.h),
                                        child: GetBuilder<Data>(
                                          builder: (controller) {
                                            return Text(
                                              '${cush} DZD',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF00A237),
                                                fontSize: 16.sp,
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            );
                                          },
                                        )),
                                  ]),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20.w),
                                  width: 165.w,
                                  height: 120.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF232121),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(23),
                                    ),
                                  ),
                                  child: Stack(children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 42.h, left: 25.w),
                                      child: Text(
                                        'PAST MONTH',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFD9D9D9),
                                          fontSize: 12.sp,
                                          fontFamily: 'Helvetica',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 25.w, top: 60.h),
                                        child: GetBuilder<Data>(
                                          builder: (controller) {
                                            return Text(
                                              '${prev_cush} DZD',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF00A237),
                                                fontSize: 16.sp,
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            );
                                          },
                                        )),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          GetBuilder<Data>(
                            builder: (controller) {
                              return Container(
                                margin: EdgeInsets.only(top: 17.h),
                                width: 350.w,
                                height:
                                    length <= 6 ? 500.h : (length * 550.h) / 7,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF232121),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(23),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 22,
                                      offset: Offset(0, 0),
                                      spreadRadius: 4,
                                    )
                                  ],
                                ),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: length,
                                  itemBuilder: (context, index) {
                                    if (data_controller.myBox.getAt(index).start_date
                                            .month ==
                                        DateTime.now().month) {
                                      return Container(
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 100.w,
                                                  margin: EdgeInsets.only(
                                                      top: 25.h, left: 25.w),
                                                  child: Text(
                                                    '${data_controller.myBox.getAt(index).name}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.sp,
                                                      fontFamily: 'Helvetica',
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 25.w, top: 3.h),
                                                  child: Text(
                                                    DateFormat.yMd().format(data_controller.myBox.getAt(index).start_date),
                                                    style: TextStyle(
                                                      color: Color(0xFFC0BDBD),
                                                      fontSize: 11.sp,
                                                      fontFamily: 'Helvetica',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 15.h, left: 26.w),
                                                  width: 65.w,
                                                  decoration: ShapeDecoration(
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        width: 0.50,
                                                        strokeAlign: BorderSide
                                                            .strokeAlignCenter,
                                                        color: Color(0xFFC7C7C7),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: 80.w,
                                              margin:
                                                  EdgeInsets.only(left: 115.w),
                                              child: Text(
                                                '${data_controller.myBox.getAt(index).paid} DZD',
                                                style: TextStyle(
                                                  color: Color(0xFF00A237),
                                                  fontSize: 14.sp,
                                                  fontFamily: 'Helvetica',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Icon(
                                                Icons.arrow_upward,
                                                color: Color(0xFF00A237),
                                                size: 17.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            
              
            ],
          ),
        ),
      ),
    );
  }
}
