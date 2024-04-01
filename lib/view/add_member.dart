import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_sof/controller/data_controller.dart';
import 'package:gym_sof/model/member.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class AddMember extends StatelessWidget {
  const AddMember({super.key});

  @override
  Widget build(BuildContext context) {
    Data data_controller = Get.find();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController exp_day = TextEditingController();
    TextEditingController plan = TextEditingController();
    TextEditingController paid = TextEditingController();
    DateTime end_date = DateTime.now();

    data_controller.compressedfile = null;
    ImageProvider comImage() {
      if (data_controller.compressedfile == null) {
        return AssetImage("assets/25.png");
      } else {
        return FileImage(File(data_controller.compressedfile.path));
      }
    }

    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: 1.sw,
                height: 1.sh,
                child: Image.asset(
                  "assets/add.png",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: 1.sw,
                height: 1.sh,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0, 1),
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0)
                    ],
                  ),
                ),
              ),
              Container(
                width: 1.sw,
                height: 1.sh,
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(bottom: 15.h, top: 175.h, left: 5.w),
                      child: Text(
                        'ADD A MEMBER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontFamily: 'Futura',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          context: context,
                          builder: (context) {
                            return Container(
                              width: 1.sw,
                              height: 125.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35)),
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10.h, left: 45.w),
                                    width: 1.sw,
                                    height: 50.h,
                                    child: InkWell(
                                      onTap: () async {
                                        await data_controller
                                            .takephoto(ImageSource.camera);
                                        await data_controller.compress();
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 0),
                                            child: Image.asset(
                                                "assets/camera.png"),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 20.w),
                                            child: Text(
                                              'Take a Picture',
                                              style: TextStyle(
                                                color: Color(0xFF232121),
                                                fontSize: 13.sp,
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30.h,
                                    child: InkWell(
                                      onTap: () async {
                                        await data_controller
                                            .takephoto(ImageSource.gallery);

                                        await data_controller.compress();

                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            margin: EdgeInsets.only(
                                              left: 45.w,
                                            ),
                                            child: Image.asset(
                                                "assets/gallery.png"),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 20.w,
                                            ),
                                            child: Text(
                                              'Export From Gallery',
                                              style: TextStyle(
                                                color: Color(0xFF232121),
                                                fontSize: 13.sp,
                                                fontFamily: 'Helvetica',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: GetBuilder<Data>(builder: (context) {
                        return Container(
                          margin: EdgeInsets.only(top: 20.h),
                          width: 94.w,
                          height: 94.h,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: comImage(),
                          ),
                        );
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      width: 246.w,
                      height: 44.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFC7C7C7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 14.w, top: 3.h),
                            width: 108.w,
                            child: Text(
                              'Name',
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.7799999713897705),
                                fontSize: 10.5.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 16.5.w,
                            ),
                            child: TextField(
                                onChanged: (value) {
                                  print(name.text);
                                },
                                controller: name,
                                style: TextStyle(fontSize: 13.5.sp),
                                cursorColor: Colors.black,
                                decoration:
                                    InputDecoration(border: InputBorder.none)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      width: 246.w,
                      height: 44.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFC7C7C7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 14.w, top: 3.h),
                            width: 108.w,
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.7799999713897705),
                                fontSize: 10.5.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 16.5.w,
                            ),
                            child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: phone,
                                style: TextStyle(fontSize: 13.5.sp),
                                cursorColor: Colors.black,
                                decoration:
                                    InputDecoration(border: InputBorder.none)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      width: 246.w,
                      height: 44.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFC7C7C7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 14.w, top: 3.h),
                            width: 108.w,
                            child: Text(
                              'Experation Date',
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.7799999713897705),
                                fontSize: 10.5.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            alignment: Alignment.centerRight,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetBuilder<Data>(builder: (context) {
                                  return Container(
                                    width: 100.w,
                                    margin: EdgeInsets.only(
                                        left: 15.w, top: 10.h, right: 90.w),
                                    child: Text(
                                      DateFormat.yMd().format(end_date),
                                      style: TextStyle(fontSize: 13.5.sp),
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
                                                    BorderRadius.circular(35)),
                                            height: 175.h,
                                            child: CupertinoDatePicker(
                                                initialDateTime:
                                                    DateTime(2023, 1, 1),
                                                minimumYear: 2023,
                                                mode: CupertinoDatePickerMode
                                                    .date,
                                                onDateTimeChanged:
                                                    (DateTime time) {
                                                  end_date = time;
                                                  data_controller.update();
                                                }),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: 4.h, left: 8.w),
                                        width: 20.w,
                                        child: Image.asset(
                                            "assets/calendar.png"))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      width: 246.w,
                      height: 44.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFC7C7C7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 14.w, top: 3.h),
                            width: 108.w,
                            child: Text(
                              'Plan',
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.7799999713897705),
                                fontSize: 10.5.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 16.5.w,
                            ),
                            child: TextField(
                                controller: plan,
                                style: TextStyle(fontSize: 13.5.sp),
                                cursorColor: Colors.black,
                                decoration:
                                    InputDecoration(border: InputBorder.none)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.h),
                      width: 246.w,
                      height: 44.h,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFC7C7C7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 14.w, top: 3.h),
                            width: 108.w,
                            child: Text(
                              'Amount paid',
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.7799999713897705),
                                fontSize: 10.5.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 16.5.w,
                            ),
                            child: TextField(
                                controller: paid,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 13.5.sp),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                    border: InputBorder.none)),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await data_controller.push_data(Member(
                            name.text,
                            phone.text,
                            end_date,
                            data_controller.compressedfile == null
                                ? ""
                                : data_controller.compressedfile.path,
                            true,
                            DateTime.now(),
                            plan.text,
                            paid.text,
                            false,
                            DateTime(2023)));
                        data_controller.filter_data("");
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 40.h),
                        width: 106.w,
                        height: 40.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFC7C7C7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'ADD',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontFamily: 'Futura',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
