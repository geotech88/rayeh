// trip_controller.dart
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/texts.dart';
import '../../authentication/models/user_model.dart';
import '../models/profile_model.dart';
import 'profile_controller.dart';

class UpdateProfileController extends GetxController {
  final secureStorage = const FlutterSecureStorage();
  final profileCntr = Get.find<ProfileController>();
  final image = Rx<File?>(null);

  final picker = ImagePicker();

  final RxBool _isUserInfosUpdated = false.obs;
  final RxBool _isUserPasswordUpdated = false.obs;
  // String? accessToken;
  String? userId;
  String? userToken;

  @override
  void onInit() async {
    // accessToken = await secureStorage.read(key: RTextes.accessTokenKey);
    userId = await secureStorage.read(key: RTextes.userIdTokenKey);
    userToken = await secureStorage.read(key: RTextes.userToken);
    log("auth-0 user id : $userToken");
    super.onInit();
  }

  bool get isUserInfosUpdated => _isUserInfosUpdated.value;
  set setIsUserInfosUpdated(bool value) => _isUserInfosUpdated.value = value;

  bool get isUserPasswordUpdated => _isUserPasswordUpdated.value;
  set setIsUserPasswordUpdated(bool value) =>
      _isUserPasswordUpdated.value = value;

  Future<String?>? getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      final imgUrl = await updateUserPhoto(image.value!);
      return imgUrl;
    } else {
      log('No image selected.');
      return null;
    }
  }

  Future<User?> updateUser({required User updatedUserInfos}) async {
    try {
      final updateUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/users/update/all',
      );

      final updateHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };

      final updateBody = jsonEncode({
        'name': updatedUserInfos.name,
        'email': updatedUserInfos.email,
        'profession': updatedUserInfos.profession,
        'picture': updatedUserInfos.path,
      });

      final response = await http.patch(
        updateUrl,
        headers: updateHeaders,
        body: updateBody,
      );

      log("${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // final userData = responseData['data'][0];

        log(response.body);
        // log(userData);

        final User updatedUser = User.fromJson(responseData['data']);
        log(updatedUser.name);
        log(updatedUser.email);
        log(updatedUser.profession ?? "none");
        log(updatedUser.path);

        // await secureStorage.write(
        //   key: RTextes.user,
        //   value: jsonEncode(updatedUser),
        // );
        ProfileData updatedProfileInfos = ProfileData(
          user: updatedUser,
          wallet: profileCntr.profileInfos!.wallet,
          averageRating: profileCntr.profileInfos!.averageRating,
        );

        profileCntr.setProfileInfos = updatedProfileInfos;

        setIsUserInfosUpdated = true;

        return updatedUser;
      } else {
        log('Failed to update user');
        log('${response.body}');
        setIsUserInfosUpdated = false;
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (error) {
      log(error.toString());
      setIsUserInfosUpdated = false;
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    }
  }

  Future<User?> updateUserPassword({required String newPassword}) async {
    try {
      final updateUrl = Uri.parse(
          '${RConstants.auth0BundleId}/api/v2/users/$userId'
          // ${process.env.AUTH0_DOMAIN}/api/v2/users/${user.auth0UserId}  auth0
          );

      final updateBody = jsonEncode({
        "result_url": RConstants.auth0RedirectUrl,
        // "user_id": ,
        "client_id": "string",
        "organization_id": "string",
        "connection_id": "string",
        "email": "user@example.com",
        "ttl_sec": 0,
        "mark_email_as_verified": false,
        "includeEmailInRedirect": true
      });

      final response = await http.post(
        updateUrl,
        body: updateBody,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final userData = responseData['data'];
        final User updatedUser = User.fromJson(userData);
        setIsUserPasswordUpdated = true;
        return updatedUser;
      } else {
        log('Failed to update user password');
        log('${response.body}');
        setIsUserPasswordUpdated = false;
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (error) {
      log(error.toString());
      setIsUserPasswordUpdated = false;
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    }
  }

// i will not use this funct of backend because i need to update the pass in auth0
  // Future<User?> updateUserPassword({required String newPassword}) async {
  //   try {
  //     final updateUrl = Uri.parse(
  //         '${RConstants.mainEndpointUrl}/api/users/update/password',
  //         );
  //     final updateHeaders = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $userToken',
  //     };
  //     final updateBody = jsonEncode({
  //       'password': newPassword,
  //     });
  //     final response = await http.patch(
  //       updateUrl,
  //       headers: updateHeaders,
  //       body: updateBody,
  //     );
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       final userData = responseData['data'];
  //       final User updatedUser = User.fromJson(userData);
  //       setIsUserPasswordUpdated = true;
  //       return updatedUser;
  //     } else {
  //       log('Failed to update user password');
  //       log('${response.body}');
  //       setIsUserPasswordUpdated = false;
  //       return null;
  //     }
  //   } catch (error) {
  //     log(error.toString());
  //     setIsUserPasswordUpdated = false;
  //     return null;
  //   }
  // }

  Future<String?> updateUserPhoto(File imageFile) async {
    try {
      final updateUrl = Uri.parse(
        '${RConstants.mainEndpointUrl}/api/users/photo',
      );

      final updateHeaders = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $userToken',
      };

      final request = http.MultipartRequest('POST', updateUrl)
        ..headers.addAll(updateHeaders)
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('update user photo ${response.statusCode}');
      log('update user photo ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String imageUrl = responseData['data']['url'];
        log('update user photo ${imageUrl}');

        return imageUrl;
      } else {
        log('Failed to update user photo');
        log('${response.body}');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
      }
    } catch (error) {
      log(error.toString());
      Get.snackbar(
        'Error',
        'Something went wrong, please try again',
        colorText: Colors.red,
        backgroundColor: Colors.red.withOpacity(0.2),
      );
      return null;
    }
  }
}
