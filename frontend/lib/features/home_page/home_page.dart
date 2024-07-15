// import 'package:csc_picker/csc_picker.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/shimmers/home_shimmer.dart';
import '../../common/widgets/icon_and_text_widget.dart';
import '../../data/services/auth_service.dart';
import '../../generated/l10n.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/texts.dart';
import '../../utils/helpers/app_text_style.dart';
import '../../utils/validators/validate_country_cities_dropdown.dart';
import '../authentication/controllers/auth_controller.dart';
import '../post_service/post_service_page.dart';
import '../services/provided_services_page.dart';
import 'controllers/home_data_controller.dart';
import 'controllers/json_cities_data_controller.dart';
import 'controllers/service_tab_controller.dart';
import 'screens/app_bar.dart';
import 'screens/custom_alert_dialog.dart';
import 'screens/custom_drop_down_menu.dart';
// import 'screens/direction_wiget.dart';
import 'screens/direction_wiget_dropdown.dart';
import 'screens/home_search_btn.dart';
import 'screens/previous_offer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PreviousOffersController previousOffersCntr;
  @override
  Widget build(BuildContext context) {
    final CountriesAndCitiesController countryCitiesController =
        Get.put(CountriesAndCitiesController());
    final AuthController authCntr = Get.put(AuthController());

// no need to initialize the variables because i make the null to show the wanted hint.
    // log("in homepage ${countryCitiesController.countriesList.length}");
    // countryCitiesController.setSelectedCountry("Saudi Arabia");
    // countryCitiesController.setFstSelectedCity = S.of(context).from;
    // countryCitiesController.setSndSelectedCity = S.of(context).to;

    final serviceTabCntr = Get.put(ServiceTabController());
    // final bool isRequester = serviceTabCntr.selectedService == 0;

    final tabCntr = TabController(length: 2, vsync: this);
    final List<String> tabValues = [
      S.of(context).serviceRequester,
      S.of(context).serviceProvider
    ];

    // final TextEditingController firstTxtFld = TextEditingController();
    // final TextEditingController secondTxtFld = TextEditingController();

// this widget is necessary to let the tab bar works
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // this to avoid the overflow issue when the keyboard is appearing without making the page scrollable.
        body:
            // Obx(
            //   () =>
            SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: height * 0.5,
                width: width,
                padding: EdgeInsets.only(right: 15.h, left: 15.w, top: 80.h),
                decoration: BoxDecoration(
                  color: RColors.rHeaderColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35.r),
                    bottomRight: Radius.circular(35.r),
                  ),
                ),
                child: Column(
                  children: [
                    const CustomAppBar(),
                    SizedBox(height: 30.h),
                    Container(
                      height: 40.h,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: RColors.primary,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: tabCntr,
                        indicator: BoxDecoration(
                          // border: Border(),
                          color: RColors.primary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(13.r),
                          ),
                        ),
                        labelColor: RColors.rWhite,
                        unselectedLabelColor: RColors.primary,
                        onTap: (value) {
                          serviceTabCntr.setSelectedService = value;
                          if (value == 1) {
                            previousOffersCntr = Get.put(
                              PreviousOffersController(),
                            );
                          }
                        },
                        tabs: [
                          Text(
                            tabValues[0],
                            style: arabicAppTextStyle(
                              null,
                              FontWeight.w500,
                              mdTxt,
                            ),
                          ),
                          Text(
                            tabValues[1],
                            style: arabicAppTextStyle(
                              null,
                              FontWeight.w500,
                              mdTxt,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    IconAndTextWidget(
                      isHomeTitle: true,
                      icon: Icons.location_on,
                      iconSize: 15.h,
                      text: S.of(context).chooseLocation,
                      textSize: lgTxt,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(height: 20.h),
                    Obx(
                      () {
                        // this log is neccessary for the dropdown to work .
                        log("in homepage ${countryCitiesController.countriesList.length}");
                        return CustomDropDownMenu(
                          // isCountries: true,
                          // dropDownCountriesListItems:
                          //     countryCitiesController.countriesList,
                          // dropDownSelectedValue: countryCitiesController.countriesList[122].countryName,
                          dropDownCitiesListItems:
                              countryCitiesController.countriesList,
                          dropDownSelectedValue:
                              countryCitiesController.selectedCountry,
                          dropDownTxtFieldHint: S.of(context).searchForCountry,
                          dropDownWidth: width * 0.7,
                          dropDownHint: S.of(context).searchForCountry,
                          dropDownPadHor: width * 0.1,
                          dropDownPadVert: 0.h,
                          onSelected: (value) async {
                            if (value != null) {
                              countryCitiesController.setSelectedCountry(value);
                            }
                          },
                        );
                      },
                    ),

                    SizedBox(height: 20.h),
                    // this works without needing to wrap it in obx.
                    Obx(
                      () {
                        // this log is neccessary for the dropdown to work .
                        log("in homepage direction dropdown ${countryCitiesController.citiesList.length}");
                        return DirectionDropDownWidget(
                          dropDownWidth: 120.w,
                          dropDownCitiesListItems:
                              countryCitiesController.citiesList,
                          fstDropDownSelectedValue:
                              countryCitiesController.fstSelectedCity,
                          sndDropDownSelectedValue:
                              countryCitiesController.sndSelectedCity,
                          // dropDownHint: countryCitiesController.selectedCountry,
                          dropDownTxtFieldHint: S.of(context).searchForCity,
                          dropDownPadHor: 15.w,
                          dropDownPadVert: 0,
                          onFstSelected: (value) {
                            if (value != null) {
                              countryCitiesController.setFstSelectedCity =
                                  value;
                            }
                          },
                          onSndSelected: (value) {
                            if (value != null) {
                              countryCitiesController.setSndSelectedCity =
                                  value;
                            }
                          },
                        );
                      },
                    ),

                    SizedBox(height: 20.h),
                    homeSearchBtn(
                      context,
                      () {
                        final validationResult = validateDropDownMenus(
                          ctx: context,
                          country: countryCitiesController.selectedCountry,
                          firstCity: countryCitiesController.fstSelectedCity,
                          secondCity: countryCitiesController.sndSelectedCity,
                        );
                        final isDropDownFilled = showValidationMessage(
                          context,
                          validationResult,
                        );
                        // if (true) {
                        if (isDropDownFilled) {
                          authCntr.isLoggedIn
                              ? serviceTabCntr.selectedService == 0
                                  ? Get.to(() => const ProvidedServicesPage())
                                  : Get.to(() => const PostServicePage())
                              : customAlertDialog(
                                  cxt: context,
                                  onLoginBtnTapped: () async {
                                    final String status =
                                        await AuthService().login();
                                    log(status);
                                    Get.back();
                                    if (status == RTextes.success) {
                                      Get.snackbar(
                                        S.of(context).loginSuccessTitle,
                                        S.of(context).loginSuccessMsg,
                                        colorText: RColors.primary,
                                        backgroundColor:
                                            RColors.primary.withOpacity(
                                          0.2,
                                        ),
                                      );
                                    } else {
                                      Get.snackbar(
                                        S.of(context).loginErrorTitle,
                                        S.of(context).loginErrorMsg,
                                        colorText: Colors.red,
                                        backgroundColor: Colors.red.withOpacity(
                                          0.2,
                                        ),
                                      );
                                    }
                                  },
                                );
                        }
                      },
                      // isRequester,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Obx(
                () => Row(
                  // textDirection: TextDirection.rtl,
                  children: [
                    SizedBox(width: 25.w),
                    Text(
                      // textDirection: TextDirection.rtl,
                      serviceTabCntr.selectedService == 0
                          ? S.of(context).promotions
                          : S.of(context).prevOffers,
                      style: arabicAppTextStyle(
                        RColors.rDark,
                        FontWeight.w600,
                        12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => SizedBox(
                  height: height * 0.4,
                  child: serviceTabCntr.selectedService == 0
                      ? ListView.builder(
                          itemCount: promotionList.length,
                          itemBuilder: (ctx, i) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                              child: Image.asset(promotionList[i]),
                            );
                          },
                        )
                      : previousOffersCntr.isPreviousOffersLoading
                          ? ListView.builder(
                              itemCount: 4,
                              itemBuilder: (ctx, i) {
                                return Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                                  child: const HomeShimmerLoading(),
                                );
                              },
                            )
                          : previousOffersCntr
                                      .previousOffers?.previousTrips.isEmpty ??
                                  true
                              ? Center(
                                  child: Text(
                                    S.of(context).noPrevOffersFound,
                                    style: arabicAppTextStyle(
                                      RColors.primary,
                                      FontWeight.w500,
                                      smTxt,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: previousOffersCntr
                                      .previousOffers?.previousTrips.length,
                                  itemBuilder: (ctx, i) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        20.w,
                                        0,
                                        20.w,
                                        20.h,
                                      ),
                                      child: PreviousOfferWidget(
                                        prevOffer: previousOffersCntr
                                            .previousOffers!.previousTrips[i],
                                      ),
                                    );
                                  },
                                ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
