class PharmacyInformation {
  final String name;
  final String dist;
  final String address;
  final String phone;
  final String loc;

  PharmacyInformation(this.name, this.dist, this.address, this.phone, this.loc);

  PharmacyInformation.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        dist = json['dist'],
        address = json['address'],
        phone = json['phone'],
        loc = json['loc'];
}

class District {
  final String distName;

  District(this.distName);

  District.fromJson(Map<String, dynamic> json) : distName = json['text'];
}
