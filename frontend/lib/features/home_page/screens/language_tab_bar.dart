import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../controllers/language_tab_controller.dart';
// import '../controllers/service_tab_controller.dart';

// class TabBarWidget extends StatelessWidget {
//   final TabController? tabCntr;
//   // final ServiceTabController serviceTabCntr;
//   final void Function(int)? onTabClicked;
//   final List<String> tabValues;
//   final double txtSize;
//   final FontWeight? fontWeight;

//   const TabBarWidget({
//     super.key,
//     required this.tabCntr,
//     // required this.serviceTabCntr,
//     required this.tabValues,
//     required this.onTabClicked,
//     required this.txtSize,
//     this.fontWeight,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: TabBar(
//         indicatorSize: TabBarIndicatorSize.tab,
//         controller: tabCntr,
//         indicator: BoxDecoration(
//           color: RColors.primary,
//           borderRadius: BorderRadius.all(Radius.circular(13.r)),
//         ),
//         labelColor: RColors.rWhite,
//         unselectedLabelColor: RColors.primary,
//         // this padding solve the problem of the overflow of the text and the disappear of the text of lang tabs.
//         labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
//         // onTap: (value) {
//         //   serviceTabCntr.setSelectedService = value;
//         // },
//         onTap: onTabClicked,
//         tabs: List.generate(
//           tabCntr?.length ?? tabValues.length,
//           (index) => Text(
//             tabValues[index],
//             style: arabicAppTextStyle(
//               null,
//               fontWeight ?? FontWeight.w500,
//               txtSize.sp,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class TabBarWidget extends StatefulWidget {
  final void Function(int)? onTabClicked;
  final List<String> tabValues;
  final double txtSize;
  final FontWeight? fontWeight;

  const TabBarWidget({
    super.key,
    required this.tabValues,
    required this.onTabClicked,
    required this.txtSize,
    this.fontWeight,
  });

  @override
  TabBarWidgetState createState() => TabBarWidgetState();
}

class TabBarWidgetState extends State<TabBarWidget> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabValues.length,
      vsync: this,
      // Set the initial index according to the selected language
      initialIndex: Get.find<LanguageTabController>().selectedLanguage,
    );
    _tabController!.addListener(() {
      if (!_tabController!.indexIsChanging) {
        widget.onTabClicked?.call(_tabController!.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        controller: _tabController,
        indicator: BoxDecoration(
          color: RColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(13.r)),
        ),
        labelColor: RColors.rWhite,
        unselectedLabelColor: RColors.primary,
        labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
        tabs: List.generate(
          widget.tabValues.length,
          (index) => Text(
            widget.tabValues[index],
            style: arabicAppTextStyle(
              null,
              widget.fontWeight ?? FontWeight.w500,
              widget.txtSize.sp,
            ),
          ),
        ),
      ),
    );
  }
}