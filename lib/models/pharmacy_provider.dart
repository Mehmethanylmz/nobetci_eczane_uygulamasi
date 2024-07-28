import 'package:flutter/material.dart';
import 'package:nobetcieczane/models/enums.dart';
import 'package:nobetcieczane/models/pharmacy_model.dart';

import '../services/pharmacy_service.dart';

class PharmacyProvider with ChangeNotifier {
  List<PharmacyModel> _pharmacy = [];
  City? selectedCity;
  Iller? selectedValue;

  PharmacyService pharmacyService = PharmacyService(); // Initialize service

  Future<void> getCities(String city) async {
    selectedCity = null;
    _pharmacy.clear();
    notifyListeners();

    pharmacyService.getCities(city).then((cities) {
      _pharmacy = cities;
      notifyListeners();
    });
  }

  Future<void> getPharmacyData() async {
    if (selectedValue != null && selectedCity != null) {
      _pharmacy = await pharmacyService.getPharmacyData(
          selectedValue!.name, selectedCity!.name);
      notifyListeners();
    }
  }
}
