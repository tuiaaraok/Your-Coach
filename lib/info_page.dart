import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({
    super.key,
  });

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  TextEditingController namecontroller = TextEditingController();
  bool changeName = false;
  late Box box;
  List<Widget> calendarCells = List<Widget>.generate(200, (index) {
    int column = (index ~/ 10) % 20;
    double opacity = 0.5 - (column * 0.03).clamp(0.0, 0.5);

    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"),
                colorFilter: ColorFilter.linearToSrgbGamma())),
      ),
    );
  });
  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    box = await Hive.openBox("name"); // Теперь используется await
    if (box.isNotEmpty) {
      namecontroller.text = box.getAt(0) ?? '';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 10,
              children: calendarCells,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Settings",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: 140.w,
                    height: 154.h,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/profile.png"),
                            fit: BoxFit.fitHeight)),
                  ),
                  SizedBox(
                    height: 33.h,
                    child: Stack(
                      children: [
                        Center(
                            child: SizedBox(
                                width: 100.w,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: namecontroller,
                                  decoration: InputDecoration(
                                      hintText: 'Edit Name',
                                      enabled: changeName,
                                      border: InputBorder
                                          .none, // Убираем линию внизу
                                      hintStyle: TextStyle(
                                          color: const Color(0xFF035668),
                                          fontSize: 18.sp)),
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.transparent,
                                  style: TextStyle(
                                      color: const Color(0xFF035668),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ))),
                        Positioned(
                          top: 0,
                          right: 130.w,
                          child: GestureDetector(
                            onTap: () {
                              changeName = !changeName;
                              if (changeName == false) {
                                if (box.isEmpty) {
                                  box.add(namecontroller.text);
                                } else {
                                  box.putAt(0, namecontroller.text);
                                }
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: 17.h,
                              height: 17.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: changeName
                                          ? Colors.green
                                          : const Color(0xFF019BBD),
                                      width: 1.h),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.r))),
                              child: Center(
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 13.h,
                                  color: changeName
                                      ? Colors.green
                                      : const Color(0xFF019BBD),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: GestureDetector(
                      onTap: () async {
                        String? encodeQueryParameters(
                            Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }

                        // ···
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'scurcironca@gmail.com',
                          query: encodeQueryParameters(<String, String>{
                            '': '',
                          }),
                        );
                        try {
                          if (await canLaunchUrl(emailLaunchUri)) {
                            await launchUrl(emailLaunchUri);
                          } else {
                            throw Exception("Could not launch $emailLaunchUri");
                          }
                        } catch (e) {
                          log('Error launching email client: $e'); // Log the error
                        }
                      },
                      child: Container(
                        width: 310.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 21.h + 10.w,
                            ),
                            Expanded(
                              child: Text(
                                "Contact us",
                                style: TextStyle(
                                    color: const Color(0xFF019BBD),
                                    fontSize: 20.sp),
                                textAlign: TextAlign.center, // Центрируем текст
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: const Color(0xFF019BBD),
                                size: 21.h,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse(
                            'https://docs.google.com/document/d/1xK4q4lau_HIcLBja_U3wN-6-apHCm5dQkgpqntALP6k/mobilebasic');
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Container(
                        width: 310.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 21.h + 10.w,
                            ),
                            Expanded(
                              child: Text(
                                "Privacy policy",
                                style: TextStyle(
                                    color: const Color(0xFF019BBD),
                                    fontSize: 20.sp),
                                textAlign: TextAlign.center, // Центрируем текст
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: const Color(0xFF019BBD),
                              size: 21.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: GestureDetector(
                      onTap: () async {
                        LaunchReview.launch(iOSAppId: "6737334979");
                      },
                      child: Container(
                        width: 310.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 21.h + 10.w,
                            ),
                            Expanded(
                              child: Text(
                                "Rate us",
                                style: TextStyle(
                                    color: const Color(0xFF019BBD),
                                    fontSize: 20.sp),
                                textAlign: TextAlign.center, // Центрируем текст
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: const Color(0xFF019BBD),
                              size: 21.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60.h),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 32.r,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Icon(
                            IconsaxPlusLinear.home,
                            size: 27.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h), // A
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
