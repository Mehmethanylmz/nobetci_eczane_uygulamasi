import 'package:flutter/material.dart';
import 'package:nobetcieczane/models/enums.dart';
import 'package:nobetcieczane/models/pharmacy_model.dart';
import 'package:nobetcieczane/models/pharmacy_provider.dart';
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
          "Nöbetçi Eczane",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Image.asset(
          "assets/images/drugstore.png",
        ),
        centerTitle: true,
        backgroundColor: Colors.red[200],
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

  Consumer<PharmacyProvider> districtFormField() {
    return Consumer<PharmacyProvider>(builder: (context, value, child) =>  DropdownButtonFormField(
                value: selectedDist,
                items: value.districts.map((District city) {
                  return DropdownMenuItem<District>(
                    value: city,
                    child: Text(city.distName),
                  );
                }).toList(),
                onChanged: (District? newValue) {
                  selectedDist = newValue!;
                  value.setPharmacyData(selectedCity!.name,newValue.distName);
                  
                },
                decoration: const InputDecoration(
                  labelText: 'İlçe seçiniz..',
                  border: OutlineInputBorder(),
                ),
              ),);
  }

  Expanded detailsListView() {
    return Expanded(
        child: Consumer<PharmacyProvider>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value.pharmacy.length,
        itemBuilder: (context, index) {
          final PharmacyInformation pharmacy = value.pharmacy[index];
          return Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
            child: Text(
                "${pharmacy.name}\n${pharmacy.address}  ${pharmacy.phone}  ${pharmacy.loc}"),
          );
        },
      ),
    ));
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
        selectedDist=null;
        Provider.of<PharmacyProvider>(context, listen: false) 
            .setDistricts(newValue!.name);
          selectedCity  = newValue;
        PharmacyProvider().setDistricts(newValue.name);
        
      },
      decoration: const InputDecoration(
        labelText: 'İl Seçiniz',
        border: OutlineInputBorder(),
      ),
    );
  }
}
