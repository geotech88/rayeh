import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// import '../../features/admin/controllers/admin_controller.dart';
import '../../features/authentication/controllers/auth_controller.dart';
import '../../features/authentication/models/auth0_id_token_model.dart';
// import '../../features/authentication/models/auth0_user_model.dart';
import '../../features/profile/controllers/profile_controller.dart';
import '../../features/profile/models/profile_model.dart';
import '../../features/authentication/models/user_model.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/constants/texts.dart';
// import '../../utils/local_storage/secure_storage_service.dart';
// import '../../utils/local_storage/secure_storage_service.dart';
import '../../utils/validators/validate_auth_result.dart';

class AuthService extends GetxService {
  final authCntr = Get.put(AuthController());
  final appAuth = const FlutterAppAuth();
  final secureStorage = const FlutterSecureStorage();
  final profileCntr = Get.put(ProfileController());

  // @override
  // void onInit() async {
  //   await initAuth();
  //   super.onInit();
  // }

// this to have logout by sending a request, i don't need to use it.
  String? accessToken;
  Auth0IdTokenModel? idToken;
  User? user;
  // Auth0User? user;

  Future<String> initAuth() async {
    return handleAuthErrors(callback: () async {
      final securedRefreshToken = await secureStorage.read(
        key: RTextes.refreshTokenKey,
      );
      // final securedAccessToken = await secureStorage.read(
      //   key: RTextes.accessTokenKey,
      // );
      // final securedIdToken = await secureStorage.read(
      //   key: RTextes.userIdTokenKey,
      // );

      if (securedRefreshToken == null) {
        return "Please Loggin And Try Again";
      }

      // to get a token to login back again.
      final tokenRequest = TokenRequest(
        RConstants.auth0ClientId,
        RConstants.auth0RedirectUrl,
        issuer: RConstants.auth0Issuer,
        refreshToken: securedRefreshToken,
      );

      final data = await appAuth.token(tokenRequest);
      return initLocalVariables(data);
    });
  }

  Future<String> initLocalVariables(TokenResponse? response) async {
    if (isAuthResultValid(response: response)) {
      accessToken = response!.accessToken;
      idToken = parseIdToken(idToken: response.idToken!);

// i think i will not need these
      await secureStorage.write(
        key: RTextes.accessTokenKey,
        value: accessToken,
      );
      await secureStorage.write(
        key: RTextes.userIdTokenKey,
        value: idToken!.sub,
      );
      log("access token ${accessToken}");

      try {
        // to get the token to send all the requests to the backend.
        log("auth service url : ${RConstants.auth0EndpointUrl}");

        final reply = await http.post(
          Uri.parse(RConstants.auth0EndpointUrl),
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        );

        // log("reply user token server : ${reply.statusCode}");
        // log("reply user token server : ${reply.body}");

        final String? userToken = jsonDecode(reply.body)["token"];

        log("reply user token : ${userToken}");
        if (userToken != null) {
          // SecureStorageService().write(RTextes.userToken, userToken);
          await secureStorage.write(
            key: RTextes.userToken,
            value: userToken,
          );
          // to get the role of the user.
          final role = await http.get(
            Uri.parse("${RConstants.mainEndpointUrl}/checkRole/role"),
            headers: {
              'Authorization': 'Bearer $userToken',
            },
            // body: jsonEncode({"userId": user!.id}),
          );
          // to show the admin pages.
          authCntr.isAdmin =
              Role.fromJson(jsonDecode(role.body)["data"]).name == "admin";
          log("is admin : ${authCntr.isAdmin}");

          log("role response : ${role.body}");
          if (!authCntr.isAdmin) {
            final profileInfos = await getUserDetails(userToken);
            // it return's null here i don't know why
            if (profileInfos != null) {
              // log("in authService cntr : ${profileInfos.user.email}");
              profileCntr.setProfileInfos = profileInfos;
              user = profileInfos.user;
              // log("in authService cntr : ${user!.email}");
              if (user != null) {
                await secureStorage.write(
                  key: RTextes.user,
                  value: jsonEncode(user),
                );
              }
            } else {
              log("Failed to get profile info");
            }
          } else {
            // Get.put(AdminController());
          }
        }

        if (response.refreshToken != null) {
          await secureStorage.write(
            key: RTextes.refreshTokenKey,
            value: response.refreshToken,
          );
        }

        final createWallet = await http.patch(
          Uri.parse("${RConstants.mainEndpointUrl}/api/wallet/create"),
          headers: {
            'Authorization': 'Bearer $userToken',
          },
          // body: jsonEncode({"userId": user!.id}),
        );
        log("create wallet: ${createWallet.statusCode}");
        // log("create wallet: ${createWallet.body}");
      } catch (e) {
        log('failed to get user token from the server ${e.toString()}');
      }

      // to let the user access to other pages.
      authCntr.isLoggedIn = true;

      return RTextes.success;
      // return true;
    }
    return 'Something went wrong';
  }

  // Future<void>
  Future<String> login() async {
    // log("${RConstants.auth0RedirectUrl}");
    // log("${RConstants.auth0Domain}");
    // log("${RConstants.auth0ClientId}");
    // this function try to catch all the errors of this operation.
    return handleAuthErrors(callback: () async {
      final authTokenRequest = AuthorizationTokenRequest(
        RConstants.auth0ClientId,
        RConstants.auth0RedirectUrl,
        issuer: RConstants.auth0Issuer,
        scopes: RConstants.auth0Scopes,
        // to ignore all the existing session and login again, it's good when he logout.
        promptValues: ['login'],
        // additionalParameters: {'connection': 'google-oauth2'},
      );

      final result = await appAuth.authorizeAndExchangeCode(authTokenRequest);

      return initLocalVariables(result);
    });
  }

  Future<void> logout() async {
    await secureStorage.delete(key: RTextes.refreshTokenKey);
    await secureStorage.delete(key: RTextes.userToken);
    await secureStorage.delete(key: RTextes.user);
    profileCntr.setProfileInfos = null;
    authCntr.isLoggedIn = false;
    log("user data = ${await secureStorage.read(key: RTextes.user)}");
  }

  Auth0IdTokenModel parseIdToken({required String idToken}) {
    final tokenParts = idToken.split(r'.');

    final Map<String, dynamic> data = jsonDecode(
      utf8.decode(
        base64Url.decode(
          base64Url.normalize(tokenParts[1]),
        ),
      ),
    );

    // log("${data}");
    return Auth0IdTokenModel.fromJson(data);
  }

  Future<ProfileData?> getUserDetails(String userToken) async {
    try {
      final url = Uri.parse("${RConstants.mainEndpointUrl}/api/users/me");
      // final url = Uri.https(RConstants.auth0Domain, "/userinfo");

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $userToken',
      });

      log("user infos json: ${response.statusCode}");
      // log("user infos json: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("user infos json: ${data}");
        final userTest = ProfileInfosModel.fromJson(data);
        // log("in user infos userTest: ${userTest.data.user.email}");
        final profileInfo = userTest.data;
        // log("in user infos userTest: ${profileInfo.user.auth0UserId}");
        // profileCntr.setProfileInfos = userTest.data;
        // log("in user infos : ${profileCntr.profileInfos?.user.email}");
        // log("in get user details cntr : ${userTest.data.user.email}");
        // final userTest = User.fromJson(data['data']);
        // final userTest = Auth0User.fromJson(data);
        // log("${userTest.name}");
        // log("${userTest.email}");
        // // log("${userTest.emailVerified}");
        // log("${userTest.nickname}");
        // log("${userTest.sub}");
        // log("${userTest.updatedAt}");
        // log("${userTest.id}");
        // log("${userTest.picture}");
        return profileInfo;
      } else {
        log('failed to get user');
        Get.snackbar(
          'Error',
          'Something went wrong, please try again',
          colorText: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
        return null;
        // throw Exception("Failed to get user details");
      }
    } catch (e) {
      log('failed to get user ${e.toString()}');
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
