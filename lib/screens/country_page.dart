import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_project/commons/color_constants.dart';

import '../main.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countries = [];
  bool isLoading = false;
  String? selectedCountry;

  Future<void> fetchCountries() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://countriesnow.space/api/v0.1/countries/population/cities',
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List allCountries = data["data"] ?? [];

        final Set<String> countrySet = {};
        for (var item in allCountries) {
          if (item['country'] != null) {
            countrySet.add(item['country']);
          }
        }
        setState(() {
          countries = countrySet.toList()..sort();
        });
      } else {
        print('failed to fetch ${response.body}');
      }
    } catch (e) {
      print('Error fetching countries $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.Background,
      appBar: AppBar(
        backgroundColor: ColorConstants.Background,
        title: Text(
          "Select Country",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose your country",
                      style: TextStyle(
                        color: ColorConstants.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                          width * 0.05,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                          value: selectedCountry,
                          isExpanded: true,
                          hint: Text("select a country"),
                          items: countries
                              .map(
                                (country) => DropdownMenuItem(
                                  value: country,
                                  child: Text(country),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCountry = value as String?;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    if (selectedCountry != null)
                      Center(
                        child: Text(
                          "You selected: $selectedCountry",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
