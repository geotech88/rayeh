// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/app_text_style.dart';

class CustomDropDownMenu extends StatelessWidget {
  // final List<CountryAndCities>? dropDownCountriesListItems;
  final List<String>? dropDownCitiesListItems;
  String? dropDownSelectedValue;
  final Function(String?)? onSelected;
  final String dropDownHint;
  // final bool isCountries;
  final String dropDownTxtFieldHint;
  final double? dropDownWidth;
  final double? dropDownHeight;
  final double dropDownPadHor;
  final double dropDownPadVert;
  final Color? dropDownColor;
  final double? dropDownRadius;

  CustomDropDownMenu({
    super.key,
    // this.dropDownCountriesListItems,
    this.dropDownCitiesListItems,
    this.dropDownSelectedValue,
    this.dropDownWidth,
    this.dropDownHeight,
    this.onSelected,
    // required this.isCountries,
    required this.dropDownHint,
    required this.dropDownTxtFieldHint,
    required this.dropDownPadHor,
    required this.dropDownPadVert,
    this.dropDownColor,
    this.dropDownRadius,
  });

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        
        hint: Text(
          dropDownHint,
          style: arabicAppTextStyle(
            RColors.primary,
            FontWeight.w600,
            smTxt,
          ),
        ),
        iconStyleData: IconStyleData(
          iconSize: 22.h,
          iconEnabledColor: RColors.primary,
          iconDisabledColor: RColors.primary,
        ),
        style: TextStyle(
          color: RColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: smTxt,
        ),
        items: dropDownCitiesListItems!
        .map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontSize: lgTxt,
              ),
            ),
          ),
        )
        .toList(),
        value: dropDownSelectedValue,
        onChanged: onSelected,
        // (value) {
        //   // dropDownSelectedValue = value;
        // },
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            color: dropDownColor ?? RColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              dropDownRadius ?? 10.r,
            ),
          ),
          width: dropDownWidth,
          height: dropDownHeight,
          padding: EdgeInsets.symmetric(
            horizontal: dropDownPadHor,
            vertical: dropDownPadVert,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200.h,
          decoration: BoxDecoration(
            // color: RColors.primaryWithOpacity,
            borderRadius: BorderRadius.circular(
              dropDownRadius ?? 10.r,
            ),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 40.h,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(
              vertical: 4.h,
              horizontal: 20.w,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 5.h,
                ),
                hintText: dropDownTxtFieldHint,
                hintStyle: arabicAppTextStyle(
                  RColors.primary,
                  FontWeight.w400,
                  smTxt,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
          // this is the function that searches for the items
          searchMatchFn: (item, searchValue) {
            return item.value.toString().toLowerCase().contains(
                  searchValue.toLowerCase(),
                );
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}
