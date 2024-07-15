import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common/widgets/icon_and_text_widget.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
// import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/formatters/format_date_and_time.dart';
import '../../utils/helpers/app_text_style.dart';
import '../../utils/helpers/get_the_current_date.dart';
import '../../utils/helpers/pick_a_date.dart';
import '../create_offer/screens/container_bg_widget.dart';
import '../home_page/controllers/json_cities_data_controller.dart';
// import '../home_page/screens/app_bar.dart';
// import '../home_page/screens/direction_wiget.dart';
import '../home_page/screens/direction_wiget_dropdown.dart';
import '../provider/provider_page.dart';
import '../provider/screens/custom_btn.dart';
import '../services/screens/services_app_bar.dart';
import '../tracking_page/screens/add_update_widget.dart';
import 'controllers/post_service_controller.dart';
import 'models/provider_model.dart';
import 'models/trip_model.dart';
// import 'models/user_model.dart';
import 'screens/more_infos_text_field.dart';

class PostServicePage extends StatelessWidget {
  final bool isUpdatePost;
  final ProviderModel? updatedTrip;

  const PostServicePage({
    super.key,
    this.isUpdatePost = false,
    this.updatedTrip,
  });

  @override
  Widget build(BuildContext context) {
    final citiesData = Get.find<CountriesAndCitiesController>();
    final localizationCntr = Get.find<LocalizationController>();
    final postServiceCntr = Get.put(PostServiceController());

    postServiceCntr.setDate = GetDateAndTime.getTheCurrentDate();
    String backendDate = RDateAndTimeFormatter.formatTheDateForBackend(
      date: DateTime.now(),
    );

    // final TextEditingController fstDirectionTxtFld = TextEditingController();
    // final TextEditingController sndDirectionTxtFld = TextEditingController();
    final TextEditingController moreInfosTxtFld = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
              // child: const CustomAppBar(),
              child: const ServicesAppBar(),
            ),
            SizedBox(height: 20.h),
            Container(
              width: width,
              height: 50.h,
              color: RColors.rWhite,
              // padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  backArrowDependsOnLang(
                    ctx: context,
                    padHoriz: 15.w,
                    padVert: 15.h,
                    isArabic: localizationCntr.isArabic,
                    withText: true,
                    text: S.of(context).back,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Transform(
                  //         alignment: Alignment.center,
                  //         transform: Matrix4.rotationY(
                  //           3.14159,
                  //         ), // 180 degrees in radians
                  //         child: SvgPicture.asset(
                  //           backArrowIconPath,
                  //           color: RColors.primary,
                  //           height: 18.h,
                  //           width: 18.h,
                  //         ),
                  //       ),
                  //       SizedBox(width: 10.w),
                  //       Text(
                  //         S.of(context).back,
                  //         style: arabicAppTextStyle(
                  //           RColors.primary,
                  //           FontWeight.w600,
                  //           13.sp,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: designedContainerWidget(
                containerWidth: width,
                horPadding: 15.w,
                verPadding: 25.h,
                content: Column(
                  children: [
                    IconAndTextWidget(
                      icon: Icons.location_on,
                      iconSize: 15.h,
                      text: S.of(context).direction,
                      textSize: lgTxt,
                    ),
                    SizedBox(height: 25.h),
                    // DirectionWidget(
                    //   firstHintTxt: citiesData.fstSelectedCity!,
                    //   firstTxtFldCntr: fstDirectionTxtFld,
                    //   secondTxtFldCntr: sndDirectionTxtFld,
                    //   secondHintTxt: citiesData.sndSelectedCity!,
                    //   isEnabled: true,
                    //   // width: 58.w,
                    //   // height: 20.h,
                    //   // iconHeight: 12.h,
                    //   // iconWidth: 12.h,
                    //   textSize: mdTxt,
                    // ),
                    Obx(
                      () {
                        // this log is neccessary for the dropdown to work .
                        log("in homepage direction dropdown ${citiesData.citiesList.length}");
                        return DirectionDropDownWidget(
                          dropDownWidth: 120.w,
                          dropDownCitiesListItems: citiesData.citiesList,
                          fstDropDownSelectedValue: citiesData.fstSelectedCity,
                          sndDropDownSelectedValue: citiesData.sndSelectedCity,
                          // dropDownHint: countryCitiesController.selectedCountry,
                          dropDownTxtFieldHint: S.of(context).searchForCity,
                          dropDownPadHor: 15.w,
                          dropDownPadVert: 0,
                          onFstSelected: (value) {
                            if (value != null) {
                              citiesData.setFstSelectedCity = value;
                            }
                          },
                          onSndSelected: (value) {
                            if (value != null) {
                              citiesData.setSndSelectedCity = value;
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => addUpdateDesignedWidget(
                        bgColor: RColors.rWhite,
                        context: context,
                        title: S.of(context).date,
                        icon: Icons.calendar_month,
                        label: Text(
                          postServiceCntr.date,
                          style: arabicAppTextStyle(
                            RColors.rGray,
                            FontWeight.w600,
                            smTxt,
                          ),
                        ),
                        onWidgetClicked: () async {
                          final pickedDate = await pickTheDate(cxt: context);
                          postServiceCntr.setDate =
                              RDateAndTimeFormatter.formatTheDate(
                            date: pickedDate,
                          );
                          backendDate =
                              RDateAndTimeFormatter.formatTheDateForBackend(
                            date: pickedDate,
                          );
                          // log(backendDate);
                          // log(postServiceCntr.date);
                        },
                      ),
                    ),
                  ),
                  // to make a widget has the same size to place the date in the right
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: MoreInfosTextField(
                width: width,
                height: 200.h,
                txtFldCntr: moreInfosTxtFld,
                hintTxt: S.of(context).postOfferDesc,
                isDisabeled: true,
                isBorderEnabled: false,
                txtColor: RColors.rDark,
                hintTxtColor: RColors.rGray,
                borderColor: RColors.rGray,
                filledColor: RColors.rWhite,
              ),
            ),
            SizedBox(height: height * 0.15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: CustomBtn(
                btnText:
                    isUpdatePost ? S.of(context).update : S.of(context).post,
                btnTxtSize: 13.sp,
                btnHeight: 40,
                onBtnTapped: () async {
                  // User user = User(
                  //   id: 1,
                  //   auth0UserId: "1",
                  //   name: "Khalid",
                  //   email: "khalid",
                  //   profession: "Developer",
                  //   path: "path",
                  //   createdAt: "",
                  //   updatedAt: "",
                  // );
                  if (!isUpdatePost) {
                    final Trip tripInfos = Trip(
                      from: citiesData.fstSelectedCity!,
                      to: citiesData.sndSelectedCity!,
                      date: backendDate,
                      description: moreInfosTxtFld.text,
                      // user: user,
                    );
                    // log(backendDate);
                    ProviderModel? providerTripInfos =
                        await postServiceCntr.createTrip(tripInfos);
                    if (postServiceCntr.isTripCreated) {
                      Get.offAll(() => ProviderPage(
                            providerTrip: providerTripInfos!,
                          ));
                      // Get.offAll(() => ProviderPage(trip: tripInfos));
                    }
                  } else {
                    final Trip tripInfos = Trip(
                      id: updatedTrip?.newTrip.id,
                      from: citiesData.fstSelectedCity!,
                      to: citiesData.sndSelectedCity!,
                      date: backendDate,
                      description: moreInfosTxtFld.text,
                      // user: user,
                    );
                    log("updated trip id ${updatedTrip?.newTrip.id}");
                    ProviderModel? updateTrip =
                        await postServiceCntr.updateProviderTrip(
                      tripInfos,
                      updatedTrip!,
                    );
                    // Trip? updateTrip = await postServiceCntr.updateTrip(
                    //     updatedTrip!.id!, tripInfos);

                    if (postServiceCntr.isTripUpdated) {
                      Get.offAll(() => ProviderPage(providerTrip: updateTrip!));
                      // Get.offAll(() => ProviderPage(trip: tripInfos));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
