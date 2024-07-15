import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/widgets/icons_depends_on_lang.dart';
import '../../common/widgets/icon_and_text_widget.dart';
import '../../generated/l10n.dart';
import '../../localization/localization_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/formatters/format_date_and_time.dart';
import '../../utils/helpers/app_text_style.dart';
import '../../utils/helpers/get_the_current_date.dart';
import '../../utils/helpers/pick_a_date.dart';
import '../authentication/models/user_model.dart';
// import '../home_page/controllers/json_cities_data_controller.dart';
import '../home_page/screens/direction_wiget.dart';
import '../message_page/chat_page.dart';
import '../message_page/controllers/chat_controller.dart';
import '../message_page/models/message_model.dart';
import '../post_service/models/trip_model.dart';
import '../provider/screens/custom_btn.dart';
// import '../tracking_page/screens/add_update_widget.dart';
import '../tracking_page/screens/add_update_widget.dart';
import 'controllers/create_offer_controller.dart';
import 'models/offer_infos_model.dart';
import 'screens/commission_widget.dart';
import 'screens/container_bg_widget.dart';

class CreateOfferPage extends StatelessWidget {
  final User client;
  final User currentUser;
  final Trip trip;
  final int conversationId;
  const CreateOfferPage({
    super.key,
    required this.client,
    required this.currentUser,
    required this.trip,
    required this.conversationId,
  });

  @override
  Widget build(BuildContext context) {
    // final citiesData = Get.find<CountriesAndCitiesController>();
    final createOfferCntr = Get.put(OfferController());
    final chatCntr = Get.find<ChatController>();

    createOfferCntr.setDate = GetDateAndTime.getTheCurrentDate();
    String backendDate = RDateAndTimeFormatter.formatTheDateForBackend(
      date: DateTime.now(),
    );

    final servicesDropdown = [
      S.of(context).purchaseProduct,
      S.of(context).delivereProduct,
    ];

    createOfferCntr.setServiceType = servicesDropdown[0];

    final TextEditingController fstDirectionTxtFld = TextEditingController();
    final TextEditingController sndDirectionTxtFld = TextEditingController();
    final TextEditingController fstCommissionTxtFld = TextEditingController();
    final TextEditingController sndCommissionTxtFld = TextEditingController();

    final localizationCntr = Get.find<LocalizationController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.2,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    backArrowDependsOnLang(
                      ctx: context,
                      padHoriz: 10.w,
                      padVert: 10.h,
                      isArabic: localizationCntr.isArabic,
                      onTap: () {
                        Get.back();
                      },
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.back();
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.all(10.h),
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
                    SizedBox(width: width * 0.3),
                    Text(
                      S.of(context).createOffer,
                      style: arabicAppTextStyle(
                        RColors.rDark,
                        FontWeight.w600,
                        mdTxt,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: designedContainerWidget(
                      horPadding: 10.w,
                      verPadding: 18.h,
                      content: Column(
                        children: [
                          IconAndTextWidget(
                            icon: Icons.location_on,
                            iconSize: 13.h,
                            text: S.of(context).direction,
                            textSize: 10,
                          ),
                          SizedBox(height: 20.h),
                          DirectionWidget(
                            firstHintTxt: trip.from,
                            firstTxtFldCntr: fstDirectionTxtFld,
                            secondTxtFldCntr: sndDirectionTxtFld,
                            secondHintTxt: trip.to,
                            isEnabled: false,
                            width: 58.w,
                            height: 20.h,
                            iconHeight: 12.h,
                            iconWidth: 12.h,
                            textSize: xsmTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: designedContainerWidget(
                      horPadding: 12.w,
                      verPadding: 18.h,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconAndTextWidget(
                            icon: Icons.person,
                            iconSize: 13.h,
                            text: S.of(context).client,
                            textSize: 10,
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              // 'أبو الجوهرة',
                              client.name,
                              style: arabicAppTextStyle(
                                RColors.rGray,
                                FontWeight.w600,
                                smTxt,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => addUpdateDesignedWidget(
                        bgColor: RColors.rWhite,
                        context: context,
                        title: S.of(context).date,
                        icon: Icons.calendar_month,
                        label: Text(
                          createOfferCntr.date,
                          style: arabicAppTextStyle(
                            RColors.rGray,
                            FontWeight.w600,
                            smTxt,
                          ),
                        ),
                        onWidgetClicked: () async {
                          final pickedDate = await pickTheDate(cxt: context);
                          createOfferCntr.setDate =
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
                  // Expanded(
                  //   child: designedContainerWidget(
                  //     horPadding: 12.w,
                  //     verPadding: 18.h,
                  //     content: Row(
                  //       children: [
                  //         IconAndTextWidget(
                  //           icon: Icons.calendar_month,
                  //           iconSize: 13.h,
                  //           text: S.of(context).chooseDate,
                  //           textSize: 10,
                  //         ),
                  //         SizedBox(width: 10.w),
                  //         Text(
                  //           '04/05/2024',
                  //           style: arabicAppTextStyle(
                  //             RColors.rGray,
                  //             FontWeight.w600,
                  //             smTxt,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Obx(
                      () => addUpdateDesignedWidget(
                        bgColor: RColors.rWhite,
                        horPad: 0,
                        context: context,
                        title: S.of(context).serviceType,
                        icon: Icons.card_travel_sharp,
                        label: DropdownButton<String>(
                          // this to remove the extra padding
                          isDense: true,
                          // elevation: 0,
                          // padding: EdgeInsets.zero,
                          iconSize: 14.h,
                          style: arabicAppTextStyle(
                            RColors.rGray,
                            FontWeight.w600,
                            xsmTxt,
                          ),
                          value: createOfferCntr.serviceType,
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
                                      xsmTxt,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              createOfferCntr.setServiceType = newValue;
                            }
                          },
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: designedContainerWidget(
                    //     horPadding: 12.w,
                    //     verPadding: 18.h,
                    //     content: Row(
                    //       children: [
                    //         IconAndTextWidget(
                    //           icon: Icons.card_travel_sharp,
                    //           iconSize: 13.h,
                    //           text: S.of(context).serviceType,
                    //           textSize: 10,
                    //         ),
                    //         SizedBox(width: 10.w),
                    //         Text(
                    //           'توصيل منتج',
                    //           style: arabicAppTextStyle(
                    //             RColors.rGray,
                    //             FontWeight.w600,
                    //             xsmTxt,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: addUpdateDesignedWidget(
              //         context: context,
              //         title: S.of(context).date,
              //         icon: Icons.calendar_month,
              //         label: Text(
              //           infosBottomSheetCntr.date,
              //           style: arabicAppTextStyle(
              //             RColors.rGray,
              //             FontWeight.w600,
              //             smTxt,
              //           ),
              //         ),
              //         onWidgetClicked: () async {
              //           infosBottomSheetCntr.setDate = RDateAndTimeFormatter.formatTheDate(
              //             date: await pickTheDate(cxt: context),
              //           );
              //           log(infosBottomSheetCntr.date);
              //         },
              //       ),
              //     ),
              //     SizedBox(width: 30.w),
              //     Expanded(
              //       child: addUpdateDesignedWidget(
              //         horPad: 5.w,
              //         context: context,
              //         title: S.of(context).update,
              //         icon: Icons.refresh_outlined,
              //         label: DropdownButton<String>(
              //           // this to remove the extra padding
              //           isDense: true,
              //           // elevation: 0,
              //           // padding: EdgeInsets.zero,
              //           style: arabicAppTextStyle(
              //             RColors.rGray,
              //             FontWeight.w600,
              //             xsmTxt,
              //           ),
              //           value: infosBottomSheetCntr.selectedService,
              //           items: servicesDropdown
              //               .map(
              //                 (item) => DropdownMenuItem<String>(
              //                   // the error that i face of multiple same values was because i didn't add the item to the value property
              //                   value: item,
              //                   child: Text(
              //                     item,
              //                     style: arabicAppTextStyle(
              //                       RColors.rGray,
              //                       FontWeight.w600,
              //                       smTxt,
              //                     ),
              //                   ),
              //                 ),
              //               )
              //               .toList(),
              //           onChanged: (String? newValue) {
              //             if (newValue != null) {
              //               infosBottomSheetCntr.setSelectedService = newValue;
              //             }
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  Expanded(
                    child: designedContainerWidget(
                      horPadding: 12.w,
                      verPadding: 40.h,
                      content: Column(
                        children: [
                          IconAndTextWidget(
                            icon: Icons.check_circle,
                            iconSize: 15.h,
                            text: S.of(context).commission,
                            textSize: 13,
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Expanded(
                                child: CommissionWidget(
                                  fieldHeight: 35.h,
                                  txtFldCntr: fstCommissionTxtFld,
                                  hintTxt: S.of(context).price,
                                  txtInsideField: S.of(context).productPrice,
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: CommissionWidget(
                                  fieldHeight: 35.h,
                                  txtFldCntr: sndCommissionTxtFld,
                                  hintTxt: S.of(context).price,
                                  txtInsideField: S.of(context).deliveryPrice,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.25),
              CustomBtn(
                btnText: S.of(context).showOffer,
                svgPath: prizeIconPath,
                btnTxtSize: 12.sp,
                btnHeight: 40,
                onBtnTapped: () async {
                  // final message = Message(
                  //   senderId: currentUserId,
                  //   receiverId: client.auth0UserId,
                  //   // make it empty
                  //   message: "",
                  //   // i need to send the request id also
                  //   type: messageTypeToString(MessageType.request),
                  //   createdAt: RDateAndTimeFormatter.formatTheTime(
                  //     time: TimeOfDay.now(),
                  //   ),
                  // );
                  // // chatCntr.messagesList.add(message);
                  // chatCntr.sendMessage(
                  //   receiverId: message.receiverId,
                  //   senderId: message.senderId,
                  //   message: message.message,
                  //   type: MessageType.request,
                  // );

                  // final requestMsg = SendedMessage(
                  //   tripId: trip.id!,
                  //   senderId: currentUser.auth0UserId,
                  //   recieverId: client.auth0UserId,
                  //   // message: "offer",
                  //   message: "",
                  //   type: MessageType.request,
                  // );

                  // chatCntr.addMessageToList(
                  //   Message(
                  //     sender: currentUser,
                  //     message: requestMsg.message,
                  //     type: messageTypeToString(requestMsg.type),
                  //   ),
                  // );

                  // i was using it
                  // await chatCntr.sendRequestMessage(message: requestMsg);

                  // log("${chatCntr.messagesList.length}");
                  log('conversation id : ${chatCntr.conversationId}');
                  // chatCntr.getMessages(
                  //   fstUser: currentUser.auth0UserId,
                  //   sndUser: client.auth0UserId,
                  // );

                  // log('last message id after : ${chatCntr.lastMessageId}');
                  // if (chatCntr.lastMessageId.value != 0) {
                    // log('last message id after : ${chatCntr.lastMessageId}');
                    final createdOffer = await createOfferCntr.createOffer(
                      RequestData(
                        from: trip.from,
                        to: trip.to,
                        serviceType: createOfferCntr.serviceType,
                        price: double.parse(fstCommissionTxtFld.text),
                        cost: double.parse(sndCommissionTxtFld.text),
                        conversationId: conversationId,
                        // message: Message(
                        //   receiverId: client.auth0UserId,
                        //   senderId: currentUserId,
                        //   message: "my offer is :",
                        //   type: messageTypeToString(MessageType.request),
                        // ),
                        date: DateTime.parse(backendDate),
                      ),
                    );

                    final requestMsg =  SendedMessage(
                    tripId: trip.id!,
                    senderId: currentUser.auth0UserId,
                    recieverId: client.auth0UserId,
                    // message: "offer",
                    message: "",
                    type: MessageType.request,
                    requestId: createdOffer!.data.id,
                  );

                  chatCntr.sendRequestMessage(message: requestMsg);

                  // i make it without await to not make the user wait for it, and it will continue in background.
                    createOfferCntr.updateServiceType(
                      trip.id!,
                      createOfferCntr.serviceType,
                    );

                    log('created offer data : ${createdOffer.data.from}');
                    Get.off(
                      () => ChatPage(
                        receiver: client,
                        trip: trip,
                        // offerRequest: RequestModel(
                        //   id: createdOffer!.data.id!,
                        //   from: createdOffer.data.from,
                        //   to: createdOffer.data.to,
                        //   price: createdOffer.data.price,
                        //   cost: createdOffer.data.cost,
                        //   date: createdOffer.data.date,
                        // ),
                      ),
                    );
                  // }

                  // log('last message id after after : ${chatCntr.lastMessageId}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
