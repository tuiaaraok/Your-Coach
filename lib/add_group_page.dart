import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:trener/data/boxes.dart';
import 'package:trener/data/group.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({
    super.key,
  });

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  TextEditingController nameController = TextEditingController();
  String category = "";
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
  _updateFormCompletion() {
    bool isFilled = nameController.text.isNotEmpty && category != "";
    return isFilled;
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(_updateFormCompletion);
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
            child: SizedBox(
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Column(
                        children: [
                          Container(
                            width: 350.w,
                            height: 220.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name of the group",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        width: 300.w,
                                        height: 46.h,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2.h,
                                                color: const Color(0xFF019BBD)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.r)),
                                            color: const Color(0xFF019BBD)
                                                .withOpacity(0.25)),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 12.w),
                                          child: TextField(
                                            controller: nameController,
                                            decoration: const InputDecoration(
                                              border: InputBorder
                                                  .none, // Убираем обводку
                                              focusedBorder: InputBorder
                                                  .none, // Убираем обводку при фокусе
                                              hintText: 'Name',
                                            ),
                                            keyboardType: TextInputType.text,
                                            cursorColor: Colors.blue,
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Free or paid group",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 300.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                category = "Free";
                                              });
                                            },
                                            child: Container(
                                              width: 126.w,
                                              height: 42.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              12.r)),
                                                  color: category == "Free"
                                                      ? const Color(0xFF019BBD)
                                                      : const Color(0xFF019BBD)
                                                          .withOpacity(0.5)),
                                              child: Center(
                                                  child: Text(
                                                "Free",
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: Colors.white),
                                              )),
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                category = "Paid";
                                              });
                                            },
                                            child: Container(
                                              width: 126.w,
                                              height: 42.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              12.r)),
                                                  color: category == "Paid"
                                                      ? const Color(0xFF019BBD)
                                                      : const Color(0xFF019BBD)
                                                          .withOpacity(0.5)),
                                              child: Center(
                                                  child: Text(
                                                "Paid",
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: Colors.white),
                                              )),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: SizedBox(
                              width: 320.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 126.w,
                                        height: 42.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
                                            color: Colors.white),
                                        child: Center(
                                            child: Text(
                                          "Back",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: const Color(0xFF019BBD)),
                                        )),
                                      )),
                                  GestureDetector(
                                      onTap: () {
                                        if (_updateFormCompletion()) {
                                          Box<Group> contactsBox =
                                              Hive.box<Group>(HiveBoxes.group);
                                          Group addgroup = Group(
                                              nameGroup: nameController.text,
                                              category: category);
                                          contactsBox.add(addgroup);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        width: 126.w,
                                        height: 42.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
                                            color: _updateFormCompletion()
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    255, 151, 151, 151)),
                                        child: Center(
                                            child: Text(
                                          "Create",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: const Color(0xFF019BBD)),
                                        )),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
