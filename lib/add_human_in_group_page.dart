import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:trener/add_group_page.dart';
import 'package:trener/data/boxes.dart';
import 'package:trener/data/group.dart';

class AddHumanInGroupPage extends StatefulWidget {
  const AddHumanInGroupPage({super.key});

  @override
  State<AddHumanInGroupPage> createState() => _AddHumanInGroupPageState();
}

class _AddHumanInGroupPageState extends State<AddHumanInGroupPage> {
  int currentIndex = -1;
  List<TextEditingController> nameController = [];
  List<bool> active = [];
  bool _areAllFieldsFilled() {
    for (var controller in nameController) {
      if (controller.text.isEmpty) return false;
    }
    return true;
  }

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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ValueListenableBuilder(
                        valueListenable:
                            Hive.box<Group>(HiveBoxes.group).listenable(),
                        builder: (context, Box<Group> box, _) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "List of Students and Groups ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                              for (int i = box.length - 1; i >= 0; i--) ...[
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: currentIndex == i
                                      ? Container(
                                          width: 340.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.r))),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 14.h,
                                                horizontal: 14.h),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 340.w,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 185.w,
                                                        child: Text(
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          box
                                                              .getAt(i)!
                                                              .nameGroup
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        width: 126.w,
                                                        height: 42.h,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xFF019BBD),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12.r))),
                                                        child: Center(
                                                          child: Text(
                                                            "Free",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Divider(
                                                  height: 1.h,
                                                  color:
                                                      const Color(0xFF019BBD),
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "Came to practice?",
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontSize: 8.sp),
                                                    )),
                                                for (int j = 0;
                                                    j < nameController.length;
                                                    j++) ...[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 200.w,
                                                          height: 42.h,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 2.h,
                                                                  color: const Color(
                                                                      0xFF019BBD)),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(10
                                                                          .r)),
                                                              color: const Color(
                                                                      0xFF019BBD)
                                                                  .withOpacity(
                                                                      0.25)),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 12.w),
                                                            child: TextField(
                                                              controller:
                                                                  nameController[
                                                                      j],
                                                              decoration:
                                                                  const InputDecoration(
                                                                border: InputBorder
                                                                    .none, // Убираем обводку
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none, // Убираем обводку при фокусе
                                                                hintText:
                                                                    'Name',
                                                              ),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              cursorColor:
                                                                  Colors.blue,
                                                              onChanged:
                                                                  (text) {
                                                                setState(() {});
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        StyledSwitch(
                                                          active: active[j],
                                                          onToggled:
                                                              (bool isToggled) {
                                                            active[j] =
                                                                isToggled;
                                                            setState(() {});
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      active.add(false);
                                                      nameController.add(
                                                          TextEditingController());
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      width: 42.h,
                                                      height: 42.h,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFF019BBD),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                12.r),
                                                          )),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 40.h,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        if (_areAllFieldsFilled()) {
                                                          List<String> names =
                                                              [];
                                                          for (int f = 0;
                                                              f <
                                                                  nameController
                                                                      .length;
                                                              f++) {
                                                            if (active[f]) {
                                                              names.add(
                                                                  nameController[
                                                                          f]
                                                                      .text);
                                                            }
                                                          }
                                                          box.putAt(
                                                              i,
                                                              Group(
                                                                  nameGroup: box
                                                                      .getAt(i)!
                                                                      .nameGroup,
                                                                  category: box
                                                                      .getAt(i)!
                                                                      .category,
                                                                  humans:
                                                                      names));
                                                          currentIndex = -1;
                                                          nameController
                                                              .clear();
                                                          active.clear();
                                                        }
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        width: 126.w,
                                                        height: 42.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12.r)),
                                                            color: const Color(
                                                                0xFF019BBD)),
                                                        child: Center(
                                                            child: Text(
                                                          "Create",
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              color: nameController
                                                                      .isNotEmpty
                                                                  ? _areAllFieldsFilled()
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black
                                                                  : Colors
                                                                      .black),
                                                        )),
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            currentIndex = i;
                                            nameController.clear();
                                            if (box.getAt(i)!.humans != null) {
                                              for (var action
                                                  in box.getAt(i)!.humans!) {
                                                active.add(true);
                                                nameController.add(
                                                    TextEditingController(
                                                        text: action));
                                              }
                                            }
                                            setState(() {});
                                          },
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    box
                                                        .getAt(i)!
                                                        .nameGroup
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  width: 126.w,
                                                  height: 42.h,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF019BBD),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.r))),
                                                  child: Center(
                                                    child: Text(
                                                      box
                                                          .getAt(i)!
                                                          .category
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                              ],
                                            ),
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
                                            padding:
                                                EdgeInsets.only(left: 10.h),
                                            child: Text(
                                              "You still don't have\ngroups",
                                              style: TextStyle(
                                                  fontSize: 24.sp,
                                                  color:
                                                      const Color(0xFF019BBD)),
                                            ),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.h),
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
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (box.length == 0) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const AddGroupPage(),
                                        ),
                                      );
                                    }

                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r)),
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
                          );
                        }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StyledSwitch extends StatefulWidget {
  final void Function(bool isToggled) onToggled;
  final bool active;

  const StyledSwitch(
      {super.key, required this.onToggled, required this.active});

  @override
  State<StyledSwitch> createState() => _StyledSwitchState();
}

class _StyledSwitchState extends State<StyledSwitch> {
  bool? isToggled;
  double size = 30.w;
  double innerPadding = 0;

  @override
  void initState() {
    innerPadding = size / 10;
    isToggled = widget.active;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isToggled = !isToggled!);
        widget.onToggled(isToggled!);
      },
      onPanEnd: (b) {
        setState(() => isToggled = !isToggled!);
        widget.onToggled(isToggled!);
      },
      child: AnimatedContainer(
        height: size,
        width: 73.w,
        padding: EdgeInsets.all(innerPadding),
        alignment: !isToggled! ? Alignment.centerLeft : Alignment.centerRight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color:
              !isToggled! ? const Color(0xFF7D0505) : const Color(0xFF26BD00),
        ),
        child: Container(
          width: size - innerPadding * 2,
          height: size - innerPadding * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color:
                !isToggled! ? const Color(0xFFDA0000) : const Color(0xFF008405),
          ),
        ),
      ),
    );
  }
}
