import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:trener/data/boxes.dart';
import 'package:trener/data/group.dart';
import 'package:trener/data/traning.dart';

class AddTraningPage extends StatefulWidget {
  const AddTraningPage({super.key});

  @override
  State<AddTraningPage> createState() => _AddTraningPageState();
}

class _AddTraningPageState extends State<AddTraningPage> {
  List<FocusNode> focusNodes1 = [];
  List<TextEditingController> descriptionControllers = [];
  List<String> listName = [];
  int ll = -1;
  String selectName = "Select";
  bool isActive = false;
  bool isAdd = false;
  int currentIndex = -1;
  List<bool> isEditingList = [];

  @override
  void initState() {
    super.initState();
    Box<Group> contactsBox = Hive.box<Group>(HiveBoxes.group);
    listName = contactsBox.values
        .map((action) => action.nameGroup.toString())
        .toList();
  }

  bool _areAllFieldsFilled() {
    return descriptionControllers
            .every((controller) => controller.text.isNotEmpty) &&
        selectName != "Select";
  }

  @override
  void dispose() {
    for (var controller in descriptionControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes1) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _addNewTextField() {
    setState(() {
      focusNodes1.add(FocusNode());
      descriptionControllers.add(TextEditingController());
    });
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
              children: List.generate(200, (index) {
                int column = (index ~/ 10) % 20;
                return Opacity(
                  opacity: 0.5 - (column * 0.03).clamp(0.0, 0.5),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        colorFilter: ColorFilter.linearToSrgbGamma(),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          ValueListenableBuilder(
              valueListenable:
                  Hive.box<Traning>(HiveBoxes.traning).listenable(),
              builder: (context, Box<Traning> box, _) {
                return SafeArea(
                  child: KeyboardActions(
                    config: KeyboardActionsConfig(
                      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
                      nextFocus: true,
                      actions: focusNodes1.map((focusNode) {
                        return KeyboardActionsItem(
                          focusNode: focusNode,
                          displayDoneButton: true,
                        );
                      }).toList(),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.h),
                            Text(
                              "Training Plan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 20.h),
                            isAdd
                                ? Column(
                                    children: [
                                      Container(
                                        width: 340.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.r)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14.h, horizontal: 14.h),
                                          child: Column(
                                            children: [
                                              Text("Select a group",
                                                  style: TextStyle(
                                                      fontSize: 18.sp)),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                                child: Container(
                                                  width: 300.w,
                                                  height: 32.h,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF019BBD)
                                                            .withValues(
                                                                alpha: 0.25),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFF019BBD),
                                                        width: 2.h),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.r)),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 30.h,
                                                          height: 30.h,
                                                        ),
                                                        Text(
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          selectName,
                                                          style: TextStyle(
                                                              fontSize: 16.sp),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            isActive =
                                                                !isActive;
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            width: 30.h,
                                                            height: 30.h,
                                                            decoration: BoxDecoration(
                                                                image: isActive
                                                                    ? const DecorationImage(
                                                                        image: AssetImage(
                                                                            "assets/arrow_up.png"))
                                                                    : const DecorationImage(
                                                                        image: AssetImage(
                                                                            "assets/arrow_down.png"))),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (isActive)
                                                for (int j = 0;
                                                    j < listName.length;
                                                    j++) ...[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.h),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        selectName =
                                                            listName[j];
                                                        ll = j;
                                                        isActive = false;
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        width: 300.w,
                                                        height: 32.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black
                                                              .withValues(
                                                                  alpha: 0.25),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20.r)),
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                                listName[j],
                                                                style: TextStyle(
                                                                    fontSize: 16
                                                                        .sp))),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ...List.generate(
                                                  descriptionControllers.length,
                                                  (index) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.h),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                          width: 300.w,
                                                          child: Text(
                                                            "Training ${index + 1}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    18.sp),
                                                          )),
                                                      Container(
                                                        height: 180.h,
                                                        width: 300.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0xFF019BBD),
                                                              width: 2.h),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12.r)),
                                                          color: const Color(
                                                                  0xFF019BBD)
                                                              .withValues(
                                                                  alpha: 0.25),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w),
                                                          child: TextField(
                                                            minLines: 1,
                                                            maxLines:
                                                                5, // Set a maximum number of lines
                                                            controller:
                                                                descriptionControllers[
                                                                    index],
                                                            focusNode:
                                                                focusNodes1[
                                                                    index],
                                                            textInputAction:
                                                                TextInputAction
                                                                    .newline,
                                                            keyboardType:
                                                                TextInputType
                                                                    .multiline,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText: 'Empty',
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black
                                                                    .withValues(
                                                                        alpha:
                                                                            0.5),
                                                                fontSize: 18.sp,
                                                              ),
                                                            ),
                                                            cursorColor:
                                                                const Color(
                                                                    0xFF6C6D33),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18.sp,
                                                            ),
                                                            onChanged: (text) {
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                              GestureDetector(
                                                onTap: () {
                                                  _addNewTextField();
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
                                                        Radius.circular(12.r),
                                                      )),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 40.h,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.h),
                                        child: SizedBox(
                                          width: 320.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    isAdd = false;
                                                    selectName = "Select";
                                                    descriptionControllers
                                                        .clear();
                                                    focusNodes1.clear();
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
                                                        color: Colors.white),
                                                    child: Center(
                                                        child: Text(
                                                      "Back",
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: const Color(
                                                              0xFF019BBD)),
                                                    )),
                                                  )),
                                              GestureDetector(
                                                  onTap: () {
                                                    if (_areAllFieldsFilled()) {
                                                      Box<Traning> contactsBox =
                                                          Hive.box<Traning>(
                                                              HiveBoxes
                                                                  .traning);
                                                      Box<Group> contactsBoxGr =
                                                          Hive.box<Group>(
                                                              HiveBoxes.group);

                                                      // Extract text values from the TextEditingController instances
                                                      List<String>
                                                          descriptions =
                                                          descriptionControllers
                                                              .map(
                                                                  (controller) =>
                                                                      controller
                                                                          .text)
                                                              .toList();

                                                      Traning addgroup =
                                                          Traning(
                                                        nameGroup: selectName,
                                                        category: contactsBoxGr
                                                            .getAt(ll)
                                                            ?.category
                                                            .toString(),
                                                        description:
                                                            descriptions, // Pass the list of strings here
                                                      );

                                                      contactsBox.add(addgroup);
                                                    }
                                                    selectName = "Select";
                                                    descriptionControllers
                                                        .clear();
                                                    focusNodes1.clear();
                                                    isAdd = false;
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
                                                        color:
                                                            _areAllFieldsFilled()
                                                                ? Colors.white
                                                                : const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    151,
                                                                    151,
                                                                    151)),
                                                    child: Center(
                                                        child: Text(
                                                      "Create",
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: const Color(
                                                              0xFF019BBD)),
                                                    )),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
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
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 20.h),
                                              child: SizedBox(
                                                width: 320.w,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
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
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 150.h,
                                                      child: Text(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                            for (int y = 0;
                                                y <
                                                    box
                                                        .getAt(i)!
                                                        .description!
                                                        .length;
                                                y++) ...[
                                              Column(
                                                children: [
                                                  SizedBox(
                                                      width: 300.w,
                                                      child: Text(
                                                        "Training ${y + 1}",
                                                        style: TextStyle(
                                                            fontSize: 18.sp),
                                                      )),
                                                  Container(
                                                    height: 180.h,
                                                    width: 300.w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFF019BBD),
                                                          width: 2.h),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.r)),
                                                      color: const Color(
                                                              0xFF019BBD)
                                                          .withValues(
                                                              alpha: 0.25),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w),
                                                      child: TextField(
                                                        enabled:
                                                            isEditingList[y],
                                                        minLines: 1,
                                                        maxLines:
                                                            5, // Set a maximum number of lines
                                                        controller:
                                                            descriptionControllers[
                                                                y],
                                                        focusNode:
                                                            focusNodes1[y],
                                                        textInputAction:
                                                            TextInputAction
                                                                .newline,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: 'Empty',
                                                          hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black
                                                                .withValues(
                                                                    alpha: 0.5),
                                                            fontSize: 18.sp,
                                                          ),
                                                        ),
                                                        cursorColor:
                                                            const Color(
                                                                0xFF6C6D33),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.sp,
                                                        ),

                                                        onChanged: (text) {
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.h,
                                                            vertical: 5.h),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (isEditingList[
                                                                    y] ==
                                                                false) {
                                                            } else {
                                                              Box<Traning>
                                                                  contactsBoxGr =
                                                                  Hive.box<
                                                                          Traning>(
                                                                      HiveBoxes
                                                                          .traning);
                                                              List<String>
                                                                  descriptions =
                                                                  descriptionControllers
                                                                      .map((controller) =>
                                                                          controller
                                                                              .text)
                                                                      .toList();
                                                              contactsBoxGr.putAt(
                                                                  i,
                                                                  Traning(
                                                                      nameGroup: box
                                                                          .getAt(
                                                                              i)!
                                                                          .nameGroup
                                                                          .toString(),
                                                                      category: box
                                                                          .getAt(
                                                                              i)!
                                                                          .category
                                                                          .toString(),
                                                                      description:
                                                                          descriptions));
                                                            }
                                                            isEditingList[y] =
                                                                !isEditingList[
                                                                    y];
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 24.h,
                                                          height: 24.h,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: isEditingList[
                                                                              y] ==
                                                                          true
                                                                      ? Colors
                                                                          .green
                                                                      : const Color(
                                                                          0xFF019BBD),
                                                                  width: 2.h),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          24.r))),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 18.h,
                                                              color: isEditingList[
                                                                          y] ==
                                                                      true
                                                                  ? Colors.green
                                                                  : const Color(
                                                                      0xFF019BBD),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: 340.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r))),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.h),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
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
                                                SizedBox(
                                                  width: 180.w,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20.h),
                                                        child: SizedBox(
                                                          width: 200.w,
                                                          height: 20.sp,
                                                          child: Text(
                                                            textAlign:
                                                                TextAlign.end,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          descriptionControllers
                                                              .clear();
                                                          focusNodes1.clear();
                                                          isEditingList.clear();
                                                          Box<Traning>
                                                              contactsBoxGr =
                                                              Hive.box<Traning>(
                                                                  HiveBoxes
                                                                      .traning);
                                                          contactsBoxGr
                                                              .getAt(i)!
                                                              .description
                                                              ?.forEach(
                                                            (element) {
                                                              descriptionControllers.add(
                                                                  TextEditingController(
                                                                      text:
                                                                          element));
                                                              focusNodes1.add(
                                                                  FocusNode());
                                                              isEditingList
                                                                  .add(false);
                                                            },
                                                          );
                                                          setState(() {
                                                            isAdd = false;

                                                            currentIndex = i;
                                                          });
                                                        },
                                                        child: SizedBox(
                                                          width: 200.w,
                                                          child: Row(
                                                            children: [
                                                              const Spacer(),
                                                              const Icon(Icons
                                                                  .keyboard_arrow_down),
                                                              Text(
                                                                "Unfold",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: Colors
                                                                        .black
                                                                        .withValues(
                                                                            alpha:
                                                                                0.5)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                            if (box.length == 0 && !isAdd)
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
                                                    "assets/traning_empty.png"))),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10.h),
                                          child: Text(
                                            "You don't have a training\nplan yet",
                                            style: TextStyle(
                                                fontSize: 24.sp,
                                                color: const Color(0xFF019BBD)),
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.h),
                                            child: Text(
                                              "Create your first workout plan",
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Colors.black
                                                      .withValues(alpha: 0.5)),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  isAdd = true;
                                  focusNodes1.clear();
                                  currentIndex = -1;
                                  selectName = "Select";
                                  focusNodes1.clear();
                                  descriptionControllers.clear();
                                  focusNodes1.add(FocusNode());
                                  descriptionControllers
                                      .add(TextEditingController());
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
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
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
