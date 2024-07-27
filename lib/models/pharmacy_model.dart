class PharmacyModel {
  final String name;
  final String dist;
  final String address;
  final String phone;
  final String loc;

  PharmacyModel(this.name, this.dist, this.address, this.phone, this.loc);

  PharmacyModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        dist = json['dist'],
        address = json['address'],
        phone = json['phone'],
        loc = json['loc'];
}

class City {
  final String name;

  City(this.name);

  City.fromJson(Map<String, dynamic> json) : name = json['text'];
}
