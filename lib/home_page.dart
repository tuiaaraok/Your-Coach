import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:trener/add_human_in_group_page.dart';
import 'package:trener/add_traning_page.dart';
import 'package:trener/info_page.dart';
import 'package:trener/list_group.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    width: 400.h,
                    height: 400.h,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/home.png"),
                    )),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ListGroup(),
                                ));
                          },
                          child: Container(
                            width: 290.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.r)),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                "Add group",
                                style: TextStyle(
                                    color: const Color(0xFF019BBD),
                                    fontSize: 18.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddHumanInGroupPage(),
                                ));
                          },
                          child: Container(
                            width: 290.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.r)),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                "List of Students and Groups ",
                                style: TextStyle(
                                    color: const Color(0xFF019BBD),
                                    fontSize: 18.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddTraningPage(),
                                ));
                          },
                          child: Container(
                            width: 290.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.r)),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                "Training Plan",
                                style: TextStyle(
                                    color: const Color(0xFF019BBD),
                                    fontSize: 18.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InfoPage(),
                            ));
                      },
                      child: CircleAvatar(
                        radius: 32.r,
                        backgroundColor: Colors.white,
                        child: Icon(
                          IconsaxPlusLinear.setting_3,
                          size: 32.r,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
