import 'package:dio/dio.dart';
import 'package:nobetcieczane/models/pharmacy_model.dart';

class PharmacyService {
  Future<List<PharmacyInformation>> getPharmacyData(String city, String district) async {
    String url =
        "https://api.collectapi.com/health/dutyPharmacy?ilce=$district&il=$city";
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
    final List<PharmacyInformation> pharmacyList =
        list.map((e) => PharmacyInformation.fromJson(e)).toList();
    return pharmacyList;
  }

  Future<List<District>> getDistricts(String city) async {
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
    final List list = response.data['result'];
    final List<District> cityList = list.map((e) => District.fromJson(e)).toList();
    return cityList;
    
  }
}
