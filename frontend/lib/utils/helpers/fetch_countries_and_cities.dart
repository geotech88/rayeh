import 'dart:convert';
// import 'dart:developer';

import 'package:flutter/services.dart';

import '../constants/api_constants.dart';
// import '../../features/home_page/models/countries_and_cities_model.dart';

// i was fetching all the countries with their cities once but it takes alot of time.

// Future<List<CountryAndCities>> readCountriesJsonData() async {
//   final String data = await rootBundle.loadString(
//     RConstants.countriesAndCitiesJson,
//   );
//   final jsonData = await json.decode(data);
//   final List<CountryAndCities> countries = [];
//   // for (var item in jsonData) {
//   //   countries.add(CountryAndCities(countryName: item[], countryCities: countryCities))
//   // }
//   jsonData.forEach((country, cities) {
//     // Each key is a country, each value is a list of cities
// // this to get the index of saudi arabia
//     // int saudiIndex = countries
//     //     .indexWhere((country) => country.countryName == "Saudi Arabia");
//     // log("$saudiIndex");
//     countries.add(
//       CountryAndCities(
//         countryName: country,
//         countryCities: List<String>.from(cities),
//       ),
//     );
//   });
//   return countries;
// }

Future<List<String>> readCountriesJson() async {
  final String data = await rootBundle.loadString(
    RConstants.countriesAndCitiesJson,
  );
  final jsonData = await json.decode(data);
  final List<String> countries = [];
  jsonData.forEach((country,cities) {
    countries.add(country);
  });
  // log("${countries.length}");
  return countries;
}

Future<List<String>> readCountryCitiesJson(String countryName) async {
  final String data = await rootBundle.loadString(
    RConstants.countriesAndCitiesJson,
  );
  final jsonData = await json.decode(data);
  if (jsonData.containsKey(countryName)) {
    return List<String>.from(jsonData[countryName]);
  } else {
    return [];
  }
}
