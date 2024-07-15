import 'package:get/get.dart';

import '../models/profile_model.dart';

class ProfileController extends GetxController {
  final Rx<ProfileData?> _profileInfos = Rx<ProfileData?>(null);

  ProfileData? get profileInfos => _profileInfos.value;

  set setProfileInfos(ProfileData? newInfos) {
    _profileInfos.value = newInfos;
  }
}
