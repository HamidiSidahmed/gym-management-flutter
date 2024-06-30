import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_sof/controller/data_controller.dart';
import 'package:gym_sof/model/member.dart';
import 'package:gym_sof/view/edit_member.dart';
import 'package:gym_sof/view/home_page.dart';
import 'package:intl/intl.dart';

class PersonCard extends StatelessWidget {
  List<Member> member;
  Data data_controller;
  int index;

  PersonCard({
    super.key,
    required this.member,
    required this.index,
    required this.data_controller,
  });

  @override
  Widget build(BuildContext context) {
    DateTime bloked_date = DateTime.now();
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      height: 175.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Container(
                      child: Image(
                        image:
                            data_controller.display_image(member[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20.w, bottom: 5.h),
              width: 75.w,
              height: 75.w,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      data_controller.display_image(member[index].image)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.w),
                height: 175.h,
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
                        member[index].name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.7.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      "Phone",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.5.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      member[index].phone.toString(),
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
                      member[index].plan,
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
                height: 175.h,
                width: 80.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
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
                    GetBuilder<Data>(builder: (context) {
                      return Container(
                        height: 35.h,
                        child: Text(
                          member[index].blocked == true
                              ? "Blocked"
                              : DateTime.now()
                                          .isAfter(member[index].end_date) ==
                                      false
                                  ? "Active"
                                  : "Expired",
                          style: TextStyle(
                            color: member[index].blocked == true
                                ? Colors.red
                                : DateTime.now()
                                            .isAfter(member[index].end_date) ==
                                        false
                                    ? Colors.green
                                    : Colors.grey[600],
                            fontSize: 12.7.sp,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }),
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
                      DateFormat.yMd().format(member[index].end_date),
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
                      member[index].paid,
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
                                        GetBuilder<Data>(builder: (context) {
                                          return Container(
                                            margin: EdgeInsets.only(left: 20.w),
                                            child: Text(
                                              DateFormat.yMd().format(
                                                  member[index].blocked_date),
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                          );
                                        }),
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
                                                          (DateTime time) {
                                                        member[index]
                                                                .blocked_date =
                                                            time;
                                                        data_controller
                                                            .update();
                                                      }),
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
                                  InkWell(
                                    onTap: () async {
                                      await data_controller.block_member(
                                          Member(
                                              member[index].name,
                                              member[index].phone,
                                              member[index].end_date,
                                              member[index].image,
                                              false,
                                              member[index].start_date,
                                              member[index].plan,
                                              member[index].paid,
                                              !member[index].blocked,
                                              member[index].blocked_date),
                                          member[index].phone.toString());
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      child: Text(
                                        member[index].blocked == false
                                            ? "Block"
                                            : "Unblock",
                                        style: TextStyle(
                                            color:
                                                member[index].blocked == false
                                                    ? Colors.red
                                                    : Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ));
                  },
                  child: Icon(
                    Icons.block,
                    size: 26.r,
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
                            InkWell(
                              onTap: () {
                                data_controller.delete_data(
                                    member[index].phone.toString());
                                Navigator.pop(context);
                              },
                              child: SizedBox(
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
                      Get.to(
                          () => EditMember(
                                member: member,
                                index: index,
                              ),
                          transition: Transition.upToDown,
                          duration: Duration(milliseconds: 150));
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
