import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_sof/view/edit_member.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      height: 165.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
        shadows: [
          const BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.w, bottom: 5.h),
            width: 75.w,
            height: 75.w,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/25.png")),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.w),
                height: 165.h,
                width: 115.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Name:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: 35.h,
                      child: Text(
                        "HAMIDI  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.7.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      'Phone:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "0674239277",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Text(
                      'Plan:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "1500 DA",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 0.w),
                height: 165.h,
                width: 80.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'State:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: 35.h,
                      child: Text(
                        "Active",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12.7.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      'Expired in:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "05/12/2023",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Text(
                      'Paid:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "1500 DA",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 165.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(35.r)),
                        context: context,
                        builder: (context) => Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(35)),
                              width: 1.sw,
                              height: 125.h,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[350],
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    width: 250.w,
                                    height: 40.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 20.w),
                                          child: Text(
                                            "25/09/2002",
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35)),
                                                  height: 175.h,
                                                  child: CupertinoDatePicker(
                                                      initialDateTime:
                                                          DateTime(2023, 1, 1),
                                                      minimumYear: 2023,
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                      onDateTimeChanged:
                                                          (DateTime time) {}),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                              width: 35.w,
                                              height: 35.h,
                                              margin:
                                                  EdgeInsets.only(right: 10.w),
                                              child: Icon(
                                                Icons.calendar_month_sharp,
                                                color: Colors.black,
                                                size: 22.sp,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Block",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ));
                  },
                  child: Icon(
                    Icons.block,
                    size: 26,
                    color: Colors.red,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(35.r)),
                      context: context,
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.r)),
                        height: 100.h,
                        width: 1.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 75.w,
                              height: 50.h,
                              child: Center(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 18.sp),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 75.w,
                              height: 50.h,
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18.sp),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 26,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Get.to(() => EditMember());
                    },
                    child: Icon(Icons.edit))
              ],
            ),
          )
        ],
      ),
    );
  }
}
