import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../bindings/navigation_menu_controller.dart';
import '../../common/shimmers/provider_page_shimmers/provider_prev_trip_shimmer.dart';
import '../../common/shimmers/provider_page_shimmers/provider_profile_shimmer.dart';
import '../../common/widgets/icons_depends_on_lang.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../navigation_menu.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/app_text_style.dart';
import '../home_page/controllers/json_cities_data_controller.dart';
import '../home_page/controllers/service_tab_controller.dart';
import '../home_page/screens/direction_wiget.dart';
import '../message_page/chat_page.dart';
// import '../post_service/models/trip_model.dart';
import '../post_service/controllers/post_service_controller.dart';
// import '../post_service/models/trip_model.dart';
// import '../post_service/models/user_model.dart';
import '../post_service/models/provider_model.dart';
import '../post_service/models/trip_model.dart';
import '../post_service/post_service_page.dart';
// import '../services/models/services_model.dart';
import '../services/screens/concatenating_text_widget.dart';
import '../services/screens/provider_infos_widget.dart';
import '../services/screens/services_app_bar.dart';
import '../services/screens/show_more_btn.dart';
import 'controllers/provider_controller.dart';
import 'more_reviews_page.dart';
import 'screens/custom_btn.dart';
import 'screens/previous_flights_widget.dart';
import 'screens/user_reviews_widget.dart';

class ProviderPage extends StatelessWidget {
  // final User user;
  final ProviderModel? providerTrip;
  // final ProviderModel providerTrip;
  final Trip? offerTrip;

  const ProviderPage({
    super.key,
    // required this.user,
    this.offerTrip,
    this.providerTrip,
    // required this.providerTrip,
  });

// in this page if it's requester then the previous trips and reviews should be of the one who offers this trip,
// and if it's provider then the previous trips should be the provider trips and reviews that comes
// in the response of the create trip.

  @override
  Widget build(BuildContext context) {
    final serviceTabCntr = Get.find<ServiceTabController>();
    final citiesData = Get.find<CountriesAndCitiesController>();
    final navigationCntr = Get.find<NavigationMenuController>();
    final postServiceCntr = Get.put(PostServiceController());
    final providerPageCntr = Get.put(ProviderPageController());
    final localizationCntr = Get.find<LocalizationController>();

    final bool isRequester = serviceTabCntr.selectedService == 0;
    if (isRequester) {
      providerPageCntr.auth0ProviderUserId.value = offerTrip!.user!.auth0UserId;
    }

    final TextEditingController firstTxtFld = TextEditingController();
    final TextEditingController secondTxtFld = TextEditingController();

    return Scaffold(
      body: Column(
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
            // mainAxisAlignment: MainAxisAlignment.center,
            // textDirection: TextDirection.rtl,
            children: [
              SizedBox(width: width * 0.35),
              Icon(Icons.location_on, size: 15.h),
              SizedBox(width: 5.w),
              Text(
                // textDirection: TextDirection.rtl,
                S.of(context).choosedLocation,
                style: arabicAppTextStyle(
                  RColors.rDark,
                  FontWeight.w500,
                  mdTxt,
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
            height: 40.h,
            color: RColors.rWhite,
            child: isRequester
                ?                   backArrowDependsOnLang(
                    ctx: context,
                    padHoriz: 15.w,
                    padVert: 10.h,
                    isArabic: localizationCntr.isArabic,
                    withText: true,
                    text: S.of(context).back,
                    onTap: () {
                      Get.back();
                    },
                  )
                // GestureDetector(
                //     onTap: () {
                //       Get.back();
                //     },
                //     child: Padding(
                //         padding: EdgeInsets.only(right: 15.h),
                //         child: Row(
                //           children: [
                //             Transform(
                //               alignment: Alignment.center,
                //               transform: Matrix4.rotationY(
                //                 3.14159,
                //               ), // 180 degrees in radians
                //               child: SvgPicture.asset(
                //                 backArrowIconPath,
                //                 color: RColors.primary,
                //                 height: 20.h,
                //                 width: 20.h,
                //               ),
                //             ),
                //             SizedBox(width: 10.w),
                //             Text(
                //               S.of(context).back,
                //               style: arabicAppTextStyle(
                //                 RColors.primary,
                //                 FontWeight.w600,
                //                 lgTxt,
                //               ),
                //             ),
                //           ],
                //         )),
                //   )
                : GestureDetector(
                    onTap: () {
                      Get.offAll(
                        () => PostServicePage(
                          updatedTrip: providerTrip,
                          isUpdatePost: true,
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              lgTxt,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  height: height * 0.46,
                  width: width,
                  padding: EdgeInsets.all(15.h),
                  margin: EdgeInsets.all(15.h),
                  decoration: BoxDecoration(
                    color: RColors.rWhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      isRequester
                          ? providerPageCntr.isOffererInfosLoading
                              ? const ProviderProfileShimmer()
                              : ProviderInfosWidget(
                                  user: offerTrip!.user!,
                                  userRating: offerTrip!.userRating,
                                )
                          :
                          //     Obx(
                          // () =>
                          ProviderInfosWidget(
                              user: providerTrip!.newTrip.user,
                              userRating: providerTrip!.averageRating,
                            ),
                      // ),
                      // Obx(
                      //   () => providerPageCntr.isPrevTripsLoading
                      //       ? const ProviderProfileShimmer()
                      //       : ProviderInfosWidget(
                      //           user: providerTrip.newTrip.user,
                      //         ),
                      // ),
                      SizedBox(height: 13.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).currentFlight,
                            style: arabicAppTextStyle(
                              RColors.rDark,
                              FontWeight.w600,
                              xsmTxt,
                            ),
                          ),
                          DirectionWidget(
                            width: 105.w,
                            height: 27.h,
                            firstHintTxt: citiesData.fstSelectedCity!,
                            firstTxtFldCntr: firstTxtFld,
                            secondTxtFldCntr: secondTxtFld,
                            secondHintTxt: citiesData.sndSelectedCity!,
                            isEnabled: false,
                            isBorderEnabled: true,
                            filledColor: RColors.rWhite,
                            borderColor: RColors.rGray,
                            txtColor: RColors.rDark,
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),
                      isRequester
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                contatenatedTextes(
                                  sndTxtWdth: 100.w,
                                  S.of(context).departureDate,
                                  offerTrip!.date,
                                  xsmTxt,
                                ),
                                SizedBox(height: 5.h),
                                contatenatedTextes(
                                  sndTxtWdth: 100.w,
                                  S.of(context).startingPlace,
                                  offerTrip!.from,
                                  xsmTxt,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      SizedBox(height: 22.h),
                      Center(
                        child: Container(
                          height: 1.h,
                          width: width / 3,
                          color: RColors.rGray,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).prevFlights,
                              style: arabicAppTextStyle(
                                RColors.rDark,
                                FontWeight.w600,
                                xsmTxt,
                              ),
                            ),
                          ],
                        ),
                      ),
                      isRequester
                          ? Obx(
                              () => Expanded(
                                // child: postServiceCntr.isTripCreated
                                child: providerPageCntr.isOffererInfosLoading
                                    ? ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.all(0),
                                        itemCount: 4,
                                        itemBuilder: (ctx, i) => Padding(
                                          padding: EdgeInsets.all(
                                            10.h,
                                          ),
                                          child:
                                              const ProviderPrevTripsShimmer(),
                                        ),
                                      )
                                    // : providerTrip!.previousTrips.isEmpty
                                    : providerPageCntr.offererInfos
                                                ?.previousTrips.isEmpty ??
                                            true
                                        ? Center(
                                            child: Text(
                                              S.of(context).noPrevTripsFound,
                                              style: arabicAppTextStyle(
                                                RColors.primary,
                                                FontWeight.w500,
                                                smTxt,
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.only(top: 10.h),
                                            // itemCount:
                                            // providerTrip!.previousTrips.length,
                                            itemCount: providerPageCntr
                                                .offererInfos!
                                                .previousTrips
                                                .length,
                                            itemBuilder: (ctx, i) => Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                20.w,
                                                0,
                                                20.w,
                                                10.h,
                                              ),
                                              child: PreviousFlightsWidget(
                                                trip: providerPageCntr
                                                    .offererInfos!
                                                    .previousTrips[i],
                                              ),
                                            ),
                                          ),
                              ),
                            )
                          : Obx(
                              () => Expanded(
                                child: postServiceCntr.isTripCreated
                                    // child: providerPageCntr.isPrevTripsLoading
                                    ? ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.all(0),
                                        itemCount:
                                            4, // Placeholder shimmer count
                                        itemBuilder: (ctx, i) => Padding(
                                          padding: EdgeInsets.all(
                                            10.h,
                                          ),
                                          child:
                                              const ProviderPrevTripsShimmer(),
                                        ),
                                      )
                                    : providerTrip!.previousTrips.isEmpty
                                        // : providerPageCntr.previousTrips?.isEmpty ?? true
                                        ? Center(
                                            child: Text(
                                              S.of(context).noPrevTripsFound,
                                              style: arabicAppTextStyle(
                                                RColors.primary,
                                                FontWeight.w500,
                                                smTxt,
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.all(0),
                                            itemCount: providerTrip!
                                                .previousTrips.length,
                                            // itemCount: providerPageCntr
                                            // .previousTrips!.length,
                                            itemBuilder: (ctx, i) => Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                20.w,
                                                0,
                                                20.w,
                                                20.h,
                                              ),
                                              child: PreviousFlightsWidget(
                                                trip: providerTrip!
                                                    .previousTrips[i],
                                              ),
                                            ),
                                          ),
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.3,
                  width: width,
                  // padding: EdgeInsets.all(15.h),
                  margin: EdgeInsets.all(15.h),
                  decoration: BoxDecoration(
                    color: RColors.rWhite,
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.h),
                            child: Text(
                              S.of(context).reviews,
                              style: arabicAppTextStyle(
                                RColors.rDark,
                                FontWeight.w600,
                                smTxt,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // i think the error i was fasing of the error of the review response was null, because he waites for the
                      // trips to load, that's why they should to be in the same request.
                      // Obx(
                      //   () => Expanded(
                      //     child: ListView.builder(
                      //       physics: const NeverScrollableScrollPhysics(),
                      //       padding: const EdgeInsets.all(0),
                      //       itemCount: providerPageCntr.isReviewsLoading
                      //           ? 4
                      //           : providerPageCntr
                      //               .reviewsResponse?.reviews.length,
                      //       itemBuilder: (ctx, i) {
                      //         if (!providerPageCntr.isReviewsLoading &&
                      //             providerPageCntr
                      //                 .reviewsResponse?.reviews.length == 0) {
                      //           return Center(
                      //             child: Text(
                      //               "No reviews available",
                      //               style: arabicAppTextStyle(
                      //                 RColors.primary,
                      //                 FontWeight.w500,
                      //                 smTxt,
                      //               ),
                      //             ),
                      //           );
                      //         } else {
                      //           return Padding(
                      //             padding:
                      //                 EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                      //             child: providerPageCntr.isReviewsLoading
                      //                 ? const ProviderProfileShimmer()
                      //                 : const UserReviewWidget(),
                      //           );
                      //         }
                      //       },
                      //     ),
                      //   ),
                      // ),
                      Obx(
                        () => Expanded(
                          // child: postServiceCntr.isTripCreated
                          child: providerPageCntr.isReviewsLoading
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  itemCount: 4, // Placeholder shimmer count
                                  itemBuilder: (ctx, i) =>
                                      const ProviderProfileShimmer(),
                                )
                              : providerPageCntr
                                          .reviewsResponse?.reviews.isEmpty ??
                                      true
                                  ? Center(
                                      child: Text(
                                        S.of(context).noReviewsFound,
                                        style: arabicAppTextStyle(
                                          RColors.primary,
                                          FontWeight.w500,
                                          smTxt,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.all(0),
                                      itemCount: providerPageCntr
                                          .reviewsResponse!.reviews.length,
                                      itemBuilder: (ctx, i) => Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          20.w,
                                          0,
                                          20.w,
                                          20.h,
                                        ),
                                        child: UserReviewWidget(
                                          // user: isRequester
                                          //     ? offerTrip!.user!
                                          //     : providerTrip!.newTrip.user,
                                          review: providerPageCntr
                                              .reviewsResponse!.reviews[i],
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ShowMoreBtn(
                          width: 120,
                          height: 30,
                          padding: 6,
                          txtSize: 10,
                          onBtnTapped: () {
                            Get.to(() => const MoreReviewsPage());
                          },
                          btnText: S.of(context).moreReviews,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                    bottom: 20.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: isRequester
                      ? CustomBtn(
                          btnText: S.of(context).contactProvider,
                          onBtnTapped: () {
                            Get.to(
                              () => ChatPage(
                                receiver: offerTrip!.user!,
                                trip: offerTrip!,
                              ),
                            );
                          },
                          btnHeight: 38,
                          btnWidth: width / 2.6,
                          btnPadding: 0,
                          btnTxtSize: 12,
                          svgPath: sendIconPath,
                        )
                      : Column(
                          children: [
                            CustomBtn(
                              btnText: S.of(context).deleteOffer,
                              onBtnTapped: () async {
                                final bool tripDeleted =
                                    await postServiceCntr.deleteTrip(
                                  providerTrip!.newTrip.id,
                                );
                                if (tripDeleted) {
                                  navigationCntr.setSelectedIndex = 0;
                                  Get.offAll(() => NavigationBottomMenu());
                                }
                              },
                              btnHeight: 38,
                              btnWidth: width,
                              btnPadding: 0,
                              btnTxtSize: 12,
                              // svgPath: sendIconPath,
                            ),
                            SizedBox(height: 20.h),
                            CustomBtn(
                              btnText: S.of(context).confirmTrip,
                              onBtnTapped: () async {
                                navigationCntr.setSelectedIndex = 0;
                                Get.offAll(() => NavigationBottomMenu());
                              },
                              btnHeight: 38,
                              btnWidth: width,
                              btnPadding: 0,
                              btnTxtSize: 12,
                              // svgPath: sendIconPath,
                            ),
                          ],
                        ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
