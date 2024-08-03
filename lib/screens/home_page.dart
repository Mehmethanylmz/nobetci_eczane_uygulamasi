import 'package:flutter/material.dart';
import 'package:nobetcieczane/models/enums.dart';
import 'package:nobetcieczane/models/pharmacy_model.dart';
import 'package:nobetcieczane/models/pharmacy_provider.dart';
import 'package:nobetcieczane/services/pharmacy_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  District? selectedDist;
  Cities? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NÖBETÇİ ECZANE",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 28),
        ),
        leading: Image.asset(
          "assets/images/drugstore.png",
        ),
        centerTitle: true,
        backgroundColor: Colors.red.shade700,
        leadingWidth: 50,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                cityFormField(),
                const SizedBox(height: 10.0),
                districtFormField()
              ],
            ),
          ),
          detailsListView(),
        ],
      ),
    );
  }

  Expanded detailsListView() {
    return Expanded(
        child: Consumer<PharmacyProvider>(
      builder: (context, value, child) => value.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: value.pharmacy.length,
              itemBuilder: (context, index) {
                final PharmacyInformation pharmacy = value.pharmacy[index];
                return Container(
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(4, 4),
                        ),
                      ]),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ECZANE ${pharmacy.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.red.shade700),
                        ),
                        const SizedBox(height: 8),
                        Text("Adres: ${pharmacy.address}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tel: ${pharmacy.phone}"),
                            TextButton(
                              onPressed: () {
                                PharmacyService().openGoogleMaps(pharmacy.loc);
                              },
                              child: Text(
                                'Haritada Göster',
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    ));
  }

  Consumer<PharmacyProvider> districtFormField() {
    return Consumer<PharmacyProvider>(
      builder: (context, value, child) => DropdownButtonFormField(
        value: selectedDist,
        items: value.districts.map((District city) {
          return DropdownMenuItem<District>(
            value: city,
            child: Text(city.distName),
          );
        }).toList(),
        onChanged: (District? newValue) {
          selectedDist = newValue!;
          value.fetchPharmacyData(selectedCity!.name, newValue.distName);
        },
        decoration: const InputDecoration(
          labelText: 'İlçe seçiniz..',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  DropdownButtonFormField<Cities> cityFormField() {
    return DropdownButtonFormField<Cities>(
      items: Cities.values.map((Cities city) {
        return DropdownMenuItem<Cities>(
          value: city,
          child: Text(city.name),
        );
      }).toList(),
      onChanged: (Cities? newValue) async {
        selectedDist = null;
        Provider.of<PharmacyProvider>(context, listen: false)
            .fetchDistricts(newValue!.name);
        selectedCity = newValue;
      },
      decoration: const InputDecoration(
        labelText: 'İl Seçiniz',
        border: OutlineInputBorder(),
      ),
    );
  }
}
