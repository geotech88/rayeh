import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/formatters/format_date_and_time.dart';
import '../../../utils/helpers/app_text_style.dart';
// import '../../../utils/helpers/get_the_current_date.dart';
import '../../../utils/helpers/pick_a_date.dart';
import '../../../utils/helpers/pick_a_time.dart';
import '../../home_page/screens/home_text_field.dart';
import '../../provider/screens/custom_btn.dart';
import '../controllers/infos_bottom_sheet_controller.dart';
import '../controllers/tracking_controller.dart';
import '../controllers/tracking_infos_list_controller.dart';
import '../models/tracking_infos_model.dart';
import 'add_update_widget.dart';

Future<void> updateTrackingBottomSheet({
  required BuildContext cxt,
  required int trackerId,
}) async {
  final TrackingInfosListController trackingInfosCntr =
      Get.find<TrackingInfosListController>();
  final infosBottomSheetCntr = Get.put(InfosBottomSheetController());
  final trackingCntr = Get.put(TrackerController());

  String backendDate = RDateAndTimeFormatter.formatTheDateForBackend(
    date: DateTime.now(),
  );
  String backendTime = RDateAndTimeFormatter.formatTheTimeForBackend(
    time: TimeOfDay.now(),
  );

  infosBottomSheetCntr.setDate = backendDate;
  infosBottomSheetCntr.setTime = backendTime;

  // String currentDate = RDateAndTimeFormatter.getTheCurrentDate();
  // String currentTime = RDateAndTimeFormatter.getTheCurrentTime();
  final TextEditingController placeTxtFld = TextEditingController();

  // const String hint = 'جدة';
  final servicesDropdown = [
    S.of(cxt).purchaseProduct,
    S.of(cxt).delivereProduct,
  ];

  infosBottomSheetCntr.setSelectedService = servicesDropdown[0];

  return showModalBottomSheet(
    context: cxt,
    // showDragHandle: true,
    builder: (context) {
      return Obx(
        () => Container(
          // height: height * 0.6,
          // width: width,
          padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
          ),
          child: Column(
            children: [
              Text(
                S.of(context).addAnUpdate,
                style: arabicAppTextStyle(
                  RColors.rDark,
                  FontWeight.w600,
                  lgTxt,
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                children: [
                  Expanded(
                    child: addUpdateDesignedWidget(
                      context: context,
                      title: S.of(context).date,
                      icon: Icons.calendar_month,
                      label: Text(
                        infosBottomSheetCntr.date,
                        style: arabicAppTextStyle(
                          RColors.rGray,
                          FontWeight.w600,
                          smTxt,
                        ),
                      ),
                      onWidgetClicked: () async {
                        final pickedDate = await pickTheDate(cxt: context);
                        backendDate =
                            RDateAndTimeFormatter.formatTheDateForBackend(
                          date: pickedDate,
                        );
                        infosBottomSheetCntr.setDate = backendDate;
                        log(infosBottomSheetCntr.date);
                      },
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Expanded(
                    child: addUpdateDesignedWidget(
                      context: context,
                      title: S.of(context).time,
                      icon: Icons.access_time_outlined,
                      label: Text(
                        infosBottomSheetCntr.time,
                        style: arabicAppTextStyle(
                          RColors.rGray,
                          FontWeight.w600,
                          smTxt,
                        ),
                      ),
                      onWidgetClicked: () async {
                        // currentTime = await pickTheTime(cxt: context).toString();
                        final pickedTime = await pickTheTime(cxt: context);
                        backendTime =
                            RDateAndTimeFormatter.formatTheTimeForBackend(
                          time: pickedTime,
                        );
                        infosBottomSheetCntr.setDate = backendTime;
                        log(infosBottomSheetCntr.time);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: addUpdateDesignedWidget(
                      context: context,
                      title: S.of(context).place,
                      icon: Icons.location_on,
                      label:
                          // TODO: make this a select dropdown of cities or leave it like this
                          HomeTextField(
                        width: 85.w,
                        height: 20.h,
                        filledColor: Colors.transparent,
                        // filledColor: RColors.rGray.withOpacity(0.1),
                        txtColor: RColors.rGray,
                        borderColor: RColors.rGray,
                        textSize: smTxt,
                        txtFldCntr: placeTxtFld,
                        hintTxt: S.of(context).place,
                        isDisabeled: true,
                        isBorderEnabled: false,
                      ),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Expanded(
                    child: addUpdateDesignedWidget(
                      horPad: 5.w,
                      context: context,
                      title: S.of(context).update,
                      icon: Icons.refresh_outlined,
                      label: DropdownButton<String>(
                        // this to remove the extra padding
                        isDense: true,
                        // elevation: 0,
                        // padding: EdgeInsets.zero,
                        style: arabicAppTextStyle(
                          RColors.rGray,
                          FontWeight.w600,
                          xsmTxt,
                        ),
                        value: infosBottomSheetCntr.selectedService,
                        items: servicesDropdown
                            .map(
                              (item) => DropdownMenuItem<String>(
                                // the error that i face of multiple same values was because i didn't add the item to the value property
                                value: item,
                                child: Text(
                                  item,
                                  style: arabicAppTextStyle(
                                    RColors.rGray,
                                    FontWeight.w600,
                                    smTxt,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            infosBottomSheetCntr.setSelectedService = newValue;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.2),
              CustomBtn(
                btnText: S.of(context).confirmUpdate,
                svgPath: reloadIconPath,
                btnTxtSize: 12.sp,
                btnHeight: 40,
                onBtnTapped: () async {
                  Get.back(); // Close the bottom sheet
                  final newTrackingInfo = TrackingInfosModel(
                    trackerId: trackerId,
                    date: infosBottomSheetCntr.date,
                    time: infosBottomSheetCntr.time,
                    location: placeTxtFld.text,
                    status: infosBottomSheetCntr.selectedService,
                  );

                  // TODO: update the tracker to take the tracking infos model
                  // to simplify passing the data between the two.
                  final trackingInfosResponse =
                      await trackingCntr.updateTracker(
                    tracking: newTrackingInfo,
                    // id: trackerId.toString(),
                    // name: infosBottomSheetCntr.selectedService,
                    // date: backendDate,
                    // timing: infosBottomSheetCntr.time,
                  );
                  trackingInfosCntr.addTrackingInfo(newTrackingInfo);
                  log('test3 update tracker response : $trackingInfosResponse');
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
