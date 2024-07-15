import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common/shimmers/services_shimmer.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/app_text_style.dart';
import '../home_page/controllers/json_cities_data_controller.dart';
import '../home_page/screens/direction_wiget.dart';
// import '../post_service/models/user_model.dart';
import '../post_service/models/trip_model.dart';
import '../provider/provider_page.dart';
import 'controllers/provided_service_controller.dart';
import 'screens/provider_offer_widget.dart';
import 'screens/services_app_bar.dart';

class ProvidedServicesPage extends StatelessWidget {
  const ProvidedServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final citiesData = Get.find<CountriesAndCitiesController>();
    final localizationCntr = Get.find<LocalizationController>();
    final providedOffersCntr = Get.put(ProvidedServiceController());

    final TextEditingController firstTxtFld = TextEditingController();
    final TextEditingController secondTxtFld = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 15.h,
                left: 15.w,
                top: 80.h,
                bottom: 15.h,
              ),
              child: const ServicesAppBar(),
            ),
            Row(
              children: [
                SizedBox(width: width * 0.35),
                Icon(Icons.location_on, size: 15.h, color: RColors.rGray),
                SizedBox(width: 5.w),
                Text(
                  S.of(context).choosedLocation,
                  style: arabicAppTextStyle(
                    RColors.rGray,
                    FontWeight.w500,
                    12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            DirectionWidget(
              firstHintTxt: citiesData.fstSelectedCity!,
              firstTxtFldCntr: firstTxtFld,
              secondTxtFldCntr: secondTxtFld,
              secondHintTxt: citiesData.sndSelectedCity!,
              isEnabled: false,
            ),
            SizedBox(height: 20.h),
            Container(
              width: width,
              height: 50.h,
              color: RColors.rWhite,
              // padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backArrowDependsOnLang(
                    ctx: context,
                    padHoriz: 15.w,
                    padVert: 10.h,
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
                  //           height: 20.h,
                  //           width: 20.h,
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
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 15.h,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            editIconPath,
                            color: RColors.primary,
                            height: 20.h,
                            width: 20.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            S.of(context).edit,
                            style: arabicAppTextStyle(
                              RColors.primary,
                              FontWeight.w600,
                              13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                SizedBox(width: 25.w),
                Text(
                  // textDirection: TextDirection.rtl,
                  S.of(context).availableOffers,
                  style: arabicAppTextStyle(
                    RColors.rDark,
                    FontWeight.w600,
                    12.sp,
                  ),
                ),
              ],
            ),
            Obx(
              () => SizedBox(
                height: height * 0.65,
                child: providedOffersCntr.isProvidedOffersLoading
                    ? ListView.builder(
                        itemCount: 4,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                            child: const ServicesShimmer(),
                          );
                        },
                      )
                    : providedOffersCntr.providedTrips?.trips.isEmpty ?? true
                        ? Center(
                            child: Text(
                              "No Offers available",
                              style: arabicAppTextStyle(
                                RColors.primary,
                                FontWeight.w500,
                                smTxt,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount:
                                providedOffersCntr.providedTrips?.trips.length,
                            itemBuilder: (ctx, i) {
                              // User user = User(
                              //   id: 1,
                              //   auth0UserId: "1",
                              //   name: "",
                              //   email: "",
                              //   profession: "",
                              //   path: "",
                              //   createdAt: "",
                              //   updatedAt: "",
                              // );
                              Trip offeredTrip =
                                  providedOffersCntr.providedTrips!.trips[i];
                              return Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                                child: ProviderOfferWidget(
                                  trip: offeredTrip,
                                  onBtnTapped: () {
                                    Get.to(
                                      () =>
                                          ProviderPage(offerTrip: offeredTrip),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
