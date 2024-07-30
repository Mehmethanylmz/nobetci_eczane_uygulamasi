import 'package:flutter/material.dart';
import 'package:nobetcieczane/models/pharmacy_model.dart';

import '../services/pharmacy_service.dart';

class PharmacyProvider extends ChangeNotifier {
  List<PharmacyInformation> pharmacy = [];
  List<District> districts = [];

  void setDistricts(String city) async {
    pharmacy.clear();
    districts.clear();
    districts = await PharmacyService().getDistricts(city);
    notifyListeners();
  }

  void setPharmacyData(String city, String distinc) async {
    pharmacy = await PharmacyService().getPharmacyData(city, distinc);
    print("${pharmacy[0].loc}adrss : ${pharmacy[0].address}");
    notifyListeners();
  }

  // List<PharmacyInformation> _pharmacy = [];
  // District? selectedCity;
  // Cities? selectedValue;

  // PharmacyService pharmacyService = PharmacyService(); // Initialize service

  //  Future<void>getCities( String city) async {
  //   selectedCity = null;
  //   _pharmacy.clear();
  //   notifyListeners();
  //   //List<District> cities = await pharmacyService.getDistricts(city);

  //   pharmacyService.getDistricts(city).then((cities) {
  //     //_pharmacy = cities;
  //     notifyListeners();
  //   });
  // }

  // Future<void> getPharmacyData() async {
  //   if (selectedValue != null && selectedCity != null) {
  //     _pharmacy = await pharmacyService.getPharmacyData(
  //         selectedValue!.name, selectedCity!.distName);
  //     notifyListeners();
  //   }
  // }
}
