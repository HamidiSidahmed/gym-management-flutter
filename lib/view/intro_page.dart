import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_sof/controller/data_controller.dart';
import 'package:gym_sof/controller/fire_base_controller.dart';
import 'package:gym_sof/view/home_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    Data data_controller = Get.put(Data());
    FireBaseController fire_base_controller = Get.put(FireBaseController());
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: Center(
            child: Container(
              width: 1.sw,
              height: 1.sh,
              decoration: const BoxDecoration(
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
              begin: const Alignment(0.00, -1.00),
              end: const Alignment(0, 1),
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
            decoration: const BoxDecoration(
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
              Get.to(() => HomePage(),
                  transition: Transition.fade,
                  duration: const Duration(milliseconds: 150));
            },
            child: Container(
              width: 204.w,
              height: 50.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFC7C7C7),
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
                shape: const RoundedRectangleBorder(
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
                            onTap: () async {
                              Navigator.pop(context);

                              List<ConnectivityResult> connectivityResult =
                                  await Connectivity().checkConnectivity();
                              if ((connectivityResult
                                  .contains(ConnectivityResult.none))) {
                                Get.showSnackbar(const GetSnackBar(
                                  message: "Check your internet connection",
                                  animationDuration: Duration(seconds: 1),
                                  duration: Duration(seconds: 3),
                                ));
                              } else if ((connectivityResult
                                      .contains(ConnectivityResult.wifi)) ||
                                  (connectivityResult
                                      .contains(ConnectivityResult.mobile))) {
                                Get.showSnackbar(const GetSnackBar(
                                  message: "Restoring Data",
                                  duration: Duration(seconds: 3),
                                ));
                                if (await fire_base_controller.isOffline() ==
                                    false) {
                                  try {
                                    await fire_base_controller
                                        .get_data(data_controller);
                                    Get.showSnackbar(const GetSnackBar(
                                      message: "Data restored successfully",
                                      duration: Duration(seconds: 3),
                                    ));
                                  } catch (e) {
                                    Get.showSnackbar(const GetSnackBar(
                                      message: "Cant' resote data",
                                      duration: Duration(seconds: 3),
                                    ));
                                  }
                                } else {
                                  Get.showSnackbar(const GetSnackBar(
                                    message: "check your connection and try again",
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              }
                            },
                            child: Text(
                              'Restore',
                              style: TextStyle(
                                color: const Color(0xFF242222),
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
                            onTap: () async {
                              Navigator.pop(context);

                              List<ConnectivityResult> connectivityResult =
                                  await Connectivity().checkConnectivity();
                              if ((connectivityResult
                                  .contains(ConnectivityResult.none))) {
                                Get.showSnackbar(const GetSnackBar(
                                  message: "Check your internet connection",
                                  animationDuration: Duration(seconds: 1),
                                  duration: Duration(seconds: 3),
                                ));
                              } else if ((connectivityResult
                                      .contains(ConnectivityResult.wifi)) ||
                                  (connectivityResult
                                      .contains(ConnectivityResult.mobile))) {
                                Get.showSnackbar(const GetSnackBar(
                                  message: "Adding data",
                                  animationDuration: Duration(seconds: 1),
                                  duration: Duration(seconds: 3),
                                ));
                                  if(await fire_base_controller.isOffline()==false) {
                                    try {
                                  await fire_base_controller
                                      .upload_images(data_controller.myBox);
                                  await fire_base_controller
                                      .upload_member_doc(data_controller.myBox);

                                  Get.showSnackbar(const GetSnackBar(
                                    message: "Data added",
                                    animationDuration: Duration(seconds: 1),
                                    duration: Duration(seconds: 3),
                                  ));
                                } catch (e) {
                                  print(e);
                                  Get.showSnackbar(const GetSnackBar(
                                    message: "Can't added data try again",
                                    animationDuration: Duration(seconds: 1),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                                  }
                                  else{Get.showSnackbar(const GetSnackBar(
                                    message: "Can't added check your connection",
                                    animationDuration: Duration(seconds: 1),
                                    duration: Duration(seconds: 3),
                                  ));}
                              }
                            },
                            child: Text(
                              'Backup',
                              style: TextStyle(
                                color: const Color(0xFF242222),
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
                color: const Color(0xFFC7C7C7),
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
