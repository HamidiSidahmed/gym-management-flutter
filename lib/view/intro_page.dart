import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_sof/controller/data_controller.dart';
import 'login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    Data data_controller = Get.put(Data());
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: Center(
            child: Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Ellipse 2.png"),
                    fit: BoxFit.fill),
              ),
            ),
          ),
        ),
        Container(
          width: 1.sw,
          height: 1.sh,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(1),
                Colors.black,
                Colors.black
              ],
            ),
          ),
        ),
        Positioned(
          left: 78.w,
          top: 309.h,
          child: Text(
            'WELCOME TO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.sp,
              fontFamily: 'Futura',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Positioned(
          left: 72.w,
          top: 345.h,
          child: Container(
            width: 235.w,
            height: 154.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/2.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          left: 90.w,
          top: 630.h,
          child: InkWell(
            onTap: () async {
              Get.to(() => LoginPage(),
                  transition: Transition.fade,
                  duration: Duration(milliseconds: 150));
            },
            child: Container(
              width: 204.w,
              height: 50.h,
              decoration: ShapeDecoration(
                color: Color(0xFFC7C7C7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Center(
                child: Text(
                  'LOG IN',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontFamily: 'Futura',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 90.w,
          top: 690.h,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),
                context: context,
                builder: (context) {
                  return Container(
                    height: 100.h,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 95.w),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Restore',
                              style: TextStyle(
                                color: Color(0xFF242222),
                                fontSize: 18.sp,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 75.w),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Backup',
                              style: TextStyle(
                                color: Color(0xFF242222),
                                fontSize: 18.sp,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 204.w,
              height: 50.h,
              decoration: ShapeDecoration(
                color: Color(0xFFC7C7C7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Center(
                child: Text(
                  'DATA',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontFamily: 'Futura',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
