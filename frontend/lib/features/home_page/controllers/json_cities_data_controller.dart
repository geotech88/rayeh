import 'dart:developer';
import 'package:get/get.dart';
import '../../../utils/helpers/fetch_countries_and_cities.dart';

class CountriesAndCitiesController extends GetxController {
  var countriesList = <String>[].obs;
  var citiesList = <String>[].obs;

  final Rx<String?> _selectedCountry = Rx<String?>(null);
  final Rx<String?> _fstSelectedCity = Rx<String?>(null);
  final Rx<String?> _sndSelectedCity = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    loadCountriesData();
  }

  String? get selectedCountry => _selectedCountry.value;
  String? get fstSelectedCity => _fstSelectedCity.value;
  String? get sndSelectedCity => _sndSelectedCity.value;

  set setFstSelectedCity(String? value) => _fstSelectedCity.value = value;
  set setSndSelectedCity(String? value) => _sndSelectedCity.value = value;

  setSelectedCountry(String? value) async {
    // if (value != null) {
    //   _selectedCountry.value = value;
    //   _fstSelectedCity.value = null; // Reset the city selections when country changes
    //   _sndSelectedCity.value = null;
    //   citiesList.clear(); // Clear city list if no country is selected
    //   citiesList.value = await readCountryCitiesJson(value);
    // } else {
    //   _selectedCountry.value = null; // Reset the country selection if needed
    //   citiesList.clear(); // Clear city list if no country is selected
    //   _fstSelectedCity.value = null; // Reset the city selections when country changes
    //   _sndSelectedCity.value = null;
    // }
    _selectedCountry.value = value;
    _fstSelectedCity.value = null; // Reset the city selections when country changes
    _sndSelectedCity.value = null;
    citiesList.clear(); // Clear the existing city list before setting new one
    if (value != null) {
      citiesList.value = await readCountryCitiesJson(value);
    }
    log(_selectedCountry.value!);
    log("${citiesList.length}");
  }

  void loadCountriesData() async {
    var loadedData = await readCountriesJson();
    countriesList.assignAll(loadedData);
    // log("${countriesList.length}");
  }
}
