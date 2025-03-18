import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trener/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<String> assetImage = [
    "assets/onbording_first.png",
    "assets/onboarding_second.png"
  ];
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

  final int _numPages = 2;
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: isActive ? 6.0.h : 6.h,
      width: isActive ? 35.w : 20.h,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    },
                    child: Container(
                      width: 100.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      child: Center(
                        child: Text(
                          "Skip",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 450.w,
                height: 350.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(assetImage[_currentPage]))),
              ),
              SizedBox(
                width: 340.w,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 15.h, left: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _buildPageIndicator(),
                  ),
                ),
              ),
              SizedBox(
                width: 340.w,
                child: Text(
                  "Create student groups that\nyou are comfortable with",
                  style: TextStyle(fontSize: 24.sp, color: Colors.white),
                ),
              ),
              SizedBox(
                  width: 340.w,
                  child: Text(
                    "Add students to different groups,\ndivide them in a convenient menu,\nwrite out a training plan for each\ngroup separately",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white.withValues(alpha: 0.5)),
                  )),
              SizedBox(
                height: 60.h,
              ),
              GestureDetector(
                onTap: () {
                  if (_currentPage == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  } else {
                    _currentPage += 1;
                    setState(() {});
                  }
                },
                child: Container(
                  width: 320.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.r))),
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Terms of use",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.sp),
                        child: Container(
                          width: 1,
                          height: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
