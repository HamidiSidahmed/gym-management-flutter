import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_sof/view/home_page.dart';

import 'password_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool visible = false;
    TextEditingController user_name = TextEditingController();
    TextEditingController password = TextEditingController();
    Widget widget = Container();
    void logincheck(Widget text) {
      widget = text;
    }
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const ShapeDecoration(
          color: Color(0xFFD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x7C000000),
              blurRadius: 33,
              offset: Offset(1, -1),
              spreadRadius: 0,
            )
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 35.h),
                width: 242.w,
                height: 185.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/3.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70.h),
                child: Text(
                  'LOG IN',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontFamily: 'Futura',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.h),
                width: 246.w,
                height: 50.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFFC7C7C7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: TextField(
                        controller: user_name,
                        cursorWidth: 1,
                        style: TextStyle(fontSize: 13.5.sp),
                        textAlignVertical: TextAlignVertical.bottom,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.h, left: 15.w),
                      width: 108.w,
                      child: Text(
                        'User name',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7799999713897705),
                          fontSize: 11.5.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 14.h),
                width: 246.w,
                height: 50.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFFC7C7C7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: TextField(
                        obscureText: !visible,
                        controller: password,
                        cursorWidth: 1,
                        style: TextStyle(fontSize: 13.5.sp),
                        textAlignVertical: TextAlignVertical.bottom,
                        cursorColor: Colors.black,
                        decoration:
                            InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.h, left: 15.w),
                      width: 108.w,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7799999713897705),
                          fontSize: 11.5.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 10.w),
                      child: InkWell(
                        onTap: () {
                          visible = !visible;
                        },
                        child: Icon(
                          Icons.visibility,
                          color: visible == false
                              ? Colors.grey[500]
                              : Colors.grey.shade700,
                          size: 20.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.h),
                child: InkWell(
                 onTap: (){
                  Get.to(()=>HomePage());
                 },
                  child: Container(
                    width: 106.w,
                    height: 38.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFC7C7C7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'LOG IN',
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
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 105.w, top: 14.h),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(()=>PasswordPage());
                      user_name.clear();
                      password.clear();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5.w, top: 14.h),
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w700,
                        ),
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

  
