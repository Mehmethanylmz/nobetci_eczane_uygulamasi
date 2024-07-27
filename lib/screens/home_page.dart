import 'package:flutter/material.dart';
import 'package:nobetcieczane/models/enums.dart';
import 'package:nobetcieczane/models/pharmacy_model.dart';
import 'package:nobetcieczane/services/pharmacy_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PharmacyModel> _pharmacy = [];
  City? selectedCity;
  Iller? selectedValue;
  List<City> _city = [];

  void _getCity(String city) async {
    _city.clear;
    selectedCity = null;
    setState(() {});
    _city = await PharmacyService().getCities(city);

    setState(() {});
  }

  void _getPharmacyData() async {
    _pharmacy = await PharmacyService()
        .getPharmacyData(selectedValue!.name, selectedCity!.name);
    setState(() {});
  }

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
                ilFormField(),
                const SizedBox(height: 10.0),
                ilceFormfield()
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
      child: ListView.builder(
        itemCount: _pharmacy.length,
        itemBuilder: (context, index) {
          final PharmacyModel pharmacy = _pharmacy[index];
          return Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(pharmacy.name),
          );
        },
      ),
    );
  }

  DropdownButtonFormField<Iller> ilFormField() {
    return DropdownButtonFormField<Iller>(
      items: Iller.values.map((Iller il) {
        return DropdownMenuItem<Iller>(
          value: il,
          child: Text(il.name),
        );
      }).toList(),
      onChanged: (Iller? newValue) async {
        selectedValue = newValue;
        _getCity(newValue!.name);
      },
      decoration: const InputDecoration(
        labelText: 'İl Seçiniz',
        border: OutlineInputBorder(),
      ),
    );
  }

  DropdownButtonFormField<City> ilceFormfield() {
    return DropdownButtonFormField(
      value: selectedCity,
      items: _city.map((City city) {
        return DropdownMenuItem<City>(
          value: city,
          child: Text(city.name),
        );
      }).toList(),
      onChanged: (City? newValue) {
        selectedCity = newValue!;
        _getPharmacyData();
      },
      decoration: const InputDecoration(
        labelText: 'İlçe seçiniz..',
        border: OutlineInputBorder(),
      ),
    );
  }
}
