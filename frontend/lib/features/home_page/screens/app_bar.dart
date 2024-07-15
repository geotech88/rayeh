import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../bindings/navigation_menu_controller.dart';
import '../../../data/services/auth_service.dart';
import '../../../generated/l10n.dart';
import '../../../localization/localization_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/app_text_style.dart';
import '../../authentication/controllers/auth_controller.dart';
// import '../../../utils/local_storage/secure_storage_service.dart';
// import '../../authentication/models/user_model.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/app_bar_date_time_controller.dart';
import '../controllers/language_tab_controller.dart';
import 'custom_alert_dialog.dart';
import 'language_tab_bar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTimeController dateTimeController = Get.put(DateTimeController());
    final navigationMenuCntr = Get.find<NavigationMenuController>();
    final languageCntr = Get.put(LanguageTabController());
    // final localizationCntr = Get.put(LocalizationController());
    // final User? user = Get.find<SecureStorageService>().user;
    final profileCntr = Get.find<ProfileController>();

    final localizationCntr = Get.find<LocalizationController>();
    final AuthController authCntr = Get.put(AuthController());

    // final tabCntr = TabController(length: 2, vsync: this);

    List<String> languagesString = ['AR', 'EN'];

    return Row(
      // i leave this in the app bar to not change it's direction when the language changes.
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => GestureDetector(
            onTap: () {
              authCntr.isLoggedIn
                  ? navigationMenuCntr.setSelectedIndex = 1
                  : customAlertDialog(
                      cxt: context,
                      onLoginBtnTapped: () async {
                        final String status = await AuthService().login();
                        // log(status);
                        Get.back();
                        if (status == RTextes.success) {
                          Get.snackbar(
                            S.of(context).loginSuccessTitle,
                            S.of(context).loginSuccessMsg,
                            colorText: RColors.primary,
                            backgroundColor: RColors.primary.withOpacity(
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
            },
            child: profileCntr.profileInfos?.user != null
                ? CircleAvatar(
                    radius: 20.r,
                    backgroundImage: CachedNetworkImageProvider(
                      profileCntr.profileInfos!.user.path,
                    ),
                  )
                : CircleAvatar(
                    radius: 20.r,
                    backgroundImage: AssetImage(profilePicPath),
                  ),
          ),
        ),
        Container(
          height: 30.h,
          width: width * 0.15,
          decoration: BoxDecoration(
            border: Border.all(color: RColors.primary, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
          ),
          child: TabBarWidget(
            // tabCntr: null,
            tabValues: languagesString,
            txtSize: 8,
            fontWeight: FontWeight.bold,
            onTabClicked: (index) {
              // print('index: $index');
              languageCntr.setSelectedLanguage = index;
              localizationCntr.changeLanguage(
                index == 0 ? 'ar' : 'en',
              );
            },
          ),
        ),
        Obx(() => Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 15.h,
                ),
                SizedBox(width: 5.w),
                Text(
                  dateTimeController.currentDay.value,
                  style: arabicAppTextStyle(
                    RColors.rDark,
                    FontWeight.w500,
                    mdTxt,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  dateTimeController.currentMonth.value,
                  style: arabicAppTextStyle(
                    RColors.rDark,
                    FontWeight.w500,
                    smTxt,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  dateTimeController.currentYear.value,
                  style: arabicAppTextStyle(
                    RColors.rDark,
                    FontWeight.w500,
                    smTxt,
                  ),
                ),
                SizedBox(width: 15.w),
                Icon(
                  Icons.access_time,
                  size: 15.h,
                ),
                SizedBox(width: 5.w),
                Text(
                  dateTimeController.currentTime.value,
                  style: arabicAppTextStyle(
                    RColors.rDark,
                    FontWeight.w500,
                    smTxt,
                  ),
                ),
              ],
            )),
        SvgPicture.asset(logoIconPath),
      ],
    );
  }
}
