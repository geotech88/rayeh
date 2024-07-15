import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/widgets/icons_depends_on_lang.dart';
import '../../../generated/l10n.dart';
import '../../../localization/localization_controller.dart';
// import '../../../utils/constants/image_strings.dart';
// import '../models/countries_and_cities_model.dart';
import 'custom_drop_down_menu.dart';

// ignore: must_be_immutable
class DirectionDropDownWidget extends StatelessWidget {
  // final List<CountryAndCities>? dropDownCountriesListItems;
  String? fstDropDownSelectedValue;
  String? sndDropDownSelectedValue;
  final List<String>? dropDownCitiesListItems;
  // final bool isFirstDropDown;
  final Function(String?)? onFstSelected;
  final Function(String?)? onSndSelected;
  final String? fstDropDownHint;
  final String? sndDropDownHint;
  final String dropDownTxtFieldHint;
  final double? dropDownWidth;
  final double? dropDownHeight;
  final double dropDownPadHor;
  final double dropDownPadVert;
  final Color? dropDownColor;
  final double? dropDownRadius;
  final double? iconHeight;
  final double? iconWidth;

  DirectionDropDownWidget({
    super.key,
    // this.dropDownCountriesListItems,
    this.dropDownCitiesListItems,
    // required this.isFirstDropDown,
    this.fstDropDownSelectedValue,
    this.sndDropDownSelectedValue,
    this.dropDownWidth,
    this.dropDownHeight,
    this.onFstSelected,
    this.onSndSelected,
    this.fstDropDownHint,
    this.sndDropDownHint,
    // required this.dropDownHint,
    required this.dropDownTxtFieldHint,
    required this.dropDownPadHor,
    required this.dropDownPadVert,
    this.dropDownColor,
    this.dropDownRadius,
    this.iconHeight,
    this.iconWidth,
  });

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomDropDownMenu(
          // isCountries: false,
          // dropDownCountriesListItems: dropDownCountriesListItems,
          dropDownCitiesListItems: dropDownCitiesListItems,
          dropDownSelectedValue: fstDropDownSelectedValue,
          dropDownTxtFieldHint: dropDownTxtFieldHint,
          dropDownWidth: dropDownWidth,
          onSelected: onFstSelected,
          dropDownHint: S.of(context).from,
          dropDownPadHor: dropDownPadHor,
          dropDownPadVert: dropDownPadVert,
          dropDownColor: dropDownColor,
          dropDownHeight: dropDownHeight,
          dropDownRadius: dropDownRadius,
        ),
        SizedBox(width: 15.w),
        // until check the lang and display the right one.
        directionArrowDependsOnLang(
          isArabic: localizationCntr.isArabic,
          padHoriz: 0,
          padVert: 0,
          icHeight: iconHeight,
          icWidth: iconWidth,
        ),
        // SvgPicture.asset(
        //   arrowIconPath,
        //   height: iconHeight,
        //   width: iconWidth,
        // ),
        // // i use this transform widget to rotate the arrow img when the lang is en.
        // // Transform(
        // //   alignment: Alignment.center,
        // //   transform: Matrix4.rotationY(3.14159), // 180 degrees in radians
        // //   child: SvgPicture.asset(arrowIconPath),
        // // ),
        SizedBox(width: 15.w),
        CustomDropDownMenu(
          // isCountries: false,
          // dropDownCountriesListItems: dropDownCountriesListItems,
          dropDownCitiesListItems: dropDownCitiesListItems,
          dropDownSelectedValue: sndDropDownSelectedValue,
          dropDownTxtFieldHint: dropDownTxtFieldHint,
          dropDownWidth: dropDownWidth,
          onSelected: onSndSelected,
          dropDownHint: S.of(context).to,
          dropDownPadHor: dropDownPadHor,
          dropDownPadVert: dropDownPadVert,
          dropDownColor: dropDownColor,
          dropDownHeight: dropDownHeight,
          dropDownRadius: dropDownRadius,
        ),
      ],
    );
  }
}
