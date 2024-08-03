import 'package:flutter/material.dart';
import 'package:nobetcieczane/models/pharmacy_model.dart';

import '../services/pharmacy_service.dart';

class PharmacyProvider extends ChangeNotifier {
  bool isLoading = false;
  List<PharmacyInformation> pharmacy = [];
  List<District> districts = [];

  void fetchDistricts(String city) async {
    isLoading = true;
    pharmacy.clear();
    districts.clear();
    notifyListeners();
    try {
      districts = await PharmacyService().getDistricts(city);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void fetchPharmacyData(String city, String distinc) async {
    isLoading = true;
    notifyListeners();
    try {
      pharmacy = await PharmacyService().getPharmacyData(city, distinc);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
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
