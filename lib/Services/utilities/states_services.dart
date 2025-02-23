import 'dart:convert';

import 'package:covid_19/Modals/globalStates_modal.dart';
import 'package:covid_19/Services/utilities/app_urls.dart';

import 'package:http/http.dart' as http;

class StatesServices {
  Future<globalStates_modal> fetchWorldstatesRecords() async {
    final response = await http.get(Uri.parse(AppUrls.globalStates));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return globalStates_modal.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> Countrieslists() async {
    var data;
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    print("Fetching data from: $Uri");
    if (response.statusCode == 200) {
      print(AppUrls.CountrySpecificStatistics);
      data = jsonDecode(response.body);
      return data;
    } else {
      print("Error: ${response.statusCode}");
      throw Exception('Error');
    }
  }
}
