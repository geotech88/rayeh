import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// import '../../../bindings/navigation_menu_controller.dart';
import '../../../common/widgets/icons_depends_on_lang.dart';
import '../../../generated/l10n.dart';
import '../../../localization/localization_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';
// import '../../../utils/local_storage/secure_storage_service.dart';
import '../../admin/controllers/admin_controller.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../home_page/screens/home_text_field.dart';
import '../../authentication/models/user_model.dart';
import '../../success_page/screens/success_btn.dart';
import '../controllers/profile_controller.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileInfosPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController professionController = TextEditingController();

  UpdateProfileInfosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameTxtFld = TextEditingController();
    final TextEditingController emailTxtFld = TextEditingController();
    final TextEditingController professionTxtFld = TextEditingController();

    final profileCntr = Get.put(UpdateProfileController());
    final authCntr = Get.find<AuthController>();
    // final TextEditingController passwordTxtFld = TextEditingController();
    // final navigationCntr = Get.find<NavigationMenuController>();
    // final User user = Get.find<SecureStorageService>().user!;
    // final profileCntr = Get.find<ProfileController>();
    // final navigationCntr = Get.find<NavigationMenuController>();
    // final User user = Get.find<ProfileController>().profileInfos!.user;

    final User user;

    if (authCntr.isAdmin) {
      user = Get.find<AdminController>().adminInfos!.data.user;
    } else {
      user = Get.find<ProfileController>().profileInfos!.user;
    }
    final localizationCntr = Get.find<LocalizationController>();
    String? newImgUrl;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.06,
            ),
            SvgPicture.asset(logoIconPath),
            SizedBox(
              height: height * 0.06,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  backArrowDependsOnLang(
                    ctx: context,
                    padHoriz: 35.w,
                    padVert: 10.h,
                    isArabic: localizationCntr.isArabic,
                    onTap: () {
                      Get.back();
                      // navigationCntr.setSelectedIndex = 0;
                    },
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       vertical: 10.h,
                  //       horizontal: 35.w,
                  //     ),
                  //     child: Transform(
                  //       alignment: Alignment.center,
                  //       transform: Matrix4.rotationY(
                  //         3.14159,
                  //       ), // 180 degrees in radians
                  //       child: SvgPicture.asset(
                  //         backArrowIconPath,
                  //         color: RColors.primary,
                  //         height: 20.h,
                  //         width: 20.h,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(width: width * 0.22),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      S.of(context).update,
                      style: arabicAppTextStyle(
                        RColors.rDark,
                        FontWeight.w600,
                        xlgTxt,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            GestureDetector(
              onTap: () async {
                newImgUrl = await profileCntr.getImage();
                log("image : ${profileCntr.image.value}");
              },
              child: Obx(
                () => Container(
                  width: 140.h,
                  height: 140.h,
                  decoration: BoxDecoration(
                    color: RColors.primary,
                    border: Border.all(
                      color: RColors.primary,
                      width: 4.w,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      // image: AssetImage(profilePicPath),
                      image: profileCntr.image.value == null
                          ? CachedNetworkImageProvider(user.path)
                          : FileImage(profileCntr.image.value!)
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: Row(
                children: [
                  Text(
                    S.of(context).updateUsername,
                    style: arabicAppTextStyle(
                      RColors.rDark.withOpacity(0.8),
                      FontWeight.w600,
                      lgTxt,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: HomeTextField(
                width: width,
                height: 45.h,
                txtFldCntr: nameTxtFld,
                hintTxt: user.name,
                isDisabeled: true,
                isBorderEnabled: true,
                txtColor: RColors.rGray,
                filledColor: RColors.primary.withOpacity(0.2),
                borderColor: RColors.primary.withOpacity(0.2),
                textSize: lgTxt,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: Row(
                children: [
                  Text(
                    S.of(context).updateEmail,
                    style: arabicAppTextStyle(
                      RColors.rDark.withOpacity(0.8),
                      FontWeight.w600,
                      lgTxt,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: HomeTextField(
                width: width,
                height: 45.h,
                txtFldCntr: emailTxtFld,
                hintTxt: user.email,
                isDisabeled: true,
                isBorderEnabled: true,
                txtColor: RColors.rGray,
                filledColor: RColors.primary.withOpacity(0.2),
                borderColor: RColors.primary.withOpacity(0.2),
                textSize: smTxt,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: Row(
                children: [
                  Text(
                    S.of(context).updateProfession,
                    style: arabicAppTextStyle(
                      RColors.rDark.withOpacity(0.8),
                      FontWeight.w600,
                      lgTxt,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: HomeTextField(
                width: width,
                height: 45.h,
                txtFldCntr: professionTxtFld,
                hintTxt: user.profession ?? "none",
                isDisabeled: true,
                isBorderEnabled: true,
                txtColor: RColors.rGray,
                filledColor: RColors.primary.withOpacity(0.2),
                borderColor: RColors.primary.withOpacity(0.2),
                textSize: smTxt,
              ),
            ),
            // until make change password in a separate page with 3 input current pass and new pass and confirm new pass and which send a request to the auth0 server.
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            //   child: HomeTextField(
            //     width: width,
            //     height: 45.h,
            //     txtFldCntr: passwordTxtFld,
            //     hintTxt: "********",
            //     isDisabeled: true,
            //     isBorderEnabled: true,
            //     txtColor: RColors.rGray,
            //     filledColor: RColors.primary.withOpacity(0.2),
            //     borderColor: RColors.primary.withOpacity(0.2),
            //     textSize: smTxt,
            //   ),
            // ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: SuccessPageBtn(
                btnHeight: 45.h,
                btnPadding: 5.h,
                btnText: S.of(context).update,
                btnTxtSize: mdTxt,
                btnColor: RColors.primary,
                txtColor: RColors.rWhite,
                onBtnTapped: () async {
                  final updatedUser = User(
                    id: user.id,
                    auth0UserId: user.auth0UserId,
                    name: nameTxtFld.text.isEmpty ? user.name : nameTxtFld.text,
                    email: emailTxtFld.text.isEmpty
                        ? user.email
                        : emailTxtFld.text,
                    profession: professionTxtFld.text.isEmpty
                        ? user.profession
                        : professionTxtFld.text,
                    path: newImgUrl == null
                        // profileCntr.image.value == null
                        ? user.path
                        : newImgUrl!,
                    // : profileCntr.image.value!.toString(),
                    createdAt: DateTime.now().toString(),
                    updatedAt: DateTime.now().toString(),
                  );

                  await profileCntr.updateUser(updatedUserInfos: updatedUser);
                  // until i put it in a separete page
                  // profileCntr.updateUserPassword(
                  //     newPassword: passwordTxtFld.text);

                  log("done ${profileCntr.isUserInfosUpdated}");

                  if (profileCntr.isUserInfosUpdated) {
                    //  && profileCntr.isUserPasswordUpdated
                    Get.snackbar(
                      S.of(context).infosUpdatedTitle,
                      S.of(context).infosUpdatedMsg,
                      colorText: RColors.primary,
                      backgroundColor: RColors.primary.withOpacity(
                        0.2,
                      ),
                    );
                  } else {
                    Get.snackbar(
                      S.of(context).errorTitle,
                      S.of(context).loginErrorMsg,
                      colorText: Colors.red,
                      backgroundColor: Colors.red.withOpacity(
                        0.2,
                      ),
                    );
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
