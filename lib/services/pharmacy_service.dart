import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nobetcieczane/models/pharmacy_model.dart';

class PharmacyService extends ChangeNotifier {
  Future<List<PharmacyModel>> getPharmacyData(String il, String ilce) async {
    String url =
        "https://api.collectapi.com/health/dutyPharmacy?ilce=$ilce&il=$il";
    const Map<String, dynamic> headers = {
      "authorization": "apikey 3Ejs8Suwg2Nu69HHjDv8Ns:5ps4YoTJhEIYaqrnTzhStp",
      "content-type": "application/json"
    };
    final dio = Dio();
    final response = await dio.get(url, options: Options(headers: headers));
    if (response.statusCode != 200) {
      return Future.error("Bir sorun oluştu");
    }
    final List list = response.data['result'];
    final List<PharmacyModel> pharmacyList =
        list.map((e) => PharmacyModel.fromJson(e)).toList();
    return pharmacyList;
  }

  Future<List<City>> getCities(String city) async {
    String url = "https://api.collectapi.com/health/districtList?il=$city";
    const Map<String, dynamic> headers = {
      "authorization": "apikey 3Ejs8Suwg2Nu69HHjDv8Ns:5ps4YoTJhEIYaqrnTzhStp",
      "content-type": "application/json"
    };
    final dio = Dio();
    final response = await dio.get(url, options: Options(headers: headers));
    if (response.statusCode != 200) {
      return Future.error("Bir sorun oluştu");
    }
    final List lst = response.data['result'];
    final List<City> cityList = lst.map((e) => City.fromJson(e)).toList();
    return cityList;
  }
}
