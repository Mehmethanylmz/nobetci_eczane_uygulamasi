import 'package:dio/dio.dart';
import 'package:nobetcieczane/models/pharmacy_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PharmacyService {
  Future<List<PharmacyInformation>> getPharmacyData(
      String city, String district) async {
    String url =
        "https://api.collectapi.com/health/dutyPharmacy?ilce=$district&il=$city";
    const Map<String, dynamic> headers = {
      "authorization": "apikey 5eHgwCuN0jEJn9qJ3jn0Qm:4YQ0WE4lsXJOSMZAey50NK",
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
      "authorization": "apikey 5eHgwCuN0jEJn9qJ3jn0Qm:4YQ0WE4lsXJOSMZAey50NK",
      "content-type": "application/json"
    };
    final dio = Dio();
    final response = await dio.get(url, options: Options(headers: headers));
    if (response.statusCode != 200) {
      return Future.error("Bir sorun oluştu");
    }
    final List list = response.data['result'];
    final List<District> cityList =
        list.map((e) => District.fromJson(e)).toList();
    return cityList;
  }

  Future<bool> openGoogleMaps(String url) async {
    String googeMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(url)}';
    final String googleWebMapsUrl =
        'https://www.google.com/search?q=${Uri.encodeComponent(url)}';
    try {
      return launchUrlString(googeMapsUrl);
    } catch (e) {
      return false;
    }
  }
}
