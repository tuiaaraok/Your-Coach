import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:trener/add_group_page.dart';
import 'package:trener/data/boxes.dart';
import 'package:trener/data/group.dart';

class ListGroup extends StatefulWidget {
  const ListGroup({
    super.key,
  });

  @override
  State<ListGroup> createState() => _ListGroupState();
}

class _ListGroupState extends State<ListGroup> {
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
            child: ValueListenableBuilder(
                valueListenable: Hive.box<Group>(HiveBoxes.group).listenable(),
                builder: (context, Box<Group> box, _) {
                  return SizedBox(
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Add Group",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          for (int i = 0; i < box.length; i++) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Container(
                                width: 340.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10.w),
                                    SizedBox(
                                      width: 190.w,
                                      child: Text(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        box.getAt(i)!.nameGroup.toString(),
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 126.w,
                                      height: 42.h,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF019BBD),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.r))),
                                      child: Center(
                                        child: Text(
                                          box.getAt(i)!.category.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          if (box.length == 0)
                            Padding(
                              padding: EdgeInsets.only(bottom: 70.h),
                              child: Container(
                                width: 348.w,
                                height: 400.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.r))),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 256.w,
                                      height: 256.h,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/group_empty.png"))),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.h),
                                        child: Text(
                                          "You still don't have\ngroups",
                                          style: TextStyle(
                                              fontSize: 24.sp,
                                              color: const Color(0xFF019BBD)),
                                        ),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10.h),
                                          child: Text(
                                            "Create your first group",
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddGroupPage(),
                                    ));
                              },
                              child: Container(
                                width: 132.w,
                                height: 42.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    color: Colors.white),
                                child: Center(
                                  child: Text(
                                    "+Add",
                                    style: TextStyle(
                                        color: const Color(0xFF019BBD),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
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
                          SizedBox(height: 20.h), // Additional spacing
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
